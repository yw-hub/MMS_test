# Authentication API

You can use this API to manage your account authentication status.

<!-- @import "[TOC]" {cmd="toc" depthFrom=2 depthTo=2 orderedList=false} -->
<!-- code_chunk_output -->

* [Login](#login)
* [Logout](#logout)
* [Renew a token](#renew-a-token)
* [Revoke all existing tokens](#revoke-all-existing-tokens)

<!-- /code_chunk_output -->

### Token Schema
The server issues and claim JSON Web Tokens (JWTs) as defined in [RFC7519](https://tools.ietf.org/html/rfc7519). The clients are able to parse the token they have been granted to get the payload. All tokens issued by server are simultaneously valid. Each token has its own life span and becomes invalid only after its expire date or the user requests to revoke all his/her tokens by request.

## Login

Use this API to authenticate your self and get a token for future requests.

**Note:** The user attempt to log in should have activated (registered) their account.

**Note:** The request token is the fcm token that is retrieved from Firebase by user. The user id and fcm token will stored into the database when the user has logged in.

    POST /login

### Input

Name  | Type  | Description
----- | ----- | -----------
`email`  | `string`    | The email of the user.
`password` |	`string`    | The **hashed** password of the user. **Note:** Never send plaintext password through the internet.
`token`  |  `string`  |  The fcm token of the user

### Example Request

```http
POST http://localhost:8080/api/login
Content-Type: application/json

{
  "email": "williamson@example.com",
  "password": "123",
  "token": "fDTpUpdHDlc:APA91bHM7XVkG4Ad83EWwNqMBm437kWtKRvxeGYlS1A5CNdPtJdTcXP-MBXdkvQAjhnuZeOtcjSatMxn-p-qCXBRaJN2MhCEIMYjf2kSHVBA2gICIswJl_TCNweVBHlCybdXkQ_53bzY"
}
```

### Response

    Status: 200 OK

```json
{
  "dob": "1986-08-07T00:00:00Z",
  "email": "williamson@example.com",
  "firstname": "Alex",
  "id": "1",
  "middlename": "Mileston",
  "state": "QLD",
  "street": "97 Masthead Drive",
  "suburb": "ROCKHAMPTON",
  "surname": "Williamson",
  "token": "eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjoiUEFUSUVOVCIsImp0aSI6Imk4NGJ0NW9mYTFkYzg4M2NrMGZiNWIzYm44IiwiZXhwIjoxNTMzNDg5NjI1LCJpYXQiOjE1MzM0MDMyMjUsInN1YiI6IjEifQ.DhObZjRVEGH-DcBoa_6t0RwNk_Pz5eUz8e1Ur5Z-PoAAihi8TdUtWV5Lc0rhW1DodX1kKp5VJ7AchVKQOHohHw",
  "token_expire_date": "2018-08-05T17:20:25.154Z"
}
```

## Logout

As tokens are not tracked by the server, there is no need for a client to logout by request. You can simply destroy your locally stored token to perform logout. Meanwhile other tokens (i.e. a second device) are still valid. If you want to revoke all your valid token issued so far, refer to [Revoke all existing tokens](#revoke-all-existing-tokens)

When user has logged out, this api should be invoked to delete the record of user id and fcm token from the database.

    POST /logout

### Input

Name  | Type  | Description
----- | ----- | -----------
`id`  |  `string`  | The user ID
`token`  | `string`    | The fcm token of the user

### Example Request

```http
POST http://localhost:8080/api/logout
Content-Type: application/json

{  
  "id": "1",
  "token": "fDTpUpdHDlc:APA91bHM7XVkG4Ad83EWwNqMBm437kWtKRvxeGYlS1A5CNdPtJdTcXP-MBXdkvQAjhnuZeOtcjSatMxn-p-qCXBRaJN2MhCEIMYjf2kSHVBA2gICIswJl_TCNweVBHlCybdXkQ_53bzY"
}
```
### Response

    Status: 200 OK

```json
{
  "message": "Success"
}
```
## Renew a token

You can use this api to request a new token with a fresh expire date with your existing valid token.

    POST /renewToken

### Response

    Status: 200 OK

```json
{
  "token": "eyJhbGciOiJIUzUxMiJ9.eyJyb2xlIjoiUEFUSUVOVCIsImp0aSI6IjVzM2M1azI1OGdodmgxYmZ1dmFxdWdzOW9iIiwiZXhwIjoxNTMzNDg4OTk3LCJpYXQiOjE1MzM0MDI1OTcsInN1YiI6IjEifQ.QiCE9mrcyJejDVtaUpFQDURcdgHhXRtyVeLGlcptUnWk1-hPGqWmKqQR4rYycl2aphxl9Q3KacYl-DuVlB3Q3g",
  "token_expire_date": "2018-08-05T17:09:57.962Z"
}
```

## Revoke all existing tokens

You can use this api to revoke all existing tokens.

    POST /revokeAll

### Response

    Status: 200 OK

```json
{ "message": "Success" }
```
