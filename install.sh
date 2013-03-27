#!/bin/bash -
###############################################################################
# File:          "install.sh"
#
# Description:   Install script for "Sgt Donowitz"
#
# Changes:       This script will:
#                -install JSHint globally on your machine
#                -setup a pre-commit script for your git project
#
# Prerequisites: NPM
#
###############################################################################

# Verifying pre-requisites:
EXIT_CODE=0
which npm &> /dev/null
EXIT_CODE=`expr ${EXIT_CODE} + $?`
if [[ ${EXIT_CODE} -ne 0 ]]; then
	echo ""
    echo " ----------------------------------------------- "
    echo "|    * * * CANNOT INSTALL SGT DONOWITZ * * *    |"
    echo "|                                               |"
    echo "| Please install NPM, as it is required:        |"
    echo "|                                               |"
    echo "| http://nodejs.org/download                    |"
    echo "|                                               |"
    echo " ----------------------------------------------- "	
    echo ""
    exit $((${EXIT_CODE}))
fi

which curl &> /dev/null
EXIT_CODE=`expr ${EXIT_CODE} + $?`
if [[ ${EXIT_CODE} -ne 0 ]]; then
	echo ""
    echo " ----------------------------------------------- "
    echo "|    * * * CANNOT INSTALL SGT DONOWITZ * * *    |"
    echo "|                                               |"
    echo "| Please install curl, as it is required:       |"
    echo "|                                               |"
    echo "| http://curl.haxx.se/docs/install.html         |"
    echo "|                                               |"
    echo " ----------------------------------------------- "	
    echo ""
    exit $((${EXIT_CODE}))
fi

# Ensure script is being run from within a GIT project:
ls -l .git &> /dev/null
EXIT_CODE=`expr ${EXIT_CODE} + $?`
if [[ ${EXIT_CODE} -ne 0 ]]; then
	echo ""
    echo " ----------------------------------------------- "
    echo "|    * * * CANNOT INSTALL SGT DONOWITZ * * *    |"
    echo "|                                               |"
    echo "| Please run this script from the root of your  |"
    echo "| GIT project.                                  |"
    echo "|                                               |"
    echo " ----------------------------------------------- "	
    echo ""
    exit 1
fi

# Ensure the script doesn't already contain a pre-commit script
EXIT_CODE=0
ls -l .git/hooks/pre-commit &> /dev/null
EXIT_CODE=`expr ${EXIT_CODE} + $?`
if [[ ${EXIT_CODE} -eq 0 ]]; then
	echo ""
    echo " ----------------------------------------------- "
    echo "|    * * * CANNOT INSTALL SGT DONOWITZ * * *    |"
    echo "|                                               |"
    echo "| This project already has a pre-commit script! |"
    echo "|                                               |"
    echo " ----------------------------------------------- "	
    echo ""
    exit 1
fi

# Installing JSHint if required
EXIT_CODE=0
which jshint &> /dev/null
EXIT_CODE=`expr ${EXIT_CODE} + $?`
if [[ ${EXIT_CODE} -ne 0 ]]; then
    echo "Installing JSHint..."
	npm install jshint -g
	EXIT_CODE=0
fi

# Ensure the script doesn't already contain a .jshintrc file
ls -l .jshintrc &> /dev/null
EXIT_CODE=`expr ${EXIT_CODE} + $?`
if [[ ${EXIT_CODE} -ne 0 ]]; then
	curl -o .jshintrc https://raw.github.com/tregoning/Sgt-Donowitz/master/.jshintrc
	EXIT_CODE=0
fi

# Ensure the script doesn't already contain a .jshintignore file
ls -l .jshintignore &> /dev/null
EXIT_CODE=`expr ${EXIT_CODE} + $?`
if [[ ${EXIT_CODE} -ne 0 ]]; then
	curl -o .jshintignore https://raw.github.com/tregoning/Sgt-Donowitz/master/.jshintignore
	EXIT_CODE=0
fi

curl -o .git/hooks/pre-commit https://raw.github.com/tregoning/Sgt-Donowitz/master/pre-commit
EXIT_CODE=`expr ${EXIT_CODE} + $?`

chmod +x .git/hooks/pre-commit
EXIT_CODE=`expr ${EXIT_CODE} + $?`

curl -o .git/hooks/reporter.js https://raw.github.com/tregoning/Sgt-Donowitz/master/reporter.js
EXIT_CODE=`expr ${EXIT_CODE} + $?`

if [[ ${EXIT_CODE} -ne 0 ]]; then
	echo ""
	echo " ----------------------------------------------- "
	echo "|         * * * INSTALLATION FAILED * * *       |"
	echo "|                                               |"
	echo "| Sorry, something went wrong...                |"
	echo "| Please perform a manual check                 |"
	echo "|                                               |"
	echo " ----------------------------------------------- "	
	echo ""
    exit $((${EXIT_CODE}))
else
	echo ""
	echo " ----------------------------------------------------------- "
	echo "|            * * * INSTALLATION COMPLETED   * * *           |"
	echo "|                                                           |"
	echo "|          Sgt Donowitz is ready to swing his bat!          |"
	echo "|                                                           |"
	echo "|   Please customise .jshintrc to you personal preferences: |"
	echo "|   http://www.jshint.com/docs/#enforcing_options           |"
	echo "|                                                           |"
	echo "|                                                           |"
	echo "|   Remember you can ignore files/folders simply by         |"
	echo "|   adding them to .jshintignore                            |"
	echo "|                                                           |"
	echo " ----------------------------------------------------------- "	
	echo ""
fi

