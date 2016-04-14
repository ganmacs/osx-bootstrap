#!/usr/bin/env bash

TMPFILE="/tmp/dotfiles.zip"
WORKSPACE="/tmp/dotfiles"

curl -LSfs -o ${TMPFILE} https://github.com/ganmacs/osx-bootstrap/archive/master.zip
unzip -oq ${TMPFILE} -d ${WORKSPACE}

pushd ${WORKSPACE}/osx-bootstrap-master > /dev/null

if [[ ! -d /usr/include ]]; then
  PLACEHOLDER=/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  touch $PLACEHOLDER
  PROD=$(softwareupdate -l | grep "\*.*Command Line" | head -n 1 | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n')
  softwareupdate -i "${PROD}"
  [[ -f $PLACEHOLDER ]] && rm $PLACEHOLDER
fi

which brew > /dev/null
if [ "$?" -ne 0 ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install ansible --HEAD
ansible-playbook -i localhost site.yml -K

popd > /dev/null

rm -rf ${TMPFILE} ${WORKSPACE}
