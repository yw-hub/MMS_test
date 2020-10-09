# Appointment API

<!-- @import "[TOC]" {cmd="toc" depthFrom=2 depthTo=2 orderedList=false} -->
<!-- code_chunk_output -->

* [List your appointment (304)](#list-your-appointment-304)
* [Get an appointment (304)](#get-an-appointment-304)
* [Get appointment note](#get-appointment-note)
* [Update appointment note](#update-appointment-note)
* [Delete appointment note](#delete-appointment-note)
* [Confirm an appointment](#confirm-an-appointment)
* [File (TBC)](#file-tbc)

<!-- /code_chunk_output -->

## List your appointment (304)
List appointments of the authenticated user

    GET /me/appointments

### Parameters

Name  | Type  | Description
----- | ----- | -----------
`since`  | `String`    | `Optional`. Represented as a string with a format of `YYYY-MM-DD`.
`until` |	`String`    | `Optional`. Represented as a string with a format of `YYYY-MM-DD`.
`is_confirmed` | `boolean` | `Optional`. Specify whether the appointment is confirmed.

### Response

    Status: 200 OK

```JSON
[
  {
    "date": "2018-06-12T10:30:00Z",
    "date_change": "2018-05-16T05:23:41Z",
    "date_create": "2018-05-16T05:23:41Z",
    "detail": "Education Session",
    "duration": 60,
    "id": "1",
    "note": "Looking after yourself during chemotherapy - Watch\nPatient Health History Sheet - Please fill in and email back to daychemo.wrD@ramsayhealth.com.au\nPharmacy Medication Sheet - Please fill in and email back to daychemo.wrp@ramsayhealth.com.au\nParking Information - ReadQuestions Sheet - Read",
    "status": "CONFIRMED",
    "title": "Day Oncology Unit",
    "uid": "1",
    "user_note": "user customised note"
  },
  {
    "date": "2018-06-08T08:00:00Z",
    "date_change": "2018-05-14T10:17:40Z",
    "date_create": "2018-05-14T10:17:40Z",
    "detail": "Inflisaport Insertion",
    "duration": 10,
    "id": "2",
    "note": "Warringal Private Hospital will contact you the day before to confirm admission and fasting times.\\nInfusaport Questionnaire - Please fill in and send back to reception@.66darebinst.com.au\\nDoctor Information - Read\\nProcedure Information - Read\\nAnaesthetists Information - Read",
    "status": "CONFIRMED",
    "title": "Warringal Private Hospital / Epworth Eastern",
    "uid": "1"
  }
]
```

## Get an appointment (304)

    GET /appointments/:appointment

### Response

    Status: 200 OK

```JSON
{
  "date": "2018-06-12T10:30:00Z",
  "date_change": "2018-05-16T05:23:41Z",
  "date_create": "2018-05-16T05:23:41Z",
  "detail": "Education Session",
  "duration": 60,
  "id": "1",
  "note": "Looking after yourself during chemotherapy - Watch\nPatient Health History Sheet - Please fill in and email back to daychemo.wrD@ramsayhealth.com.au\nPharmacy Medication Sheet - Please fill in and email back to daychemo.wrp@ramsayhealth.com.au\nParking Information - ReadQuestions Sheet - Read",
  "status": "CONFIRMED",
  "title": "Day Oncology Unit",
  "uid": "1"
}
```
## Get appointment note
Get the user note of a specific appointment.

    GET /appointments/:appointment/usernote

### Response

    Status: 200 OK

```JSON
{
  "id": "1",
  "user_note": "user customised note"
}
```

## Update appointment note
Update the user note of a specific appointment. Will return the updated appointment details on success.

    POST /appointments/:appointment/usernote

### Input

Name  | Type  | Description
----- | ----- | -----------
`user_note`  | `String`    | New user note

### Response

    Status: 200 OK

```JSON
{
  "date": "2018-06-12T10:30:00Z",
  "date_change": "2018-05-16T05:23:41Z",
  "date_create": "2018-05-16T05:23:41Z",
  "detail": "Education Session",
  "duration": 60,
  "id": "1",
  "note": "Looking after yourself during chemotherapy - Watch\nPatient Health History Sheet - Please fill in and email back to daychemo.wrD@ramsayhealth.com.au\nPharmacy Medication Sheet - Please fill in and email back to daychemo.wrp@ramsayhealth.com.au\nParking Information - ReadQuestions Sheet - Read",
  "status": "CONFIRMED",
  "title": "Day Oncology Unit",
  "uid": "1",
  "user_note": "Remember to bring scan result."
}
```

## Delete appointment note
Clear the user note of a specific appointment.

    DELETE /appointments/:appointment/usernote

### Response

    Status: 200 OK

```JSON
{ "message": "Success" }
```

## Confirm an appointment

    POST /appointments/:appointment/confirm

### Response

    Status: 200 OK

```JSON
{ "message": "Success" }
```

## File (TBC)

---
##### Annotation
* 304: Conditional request support in plan, may not available now.
