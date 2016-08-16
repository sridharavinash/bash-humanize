#!/bin/bash
# A simple script the humanizes the time echo-elapsed
# usage : ./bash-humanize <time_in_seconds>

echo-elapsed () {
  if [ $1 -gt 0 ]; then
    echo -n "$1 $2 "
  fi
}

is_leap_year () {
  year=$(date +%Y)

  if (( ("$year" % 400) == "0" )) || (( ("$year" %4) == "0" )) && (( ("$year" % 100) != 0 )); then
    return 0
  else
    return 1
  fi
}

time-humanize () {
  now=$(date +%s)

  if [ -z $1 ]; then
    in_seconds=now
  else
    in_seconds=$1
  fi

  #some time calc constants
  minutes_seconds=60
  hours_seconds=$(( 60 * $minutes_seconds ))

  days_seconds=$(( 24 * $hours_seconds ))

  days_month=$(cal -m `date +%m` | grep -v "^$" | tail -1 | grep -o "..$")
  months_seconds=$(( $days_month * $days_seconds ))

  if is_leap_year; then
    year_seconds=$(( 366 * $days_seconds ))
  else
    year_seconds=$(( 365 * $days_seconds ))
  fi

  elapsed_seconds=$(( $now  - $in_seconds ))
  if [ $elapsed_seconds -eq 0 ]; then
    echo "now"
    return
  fi

  elapsed_years=$(( $elapsed_seconds / $year_seconds ))
  remaining_seconds=$(( $elapsed_seconds % $year_seconds ))

  elapsed_months=$(( $remaining_seconds / $months_seconds ))
  remaining_seconds=$(( $remaining_seconds % $months_seconds ))

  elapsed_days=$(( $remaining_seconds / $days_seconds ))
  remaining_seconds=$(( $remaining_seconds % $days_seconds ))

  elapsed_hours=$(( $remaining_seconds / $hours_seconds ))
  remaining_seconds=$(( $remaining_seconds % $hours_seconds ))

  elapsed_minutes=$(( $remaining_seconds / $minutes_seconds  ))
  remaining_seconds=$(( $remaining_seconds % $minutes_seconds  ))

  #print the results
  echo-elapsed $elapsed_years "years"
  echo-elapsed $elapsed_months "months"
  echo-elapsed $elapsed_days "days"
  echo-elapsed $elapsed_hours "hours"
  echo-elapsed $elapsed_minutes "minutes"
  echo-elapsed $remaining_seconds "seconds"
  echo -n "ago"
  echo

}


time-humanize $@
