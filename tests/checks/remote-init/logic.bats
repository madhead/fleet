#!/usr/bin/env bats

@test "Zsh must be installed" {
  run zsh --version

  [[ $status -eq 0 ]]
}

@test "Git must be installed" {
  run git --version

  [[ $status -eq 0 ]]
}

@test "Vim must be installed" {
  run vim --version

  [[ $status -eq 0 ]]
}

@test "Vim must be installed" {
  run unzip -v

  [[ $status -eq 0 ]]
}

@test "madhead user must be created" {
  run id madhead

  [[ $status -eq 0 ]]
}

@test "madhead's shell must be Zsh" {
  [[ $(getent passwd madhead | cut -d: -f7) == "/bin/zsh" ]]
}

@test "root's shell must be Zsh" {
  [[ $(getent passwd root | cut -d: -f7) == "/bin/zsh" ]]
}

@test "Ensure /home/madhead/projects is a directory" {
  [[ -d /home/madhead/projects ]]
}

@test "Oh My Zsh configs must be cloned" {
  [[ -d /home/madhead/projects/oh-my-zsh ]]
  [[ $(stat -c "%U" /home/madhead/projects/oh-my-zsh) == "madhead" ]]
  [[ $(stat -c "%G" /home/madhead/projects/oh-my-zsh) == "madhead" ]]
  [[ -z $(git -C /home/madhead/Projects/oh-my-zsh status -s) ]]
}

@test "Dotfiles must be cloned" {
  [[ -d /home/madhead/projects/cfg ]]
  [[ $(stat -c "%U" /home/madhead/projects/cfg) == "madhead" ]]
  [[ $(stat -c "%G" /home/madhead/projects/cfg) == "madhead" ]]
  [[ -z $(git -C /home/madhead/projects/cfg status -s) ]]
}

@test ".zshrc must be configured for madhead" {
  [[ $(readlink /home/madhead/.zshrc) == "/home/madhead/projects/cfg/shell/.zshrc" ]]
  [[ $(stat -c "%U" /home/madhead/.zshrc) == "madhead" ]]
  [[ $(stat -c "%G" /home/madhead/.zshrc) == "madhead" ]]
}

@test ".zshrc must be configured for root" {
  [[ $(readlink /root/.zshrc) == "/home/madhead/projects/cfg/shell/.zshrc" ]]
  [[ $(stat -c "%U" /root/.zshrc) == "root" ]]
  [[ $(stat -c "%G" /root/.zshrc) == "root" ]]
}

@test ".zshenv must be configured for madhead" {
  grep -q "ZSH=/home/madhead/projects/oh-my-zsh" /home/madhead/.zshenv
  [[ $(stat -c "%U" /home/madhead/.zshenv) == "madhead" ]]
  [[ $(stat -c "%G" /home/madhead/.zshenv) == "madhead" ]]
}

@test ".zshenv must be configured for root" {
  grep -q "ZSH=/home/madhead/projects/oh-my-zsh" /root/.zshenv
  [[ $(stat -c "%U" /root/.zshenv) == "root" ]]
  [[ $(stat -c "%G" /root/.zshenv) == "root" ]]
}

@test "madhead must be added to sudoers" {
  [[ -d /etc/sudoers.d ]]
  [[ -f /etc/sudoers.d/madhead ]]
  [[ $(stat -c "%U" /etc/sudoers.d/madhead) == "root" ]]
  [[ $(stat -c "%G" /etc/sudoers.d/madhead) == "root" ]]
  [[ $(stat -c "%a" /etc/sudoers.d/madhead) == "440" ]]
  grep -q "madhead ALL=(ALL:ALL) ALL" /etc/sudoers.d/madhead
}

@test "Timezone should be Etc/UTC" {
  grep -q "Etc/UTC" /etc/timezone
}
