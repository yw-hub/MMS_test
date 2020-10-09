# Example API

Brief description of this API group.

**Note:** This is a note. 

**Warning:** This is a warning.

## A Get Example

Brief description of this single API.

    GET /example/resource

### Parameters

If the API have any parameters (GET)

Name  | Type  | Description
----- | ----- | -----------
`visibility`  | `string`    | Can be one of `all`, `public`, or `private`. Default: `all`
`affiliation` |	`string`    | Comma-separated list of values. Can include:<br> * `owner`: Repositories that are owned by the authenticated user. <br> * `collaborator`: Repositories that the user has been added to as a collaborator. <br> * `organization_member`: Repositories that the user has access to through being a member of an organization. This includes every repository on every team that the user is on. <br>  Default: `owner,collaborator,organization_member`

### Response

    Status: 200 OK
    
```json
[
  {
    "id": 1296269,
    "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
    "name": "Hello-World",
    "full_name": "octocat/Hello-World",
    "private": false,
    "html_url": "https://github.com/octocat/Hello-World",
    "allow_rebase_merge": true,
    "allow_squash_merge": true,
    "allow_merge_commit": true,
    "subscribers_count": 42,
    "network_count": 0,
    "license": {
        "key": "mit",
        "name": "MIT License",
        "spdx_id": "MIT",
        "url": "https://api.github.com/licenses/mit",
        "node_id": "MDc6TGljZW5zZW1pdA=="
    }
  }
]
```

## A Post Example

Brief description of this single API.

    POST /example/resource

### Input

Name  | Type  | Description
----- | ----- | -----------
`name`  | `string`    | **Required**. The name of the repository.
`description` |	`string` |	A short description of the repository.
`private` |	`boolean` |	Either `true` to create a private repository or `false` to create a public one. Default: `false`.

### Example

```json
{
  "name": "Hello-World",
  "description": "This is your first repository",
  "private": false
}
```

### Response

    Status: 200 OK

```json
{
    "id": 1296269,
    "node_id": "MDEwOlJlcG9zaXRvcnkxMjk2MjY5",
    "name": "Hello-World",
    "full_name": "octocat/Hello-World",
    "private": false,
    "html_url": "https://github.com/octocat/Hello-World",
    "allow_rebase_merge": true,
    "allow_squash_merge": true,
    "allow_merge_commit": true,
    "subscribers_count": 42,
    "network_count": 0,
    "license": {
        "key": "mit",
        "name": "MIT License",
        "spdx_id": "MIT",
        "url": "https://api.github.com/licenses/mit",
        "node_id": "MDc6TGljZW5zZW1pdA=="
    }
}
```

In some scenarios the API may behave in another way which may produce different response. In these cases we append these responses with brief description of corresponding scenarios.

    Status: 403 Forbidden

```json
{
  "message": "Normal user cannot create new resource."
}
```
