#!/usr/bin/env bats

@test "Ensure /opt/java is a directory" {
  [[ -d /opt/java ]]
  [[ $(stat -c "%U" /opt/java) == "root" ]]
  [[ $(stat -c "%G" /opt/java) == "root" ]]
}

@test "Ensure /opt/java/java is a correct symlink" {
  [[ $(readlink /opt/java/java) == "/opt/java/jdk1.8.0_91" ]]
}

@test "Java must be installed" {
  run /opt/java/java/bin/java -version

  [[ $status -eq 0 ]]
}

@test "Ensure profile.d entry" {
  [[ -f /etc/profile.d/java.sh ]]
  [[ $(stat -c "%U" /etc/profile.d/java.sh) == "root" ]]
  [[ $(stat -c "%G" /etc/profile.d/java.sh) == "root" ]]
  [[ $(stat -c "%a" /etc/profile.d/java.sh) == "755" ]]
  grep -q "JAVA_HOME=\"/opt/java/java\"" /etc/profile.d/java.sh
  grep -q "export JAVA_HOME" /etc/profile.d/java.sh
  grep -q "export PATH=\"\${JAVA_HOME}/bin:\${PATH}\"" /etc/profile.d/java.sh
}

@test "Ensure temporary file was removed" {
  [[ ! -f /tmp/jdk-8u91-linux-x64.tar.gz ]]
}
