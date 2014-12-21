#!/bin/bash
#
# pulseaudio-ctl
#
# simple control of pulseaudio vol+/vol-/mute from the shell
# or more practically, from DE shortcut keys
#
# by graysky
# https://github.com/graysky2/pulseaudio-ctl


is_integer() {
  if [[ "$1" =~ ^[0-9]+$ ]]; then
    echo 1;
  else
    echo 0;
  fi
}


setup() {
  SINK=$(pacmd list-sinks|awk '/\* index:/{ print $3 }')
  SOURCE=$(pacmd list-sources|awk '/\* index:/{ print $3 }')
  PAVERSION=$(pulseaudio --version| sed 's/pulseaudio //')
  # this worked some versions of PA 4 but is no longer valid with v5
  # CURVOL=$(pacmd list-sinks|grep -A 15 '* index'| awk '/base volume: /{ print $5 }'|sed 's/%//')
  CURVOL=$(pacmd list-sinks|grep -A 15 '* index'| awk '/volume: front/{ print $5 }' | sed 's/%//g')
  MUTED=$(pacmd list-sinks|grep -A 15 '* index'|awk '/muted:/{ print $2 }')
  [[ "$MUTED" = "yes" ]] && MUTED="[m]" ||
    MUTED=""
  SOURCE_MUTED=$(pacmd list-sources|grep -A 15 '* index'|awk '/muted:/{ print $2 }')
  [[ "$SOURCE_MUTED" = "yes" ]] && SOURCE_MUTED="[sm]" ||
    SOURCE_MUTED=""

  # check that extracted vars are integers
  declare -A VARS_TO_CHECK
  VARS_TO_CHECK=([SINK]="default sink" [SOURCE]="default source" [CURVOL]="current volume")
  for v in "${!VARS_TO_CHECK[@]}"; do
    if [[ -n "${!v}" ]]; then
      [[ $(is_integer "${!v}") == '1' ]] || echo -e "Cannot determine ${VARS_TO_CHECK[$v]}."
    else
      return 0
    fi
  done
}

setup
    echo -e "$SOURCE_MUTED$MUTED$CURVOL%"
    exit 0
    ;;
esac

# vim:set ts=8 sts=2 sw=2 et: