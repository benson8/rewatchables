#!/bin/sh
#
# Wrapper for the python script that does the real work.
# This is needed due to oddities with the tmdbv3api bailing
# out occasionally with DNS lookup failures that are intermittent.
# Splitting the CSV file of TDMB movie ids seems to alleviate this
# issue.
#

rewatchablesFile="rewatchables-tmdb-ids.csv"

split -l 50 ${rewatchablesFile} 
for i in xaa xab xac xad xae xaf
do
   ./rewatchables-on-netflix.py $i
done
rm -f xa*
