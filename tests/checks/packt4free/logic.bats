#!/usr/bin/env bats

@test "Ensure /opt/packt4free is a directory" {
  [[ -d /opt/packt4free ]]
  [[ $(stat -c "%U" /opt/packt4free) == "root" ]]
  [[ $(stat -c "%G" /opt/packt4free) == "root" ]]
}

@test "Ensure /opt/packt4free/packt4free is a correct symlink" {
  [[ $(readlink /opt/packt4free/packt4free) == "/opt/packt4free/packt4free-1.2.0" ]]
}

@test "Ensure /home/madhead/bin is a directory" {
  [[ -d /home/madhead/bin ]]
  [[ $(stat -c "%U" /home/madhead/bin) == "madhead" ]]
  [[ $(stat -c "%G" /home/madhead/bin) == "madhead" ]]
}

@test "Ensure wrapper script is created" {
  [[ -f /home/madhead/bin/packt4free.sh ]]
  [[ $(stat -c "%U" /home/madhead/bin/packt4free.sh) == "madhead" ]]
  [[ $(stat -c "%G" /home/madhead/bin/packt4free.sh) == "madhead" ]]
  [[ $(stat -c "%a" /home/madhead/bin/packt4free.sh) == "700" ]]
}

@test "Ensure crontab entry is created" {
  crontab -u madhead -l | grep -q '0 1 \* \* \* /home/madhead/bin/packt4free.sh'
}

@test "Ensure temporary file was removed" {
  [[ ! -f /tmp/packt4free-1.2.0.zip ]]
}
