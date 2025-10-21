#!/bin/bash

set_powersave() {
  sudo cpupower frequency-set -r -g powersave

  pw-metadata -n settings 0 clock.quantum 1024

  notify-send "set cpu governor to powersave and quantum to 1024"
}

set_performance() {
  sudo cpupower frequency-set -r -g performance

  pw-metadata -n settings 0 clock.quantum 128

  notify-send "set cpu governor to performance and quantum to 128"
}

enable_smt() {
  # enable simultaneous multithreading
  echo on | sudo tee /sys/devices/system/cpu/smt/control
  notify-send "enable smt"
}

disable_smt() {
  # disable simultaneous multithreading
  echo off | sudo tee /sys/devices/system/cpu/smt/control
  notify-send "disable smt"
}

set_performance
bitwig-studio
trap "set_powersave; disable_smt" EXIT
