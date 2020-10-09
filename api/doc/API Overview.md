# API Overview

This describes the resources that make up the official Medical Secretary REST API.

<!-- @import "[TOC]" {cmd="toc" depthFrom=2 depthTo=2 orderedList=false} -->
<!-- code_chunk_output -->

* [Schema](#schema)
* [Authentication](#authentication)
* [Parameters](#parameters)
* [Pagination](#pagination)
* [Conditional Requests](#conditional-requests)
* [Cross Origin Resource Sharing (CORS)](#cross-origin-resource-sharing-cors)
* [JSON-P callbacks](#json-p-callbacks)

<!-- /code_chunk_output -->

## Schema

All API access is currently over HTTP and will eventually migrate to a compulsory HTTPS schema, and accessed from `[ROOT URL]`. All data is sent and received as JSON.

Blank fields are included as `null` instead of being omitted.

All timestamps return in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format:

    YYYY-MM-DDTHH:MM:SSZ

## Authentication

In some places, requests that require authentication will return `404 Not Found`, instead of `403 Forbidden`. This is to prevent the accidental leakage of private resources to unauthorised users.

The authentication is token-based, all requests expect a valid token in request header unless specified otherwise. Once your client is issued with a token, send it with your further requests in the header:

    $ curl -H "Authorization: Bearer TOKEN" [Resource URL]

## Parameters

Some API methods take optional parameters. For GET requests, any parameters not specified as a segment in the path can be passed as an HTTP query string parameter:

    $ curl -i [ROOT URL]/myAppointments/?confirmed=true

For POST and DELETE requests, parameters not included in the URL should be encoded as JSON with a Content-Type of 'application/json':

## Pagination

Requests that return multiple items will be paginated to 30 items by default. You can specify further pages with the `?page` parameter. you can also set a custom page size up to 100 with the `?per_page` parameter.

Note that page numbering is 1-based and omitting the `?page` parameter will return the first page.

## Conditional Requests

Many responses returns a `Last-Modified` header. You can use the value to make subsequent requests to those resources using the `If-Modified-Since` header. If the resource has not changed, the server will return a `304 Not Modified`.

We encourage you to use conditional requests whenever possible

## Cross Origin Resource Sharing (CORS)

The API support Cross Origin Resource Sharing (CORS) for AJAX requests from any origin.

## JSON-P callbacks

You can send a `?callback` parameter to any GET call to have the results wrapped in a JSON function.
