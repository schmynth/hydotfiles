#!/bin/bash

enable_smt() {
  # enable simultaneous multithreading
  echo on | sudo tee /sys/devices/system/cpu/smt/control
}

disable_smt() {
  # disable simultaneous multithreading
  echo off | sudo tee /sys/devices/system/cpu/smt/control
}

set_powersave() {
  sudo cpupower frequency-set -r -g powersave
  pw-metadata -n settings 0 clock.quantum 1024
  enable_smt
  notify-send "set cpu governor to powersave and quantum to 1024, enable smt"
}

set_performance() {
  sudo cpupower frequency-set -r -g performance
  pw-metadata -n settings 0 clock.quantum 128
  disable_smt
  notify-send "set cpu governor to performance and quantum to 128, disable_smt"
}

set_performance
bitwig-studio
trap "set_powersave" EXIT
