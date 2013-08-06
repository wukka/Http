#!/usr/bin/env php
<?php
use Wukka\Test as T;
use Wukka\Http\Request;

include __DIR__ . '/setup.php';

T::plan(4);

$request = new Request($baseurl . '/http_auth.php');
$response = $request->send();
T::is( $response->http_code, '401', 'got back a 401 response');
T::like( $response->body, '/no auth/i', 'body says no auth');
$request = new Request("http://foo:bar@$host:$port/http_auth.php");
$response = $request->send();
T::is( $response->http_code, '200', 'after entering username and password, got in successfully');
T::like( $response->body, '/hello foo/i', 'script echoed our username back to us');
