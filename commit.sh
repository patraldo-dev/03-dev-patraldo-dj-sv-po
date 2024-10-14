#!/bin/bash
# Originally written May 9/05 by Mike Slinn

function help {
   echo "Runs git commit without prompting for a message."
   echo "Usage: commit [options] [file...]"
   echo "   Where options are:"
   echo "      -a \"tag message\""
   echo "      -d # enables debug mode"
   echo "      -m \"commit message\""
   echo "Examples:"
   echo "  commit  # The default commit message is just a single dash (-)"
   echo "  commit -m \"This is a commit message\""
   echo "  commit -a 0.1.2"
   exit 1
}

function isGitProject {
  cd "$( git rev-parse --git-dir )/.."
  [ -d .git ]
}


BRANCH="$(git rev-parse --abbrev-ref HEAD)"
MSG=""
while getopts "a:dhm:?" opt; do
   case $opt in
       a ) TAG="$OPTARG"
           git tag -a "$TAG" -m "v$TAG"
           git push origin --tags
           exit
           ;;
       d ) set -xv ;;
       m ) MSG="$OPTARG" ;;
       h ) help ;;
       \?) help ;;
   esac
done
shift "$((OPTIND-1))"


for o in "$@"; do
   if [ "$o" == "-m" ]; then unset MSG; fi
done

if isGitProject; then
  if [ "$@" ]; then
    git add -A "$@"
  else
    git add -A .
  fi
  shift
  if [ "$MSG" == "" ]; then MSG="-"; fi
  git commit -m "$MSG" "$@" 3>&1 1>&2 2>&3 | sed -e '/^X11/d'  | sed -e '/^Warning:/d'
  git push origin "$BRANCH" --tags 3>&1 1>&2 2>&3 | sed -e '/^X11/d'  | sed -e '/^Warning:/d'
else
  echo "Error: '$( pwd )' is not a git project"
fi

if [ -f 0 ]; then rm -f 0; fi
