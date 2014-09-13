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
	EXIT_CODE=0
	sudo npm install jshint -g
	EXIT_CODE=`expr ${EXIT_CODE} + $?`
	if [[ ${EXIT_CODE} -ne 0 ]]; then
		echo ""
	    echo " ----------------------------------------------- "
	    echo "|    * * * CANNOT INSTALL SGT DONOWITZ * * *    |"
	    echo "|                                               |"
	    echo "| There was a problem installing JSHint...      |"
	    echo "|                                               |"
	    echo " ----------------------------------------------- "
	    echo ""
	    exit ${EXIT_CODE}
	fi
fi

# Ensure the script doesn't already contain a .jshintrc file
ls -l .jshintrc &> /dev/null
EXIT_CODE=`expr ${EXIT_CODE} + $?`
if [[ ${EXIT_CODE} -ne 0 ]]; then
	EXIT_CODE=0
	curl -f -o .jshintrc https://raw.githubusercontent.com/jshint/jshint/master/examples/.jshintrc
	EXIT_CODE=`expr ${EXIT_CODE} + $?`
	if [[ ${EXIT_CODE} -ne 0 ]]; then
		#if jshint sample file has been moved/deleted
		EXIT_CODE=0
		curl -f -o .jshintrc https://raw.githubusercontent.com/tregoning/Sgt-Donowitz/master/.jshintrc
		EXIT_CODE=`expr ${EXIT_CODE} + $?`
		if [[ ${EXIT_CODE} -ne 0 ]]; then
			echo ""
			echo " ----------------------------------------------- "
			echo "|    * * * CANNOT INSTALL SGT DONOWITZ * * *    |"
			echo "|                                               |"
			echo "| There was a problem creating a file.          |"
			echo "|                                               |"
			echo "| most likely this is a permission problem      |"
			echo "| try running the script with sudo perhaps?     |"
			echo "|                                               |"
			echo " ----------------------------------------------- "
			echo ""
			exit ${EXIT_CODE}
		fi

	fi
fi

# Ensure the script doesn't already contain a .jshintignore file
ls -l .jshintignore &> /dev/null
EXIT_CODE=`expr ${EXIT_CODE} + $?`
if [[ ${EXIT_CODE} -ne 0 ]]; then
	EXIT_CODE=0
	touch .jshintignore
	EXIT_CODE=`expr ${EXIT_CODE} + $?`
	if [[ ${EXIT_CODE} -ne 0 ]]; then
		echo ""
	    echo " ----------------------------------------------- "
	    echo "|    * * * CANNOT INSTALL SGT DONOWITZ * * *    |"
	    echo "|                                               |"
	    echo "| There was a problem creating a file.          |"
	    echo "|                                               |"
	    echo "| most likely this is a permission problem      |"
	    echo "| try running the script with sudo perhaps?     |"
	    echo "|                                               |"
	    echo " ----------------------------------------------- "
	    echo ""
	    exit ${EXIT_CODE}
	fi
fi

curl -o .git/hooks/pre-commit https://raw.githubusercontent.com/tregoning/Sgt-Donowitz/master/pre-commit
EXIT_CODE=`expr ${EXIT_CODE} + $?`
if [[ ${EXIT_CODE} -ne 0 ]]; then
	echo ""
    echo " ----------------------------------------------- "
    echo "|    * * * CANNOT INSTALL SGT DONOWITZ * * *    |"
    echo "|                                               |"
    echo "| There was a problem creating a file.          |"
    echo "|                                               |"
    echo "| most likely this is a permission problem      |"
    echo "| try running the script with sudo perhaps?     |"
    echo "|                                               |"
    echo " ----------------------------------------------- "
    echo ""
    exit ${EXIT_CODE}
fi

chmod +x .git/hooks/pre-commit
EXIT_CODE=`expr ${EXIT_CODE} + $?`
if [[ ${EXIT_CODE} -ne 0 ]]; then
	echo ""
    echo " ----------------------------------------------- "
    echo "|    * * * CANNOT INSTALL SGT DONOWITZ * * *    |"
    echo "|                                               |"
    echo "| There was a problem given executable rights   |"
    echo "| to the pre-commit script                      |"
    echo "|                                               |"
    echo "| most likely this is a permission problem      |"
    echo "| try running the script with sudo perhaps?     |"
    echo "|                                               |"
    echo " ----------------------------------------------- "
    echo ""
    exit ${EXIT_CODE}
fi

curl -o .git/hooks/reporter.js https://raw.githubusercontent.com/tregoning/Sgt-Donowitz/master/reporter.js
EXIT_CODE=`expr ${EXIT_CODE} + $?`
if [[ ${EXIT_CODE} -ne 0 ]]; then
	echo ""
    echo " ----------------------------------------------- "
    echo "|    * * * CANNOT INSTALL SGT DONOWITZ * * *    |"
    echo "|                                               |"
    echo "| There was a problem creating a file.          |"
    echo "|                                               |"
    echo "| most likely this is a permission problem      |"
    echo "| try running the script with sudo perhaps?     |"
    echo "|                                               |"
    echo " ----------------------------------------------- "
    echo ""
    exit ${EXIT_CODE}
fi

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

