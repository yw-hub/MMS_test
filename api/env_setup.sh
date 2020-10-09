#!/usr/bin/env bash
# Shell script for automatic modify config files for remote environments
# Execute this script before build the project
# Requires 2 arguments: Username and Password for the remote database.

# Init parameters
URL="jdbc:mysql://DB?serverTimezone=UTC"
USERNAME="${1}"
PASSWORD="${2}"
VERSION_STRING="Automatically built and deployed. Build date: `date`"

# Get directory containing this script
HEAD_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SRC_DIR=$HEAD_DIR/src/main
RES_DIR=$SRC_DIR/resources
WEBAPP_DIR=$SRC_DIR/webapp

CONFIG_FILE_NAME=config.properties
DBCP_SAMPLE_NAME=dbcp_sample.properties
DBCP_FILE_NAME=dbcp.properties

cd $RES_DIR

# Create remote database profile
rm -f $DBCP_FILE_NAME
cp $DBCP_SAMPLE_NAME $DBCP_FILE_NAME

# Modify DBCP Configs
sed -i -e 's/\[username\]/'"$USERNAME"'/' ./$DBCP_FILE_NAME
sed -i -e 's/\[password\]/'"$PASSWORD"'/' ./$DBCP_FILE_NAME
sed -i -e 's|\(^url=\).*$|\1'"$URL"'|' ./$DBCP_FILE_NAME

# Modify General Config
# Switch the Database profile to remote one.
sed -i -e 's/\(^.*USE_DEV_DATABASE_PROFILE = \).*$/\1false/' ./$CONFIG_FILE_NAME

# Apply timestamp in the index page
cd $WEBAPP_DIR
sed -i -e 's/\(<small id="version">\).*\(<\/small>\)/\1'"$VERSION_STRING"'\2/' ./index.jsp
