#!/bin/sh

set -e



echo "do not print GITHUB_TOKEN because it is secret!"
echo TRAVIS_BRANCH:
echo ${TRAVIS_BRANCH}
echo TRAVIS_REPO_SLUG:
echo ${TRAVIS_REPO_SLUG}

# terminate if no GITHUB_TOKEN:
[ -z "${GITHUB_TOKEN}" ] && exit 0

# terminate if branch != master
[ "${TRAVIS_BRANCH}" != "master" ] && exit 0

git config --global user.email "boris.demeshev@gmail.com"
git config --global user.name "Boris Demeshev"

git clone -b gh-pages https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git book-output
cd book-output
cp -r ../_book/* ./

git add --all
# removed * at the end of the line

git commit -a -m "Update the book (${TRAVIS_BUILD_NUMBER})" || true

git push origin gh-pages
