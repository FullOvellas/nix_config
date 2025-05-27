from collections.abc import Generator
import subprocess
import time
import json
import signal
import sys

# Customization settings
GLYPH_FONT_FAMILY = "Symbols Nerd Font Mono"
GLYPHS = {
    "paused": "",
    "playing": "",
    "stopped": ""
}
DEFAULT_GLYPH = ""
TEXT_WHEN_STOPPED = "Nothing playing right now"
SCROLL_TEXT_LENGTH = 50
REFRESH_INTERVAL = 0.4
PLAYERCTL_BIN = "/etc/profiles/per-user/fullovellas/bin/playerctl"
PLAYER_STATE_FILE = "/tmp/waybar_player_state.txt"

def get_available_players() -> list[str]:
    try:
        result = subprocess.run([PLAYERCTL_BIN, '-l'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        players = result.stdout.decode('utf-8').strip().splitlines()
        return players
    except:
        return []


def get_current_player(players: list[str]) -> str:
    try:
        with open(PLAYER_STATE_FILE, "r") as f:
            index = int(f.read().strip())
            return players[index % len(players)]
    except:
        return players[0] if players else "spotify"


def set_next_player(players: list[str]):
    try:
        with open(PLAYER_STATE_FILE, "r") as f:
            index = int(f.read().strip()) + 1
    except:
        index = 1
    with open(PLAYER_STATE_FILE, "w") as f:
        _ = f.write(str(index % len(players)))


should_switch_player = False
should_toggle_play = False

def handle_switch_signal(_signum, _frame):
    global should_switch_player
    should_switch_player = True

def handle_toggle_signal(_signum, _frame):
    global should_toggle_play
    should_toggle_play = True

# Register signal handlers
_ = signal.signal(signal.SIGRTMIN + 10, handle_switch_signal)  # Right-click: switch player
_ = signal.signal(signal.SIGRTMIN + 11, handle_toggle_signal)  # Left-click: toggle play/pause

def get_player_status(player: str):
    try:
        result = subprocess.run([PLAYERCTL_BIN, '-p', player, 'status'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        status = result.stdout.decode('utf-8').strip().lower()
        if result.returncode != 0 or not status:
            return "stopped"
        return status
    except:
        return "stopped"


def get_current_song(player: str):
    try:
        result = subprocess.run([
            PLAYERCTL_BIN, '-p', player, 'metadata',
            '--format', "󰎇 {{xesam:title}} 󰠃 {{xesam:artist}} 󰀥 {{xesam:album}}'''{{duration(position)}}"
        ], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        song_title = result.stdout.decode('utf-8').strip()
        if result.returncode != 0 or not song_title:
            return None
        return song_title
    except:
        return None


def scroll_text(text: str, length: int = SCROLL_TEXT_LENGTH) -> Generator[str, None, None]:
    text = text.ljust(length)
    scrolling_text = text + ' ' + text[:length]
    for i in range(len(scrolling_text) - length):
        yield scrolling_text[i:i + length]


if __name__ == "__main__":
    scroll_generator = None

    while True:
        output = {}

        try:
            players = get_available_players()
            if not players:
                output['text'] = f"<span font_family='{GLYPH_FONT_FAMILY}'></span> No players"
                print(json.dumps(output), end='\n')
                time.sleep(REFRESH_INTERVAL)
                continue

            if should_switch_player:
                set_next_player(players)
                should_switch_player = False

            player = get_current_player(players)

            if should_toggle_play:
                try:
                    _ = subprocess.run([PLAYERCTL_BIN, '-p', player, 'play-pause'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
                except Exception as e:
                    pass  # Ignore errors silently or log if needed
                should_toggle_play = False

            status = get_player_status(player)
            song = get_current_song(player)

            glyph = GLYPHS.get(status, DEFAULT_GLYPH)

            if song:
                split_song = str(song).split("'''", 1)
                song = split_song[0]
                song_position = split_song[1] if len(split_song) > 1 else ""
                if len(song) > SCROLL_TEXT_LENGTH:
                    if scroll_generator is None:
                        scroll_generator = scroll_text(song)
                    try:
                        scroll_part = next(scroll_generator)
                    except StopIteration:
                        scroll_generator = scroll_text(song)
                        scroll_part = next(scroll_generator)
                    song_text = f"{scroll_part} {song_position}"
                else:
                    song_text = song + ' ' + song_position
                    scroll_generator = None
            else:
                song_text = TEXT_WHEN_STOPPED.ljust(len(TEXT_WHEN_STOPPED))

            output['text'] = f"<span font_family='{GLYPH_FONT_FAMILY}'>{glyph}</span> {song_text}"

        except Exception as e:
            output['text'] = f"<span font_family='{GLYPH_FONT_FAMILY}'></span> Error: {str(e)}".ljust(SCROLL_TEXT_LENGTH + 2)

        print(json.dumps(output), end='\n')
        _ = sys.stdout.flush()
        time.sleep(REFRESH_INTERVAL)

