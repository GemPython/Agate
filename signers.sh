#! /bin/bash

set -o errexit

#git fetch --all

rm -rf Agreements

if git checkout -- .
then
    :
fi

if git rm --cached -r Agreements
then
    :
fi

if git branch -D signed
then
    git checkout --orphan signed
fi

git reset --hard gem/Rhodolite_agreement

git merge --no-commit amit/AmitGreen_agreement
amit=`cat .git/MERGE_HEAD`
git stash

git merge --no-commit mike/misha354_agreement
mike=`cat .git/MERGE_HEAD`
git stash

git stash pop
git stash pop

echo $amit >>.git/MERGE_HEAD
echo $mike >>.git/MERGE_HEAD

git commit -m 'Merged signatures'
