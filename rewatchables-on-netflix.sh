#!/bin/sh
#
# Wrapper for the python script that does the real work.
# This is needed due to oddities with the tmdbv3api bailing
# out occasionally with DNS lookup failures that are intermittent.
# Splitting the CSV file of TDMB movie ids seems to alleviate this
# issue.
#

env

if [ -z "${TMDB_API_KEY}" ]
then
   echo "TMDB_API_KEY environment variable is not set, exiting...."
   exit 1
fi

if [ -z "${GH_TOKEN}" ]
then
   echo "GH_TOKEN is not set, exiting...."
   exit 1
fi

rewatchablesFile="rewatchables-tmdb-ids.csv"
availableOnNetFlixFile="available/available-on-netflix.txt"
lastRun=`date`
echo "Rewatchables Films Available On Netflix in the U.S. (as of ${lastRun})" | tee ${availableOnNetFlixFile}
echo "=======================================" | tee -a ${availableOnNetFlixFile}

split -l 50 ${rewatchablesFile} 
for i in xaa xab xac xad xae xaf
do
   ./rewatchables-on-netflix.py $i
done
rm -f xa*

dir="available"

# update the file
curl -i -X PUT -H "Authorization: token ${GH_TOKEN}" -d "{\"path\": \"available-on-netflix.txt\", \
\"message\": \"latest run on ${lastRun}\", \"content\": \"$(openssl base64 -A -in $dir/available-on-netflix.txt)\", \"branch\": \"main\",\
\"sha\": $(curl -X GET https://api.github.com/repos/benson8/rewatchables/contents/available/available-on-netflix.txt | jq .sha)}" \
https://api.github.com/repos/benson8/rewatchables/contents/available/available-on-netflix.txt

