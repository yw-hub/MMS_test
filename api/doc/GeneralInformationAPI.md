# General Information API

<!-- @import "[TOC]" {cmd="toc" depthFrom=2 depthTo=2 orderedList=false} -->
<!-- code_chunk_output -->
You can use this set of APIs to access the general information about the hospital, the doctor, the radiology and the pathology.
* [List doctor resources ( R, 304 )](#list-doctor-resources-r-304)
* [List hospital resources ( R, 304 )](#list-hospital-resources-r-304)
* [List pathology resources ( R, 304 )](#list-pathology-resources-r-304)
* [List radiology resources ( R, 304 )](#list-radiology-resources-r-304)
* [List one doctor/ hospital/ pathology/ radiology resource ( R, 304 )](#list-doctor-resources-r-304)
* [Add one doctor/ hospital/ pathology/ radiology resource (C)](#list-doctor-resources-r-304)
* [Update one doctor/ hospital/ pathology/ radiology resource (U)](#list-doctor-resources-r-304)
* [Delete one doctor/ hospital/ pathology/ radiology resource (D)](#list-doctor-resources-r-304)



## List doctor resources ( R, 304 )
**Note:** This API requires the token to be sent together with the resource url, as a part of the request header.

    GET /generalInformation/doctors

**Example Request:**
    
    GET http://localhost:8080/api/generalInformation/doctors
    
**Example Response:**

    HTTP/1.1 200 
    Content-Type: application/json
    
    
    [
      {
        "address": "66 Darebin Street, Heidelberg VIC 3084",
        "contact": "(03) 9458 5199",
        "email": "eception@66darebinst.com.au",
        "expertise": "Pancreatic cancer, gallbladder cancer",
        "id": 1,
        "name": "A/Prof Niall Tebbutt",
        "website": "www.darebinstspecialistcentre.com.au"
      },
      {
        "address": "267 Collins St, Melbourne VIC 3000",
        "contact": "(03) 9654 6088",
        "email": "Mehrdad@example.com",
        "expertise": "Rectal cancer",
        "id": 2,
        "name": "Mr Mehrdad Nikfarjam",
        "website": "https://collinsstmedicalcentre.com.au"
      }
    ]

## List hospital resources ( R, 304 )
**Note:** This API requires the token to be sent together with the resource url, as a part of the request header.

    GET /generalInformation/hospitals

**Example Request:**
    
    GET http://localhost:8080/api/generalInformation/hospitals
    
**Example Response:**
    
    HTTP/1.1 200 
    Content-Type: application/json
    
    
    [
      {
        "address": "14-20 Blackwood St, North Melbourne VIC 3195",
        "contact": "(03) 8373 7600",
        "fax": "(03) 9328 5803",
        "id": 1,
        "name": "Australian Prostate Centre",
        "type": "Cancer Treatment Center",
        "website": "australianprostatecentre.org.au"
      },
      {
        "address": "1/84 Bridge Rd, Richmond VIC 3121",
        "contact": "(03) 9421 6425",
        "fax": "(03) 9421 6372",
        "id": 2,
        "name": "Cancer Specialists",
        "type": "Cancer Treatment Center",
        "website": "cancerspecialists.com.au"
      }
    ]
    
## List pathology resources ( R, 304 )
**Note:** This API requires the token to be sent together with the resource url, as a part of the request header.

    GET /generalInformation/pathologies

**Example Request:**
    
    GET http://localhost:8080/api/generalInformation/pathologies
    
**Example Response:**

    HTTP/1.1 200 
    Content-Type: application/json
    
    
    [
      {
        "address": "265 Faraday St, Carlton VIC 3053",
        "contact": "(03) 9250 0300",
        "fax": "",
        "id": 1,
        "name": "VCS Pathology",
        "website": "http://www.vcspathology.org.au/"
      },
      {
        "address": "292 Swanston St, Melbourne VIC 3000",
        "contact": "(03) 9654 2214",
        "fax": "(03) 9650 9241",
        "id": 2,
        "name": "Melbourne Pathology",
        "website": "http://mps.com.au/"
      }
    ]
## List radiology resources ( R, 304 )
**Note:** This API requires the token to be sent together with the resource url, as a part of the request header.

    GET /generalInformation/radiologies

**Example Request:**
    
    GET http://localhost:8080/api/generalInformation/radiologies
    
**Example Response:**

    HTTP/1.1 200 
    Content-Type: application/json
    
    
    [
      {
        "address": "100 Victoria Parade, East Melbourne VIC 3002",
        "contact": "(03) 9667 1667",
        "fax": "(03) 9667 1666",
        "id": 1,
        "name": "Melbourne Radiology Clinic",
        "website": "melbourneradiology.com.au"
      },
      {
        "address": "25/292 Swanston St, Melbourne VIC 3000",
        "contact": "(03) 9639 7269",
        "fax": "",
        "id": 2,
        "name": "MIA Radiology",
        "website": "miaradiology.com.au"
      }
    ]

## List one doctor/hospital/pathology/radiology resource ( R, 304 )
**Note:** This API requires the token to be sent together with the resource url, as a part of the request header.

    GET generalInformation/oneDoctor/{doctorID}
    GET generalInformation/oneHospital/{hospitalID}
    GET generalInformation/onePathology/{pathologyID}
    GET generalInformation/oneRadiology/{radiologyID}

**Example Requests:**
    
    GET http://localhost:8080/api/generalInformation/oneDoctor/1
    GET http://localhost:8080/api/generalInformation/oneHospital/1
    GET http://localhost:8080/api/generalInformation/onePathology/1
    GET http://localhost:8080/api/generalInformation/oneRadiology/1
    
**Example Response (the respond json objects may be slightly different due to the different entities):**

    HTTP/1.1 200 
    Content-Type: application/json   
    
    <--doctor json object-->

      {
        "address": "66 Darebin Street, Heidelberg VIC 3084",
        "contact": "(03) 9458 5199",
        "email": "eception@66darebinst.com.au",
        "expertise": "Pancreatic cancer, gallbladder cancer",
        "id": "1",
        "name": "A/Prof Niall Tebbutt",
        "website": "www.darebinstspecialistcentre.com.au"
      }
      
    <--hospital json object-->
      {
        "address": "14-20 Blackwood St, North Melbourne VIC 3195",
        "contact": "(03) 8373 7600",
        "fax": "(03) 9328 5803",
        "id": "1",
        "name": "Australian Prostate Centre",
        "type": "Cancer Treatment Center",
        "website": "australianprostatecentre.org.au"
      }
    
    <--pathology json object-->
      {
        "address": "265 Faraday St, Carlton VIC 3053",
        "contact": "(03) 9250 0300",
        "fax": "",
        "id": "1",
        "name": "VCS Pathology",
        "website": "http://www.vcspathology.org.au/"
      }
      
    <--radiology json object-->
      {
        "address": "100 Victoria Parade, East Melbourne VIC 3002",
        "contact": "(03) 9667 1667",
        "fax": "(03) 9667 1666",
        "id": "1",
        "name": "Melbourne Radiology Clinic",
        "website": "melbourneradiology.com.au"
      }
      
## Add one doctor/hospital/pathology/radiology resource (C)
**Note:** This API requires the token to be sent together with the resource url, as a part of the request header.

    POST /generalInformation/addDoctor
    POST /generalInformation/addHospital
    POST /generalInformation/addPathology
    POST /generalInformation/addRadiology
    Content-Type: application/json
    {
      json object content
    }

**Example Request(the post json objects may be slightly different due to the different entities):**
    
    <--doctor json object-->
    POST http://localhost:8080/api/generalInformation/addDoctor
    Content-Type: application/json
    {
      "id": "9",
      "name": "dName",
      "address": "dAddress",
      "contact": "dContact",
      "email": "dEmail",
      "website":"dWebsite",
      "expertise": "Pancreatic cancer"
    }
    
    <--hospital json object-->
        POST http://localhost:8080/api/generalInformation/addHospital
        Content-Type: application/json
        {
          "id": "9",
          "name": "dName",
          "contact": "dContact",
          "address": "dAddress",
          "fax": "dFax",
          "website":"dWebsite",
          "type": "Skin Care Clinic"
        }
    
    <--pathology json object-->
            POST http://localhost:8080/api/generalInformation/addPathology
            Content-Type: application/json
            {
              "id": "9",
              "name": "pName",
              "address": "pAddress",
              "contact": "pContact",
              "website":"pWebsite",
              "fax":"pFax"
            }
            
    <--radiology json object-->
            POST http://localhost:8080/api/generalInformation/addRadiology
            Content-Type: application/json
            {
              "id": "9",
              "name": "rName",
              "address": "rAddress",
              "contact": "rContact",
              "website":"rWebsite",
              "fax":"rFax"
            }
    
**Example Response:**

    HTTP/1.1 200 
    Content-Type: application/json   
       
      {
        "message": "Success"
      }

## Update one doctor/hospital/pathology/radiology resources (U)
**Note:** This API requires the token to be sent together with the resource url, as a part of the request header.

    PUT /generalInformation/updateDoctor
    PUT /generalInformation/updateHospital
    PUT /generalInformation/updatePathology
    PUT /generalInformation/updateRadiology
    Content-Type: application/json
    {
      json object content
    }

**Example Request(put json objects may be slight different):**
    
    <--doctor put json object-->
        POST http://localhost:8080/api/generalInformation/updateDoctor
        Content-Type: application/json
        {
          "id": "9",
          "name": "dName9",
          "address": "dAddress9",
          "contact": "dContact9",
          "email": "dEmail9",
          "website":"dWebsite9",
          "expertise": "Pancreatic cancer"
        }
        
        <--hospital put json object-->
            POST http://localhost:8080/api/generalInformation/updateHospital
            Content-Type: application/json
            {
              "id": "9",
              "name": "dName9",
              "contact": "dContact9",
              "address": "dAddress9",
              "fax": "dFax9",
              "website":"dWebsite9",
              "type": "Skin Care Clinic"
            }
        
        <--pathology put json object-->
                POST http://localhost:8080/api/generalInformation/updatePathology
                Content-Type: application/json
                {
                  "id": "9",
                  "name": "pName9",
                  "address": "pAddress9",
                  "contact": "pContact9",
                  "website":"pWebsite9",
                  "fax":"pFax9"
                }
                
        <--radiology put json object-->
                POST http://localhost:8080/api/generalInformation/updateRadiology
                Content-Type: application/json
                {
                  "id": "9",
                  "name": "rName9",
                  "address": "rAddress9",
                  "contact": "rContact9",
                  "website":"rWebsite9",
                  "fax":"rFax9"
                }
    
    
**Example Response:**

    HTTP/1.1 200 
    Content-Type: application/json   
       
      {
        "message": "Success"
      }
      
## Delete one doctor/hospital/pathology/radiology resources (D)
**Note:** This API requires the token to be sent together with the resource url, as a part of the request header.

    PUT /generalInformation/deleteDoctor/{doctorID}
    PUT /generalInformation/updateHospital/{hospitalID}
    PUT /generalInformation/updatePathology/{pathologyID}
    PUT /generalInformation/updateRadiology/{radiologyID}

**Example Request(put json objects may be slight different):**
    
    PUT http://localhost:8080/api/generalInformation/deleteDoctor/9
    PUT http://localhost:8080/api/generalInformation/deleteHospital/9
    PUT http://localhost:8080/api/generalInformation/deletePathology/9
    PUT http://localhost:8080/api/generalInformation/deleteRadiology/9
    
    
**Example Response:**

    HTTP/1.1 200 
    Content-Type: application/json   
       
      {
        "message": "Success"
      }