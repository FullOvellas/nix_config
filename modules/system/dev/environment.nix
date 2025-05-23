{ pkgs, ... }:
{
  environment.sessionVariables = rec {
    JAVA_8_HOME = "${pkgs.jdk8}";
    JAVA_21_HOME = "${pkgs.temurin-bin-21}";
    JAVA_HOME = JAVA_21_HOME;
    MAVEN_OPTS = "-Dfile.encoding=UTF-8 -Xmx512m -Djava.net.preferIPv4Stack=true";
    CODELLDB = "${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
  };
}
