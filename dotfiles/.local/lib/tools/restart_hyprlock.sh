#!/bin/sh

# this is a script that can be called, when the oopsie daisy screen happens

hyprctl --instance 0 'keyword misc:allow_session_lock_restore 1'

hyprctl --instance 0 'dispatch exec hyprlock'
