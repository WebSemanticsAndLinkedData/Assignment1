#!/bin/bash

username=$(curl -s -H "Authorization: token ${TOKEN}" -X GET "https://api.github.com/repos/${SEMAPHORE_REPO_SLUG}/pulls/${PULL_REQUEST_NUMBER}" | jq -r '.user.login')

if [ $username == "null" ]; then
  echo "Could not create report. Username is null."
  exit 1
fi

git config --global user.email "LinkedDataCommenter@yandex.com"
git config --global user.name "LinkedDataCommenter"

git clone https://github.com/WebServicesAndLinkedData/Assignment1.git
cd Assignment1
echo "Assignment 1, Submitted" >> $username.csv
git add $username.csv
git commit -m "[ci skip] $username report updated"
git push https://LinkedDataCommenter:$TOKEN@github.com/WebServicesAndLinkedData/Assignment1.git &> /dev/null
