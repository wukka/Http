#!/usr/bin/env php
<?php
use Wukka\Test as T;
use Wukka\Http\Request;

include __DIR__ . '/setup.php';

T::plan(6);

$request = new Request($baseurl . '/http_auth_digest.php');
$response = $request->send();
T::is( $response->http_code, '401', 'got back a 401 response');
T::like( $response->body, '/Unauthorized/i', 'body says Unauthorized');
$request = new Request("http://foo:bar@$host:$port/http_auth_digest.php");
$response = $request->send(array(CURLOPT_HTTPAUTH=>CURLAUTH_DIGEST));
T::is( $response->http_code, '200', 'after entering username and password, got in successfully');
T::like( $response->body, '/all ur base r belong 2 us/i', 'script gave back proper response');


$request = new Request("http://bazz:quux@$host:$port/http_auth_digest.php");
$response = $request->send(array(CURLOPT_HTTPAUTH=>CURLAUTH_DIGEST));
T::is( $response->http_code, '200', 'after entering username and password that were stored in clear text, got in successfully');
T::like( $response->body, '/all ur base r belong 2 us/i', 'script gave back proper response');
