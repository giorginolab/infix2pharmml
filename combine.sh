#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

c=$DIR/convert.pl

if [[ $# -ne 2 ]]; then
    cat <<EOF
Use infix2pharmml to convert a structural model (in standalone mode)
and merge in function definitions, also converted one per line.

Usage: $0 <model.infix> <functions.infix> > model.pharmml
 - <model.infix>     should contain the structural equations
 - <functions.infix> should contain the function definitions

EOF
    exit
fi

tmp=`mktemp`
mod=$1
fun=$2


# Convert function definitions, one line at a time
while read line
do
  if [[ ! ($line =~ ^#) ]]; then
      perl $c "$line" >> $tmp
  fi
done < $fun


# Gobble the structural model and convert it, merging functions
perl $c -s < $mod | \
    sed "/<!-- Insert FunctionDefinition here -->/ r $tmp" 

rm $tmp
