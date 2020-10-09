# Medical Secretary RESTful API

## Overview

## Getting Started

###### Prerequisites:

* Java 1.8
* Maven 3

First download the source to your local machine using Git:

    $ git clone https://bitbucket.cis.unimelb.edu.au:8445/scm/swen90013/swen90013-2018-me.git
   
    
## Configuration
**Note: You should exclude your database profiles from VCS as they may contains sensitive information**

First you need to configure DBCP profiles.

Go to the properties directory and copy the sample profile `dbcp_sample.properties`:

    $ cd swen90013-2018-me/src/main/resources/
    $ cp dbcp_sample.properties dbcp_local.properties
    
Open and edit the new profile:

    $ nano dbcp_local.properties
    
It will looks like:

    # Connection Info
    # [endpoint]: replace with database url / ip
    # [port]: replace with database port
    # [dbname]: replace with the name of desired database
    url=jdbc:mysql://[endpoint]:[port]/[dbname]?serverTimezone=UTC
    
    # Credentials
    username=[username]
    password=[password]

Change these properties to reflect your own database info.

You can create 2 database profiles, `dbcp_local.properties` and `dbcp.properties`.
One for local dev / testing, the other for remote deploy.
Edit `config.properties` to switch between them:

    $ nano config.properties
    
Change this property or (un)comment the whole line to switch between the two profile.

    USE_DEV_DATABASE_PROFILE = true

## Build with Maven
Build and run integration tests as follows:

    $ mvn clean install

This will compile the project and pack all the packages. The built artifact `medsec.war` will be generated in `target` directory.

## Deploy to Tomcat
Go to your tomcat home directory. Remove previous deployed application in `webapps`:

    $ rm webapps/medsec.war
    $ rm -rf webapps/medsec

Clear tomcat runtime temporary files:

    $ rm -rf work/Catalina
    
Then copy the built artifact `medsec.war` to `webapps` directory.

Start your tomcat:

    $ bin/catalina.sh run

Access the API at:

    http://localhost:8080/medsec

## Working with IntelliJ IDEA 

## Credit
