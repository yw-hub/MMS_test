# User API

You can use this API to manage the user account information.

<!-- @import "[TOC]" {cmd="toc" depthFrom=2 depthTo=2 orderedList=false} -->
<!-- code_chunk_output -->

* [Activate your preload user account](#activate-your-preload-user-account)
* [Change password](#change-password)

<!-- /code_chunk_output -->

## Activate your preload user account

You can use this API to activate an user account and set up the password for the first time.

**Note:** This API does not require a token.

    POST /user/activate

### Input

Name  | Type  | Description
----- | ----- | -----------
`email`  | `string`    | The registered email of the user.
`surname` | `string`   | The registered surname of the user.
`firstname` | `string`  | The registered first name of the user.
`dob`   | `LocalDate`  | The registered date of birth of the user, represented by a string with a format of `YYYY-MM-DD`. This date is timezone irrelevant.
`password` |	`string`    | The password user wish to use. **Note:** Never send plaintext password through the internet.

### Example Request

```http
POST http://localhost:8080/api/user/activate
Content-Type: application/json

{
	"email":"chad@example.com",
	"surname":"Sharpe",
	"firstname":"Chad",
	"dob":"1979-08-03",
	"password":"1"
}
```

### Response

    Status: 200 OK

```json
{ "message": "Success" }
```

Registered information provided must match the preloaded data.
Otherwise the server will return a `404 Not Found`.

If the user account has already been activated, the server will return a `403 Forbidden`.

## Change password

You can use this API the change the password of the user.

**Note:** Upon success of this request, all currently existing token related to the user will be revoked. See [Revoke all existing tokens](AuthenticationAPI.md#revoke-all-existing-tokens)

    PUT /user/password

### Input

Name  | Type  | Description
----- | ----- | -----------
`email`  | `string`    | The registered email of the user.
`password` |	`string`    | The original password.
`new_password` | `string`   | The new password.

### Response

    Status: 200 OK

```json
{ "message": "Success" }
```
