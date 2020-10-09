# GENIE Script
GENIE script to pull data from the GENIE 4D Database and push to local database.
##### Prerequisites:
* GSON 2.8.4
* JUnit 4.12
* JSONSimple 1.1
* MySQL 8.0.11
* Maven

First download the source to your local machine using Git:
    
    git clone https://wpan1@bitbucket.cis.unimelb.edu.au:8445/scm/swen90013/swen90013-2018-megs.git
    
##### Build with Maven
Build and run as follows:

    mvn clean compile assembly:single
    cd target
    java -jar GENIEUpdateClient.jar
   
##### Working with IntelliJ IDEA 