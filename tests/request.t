#!/usr/bin/env php
<?php
use Wukka\Test as T;
use Wukka\Http\Request;
use Wukka\Http\Util;

include __DIR__ . '/setup.php';

T::plan(13);


$request = new Request($baseurl . '/http_json_echo.php');
$response = $request->send();
T::is( $response->http_code, 200, 'got back a 200 ok response');
T::is( trim($response->body), '[]', 'got back an empty json array');
$request = new Request($baseurl . '/http_json_echo.php?test=1');
$response = $request->send();
T::is( trim($response->body), '{"test":"1"}', 'sent a GET param and got it echoed back');
$request = new Request($baseurl . '/http_json_echo.php');
$request->post = array('test'=>1);
$response = $request->send();
T::is( trim($response->body), '{"test":"1"}', 'sent a POST param and got it echoed back');

$request = new Request($baseurl . '/http_json_echo.php');
$request->post = '<?xml><test>1</test>';
$response = $request->send();
T::is( trim($response->body), '{"__raw__":"<?xml><test>1<\/test>"}', 'sent POST raw xml and got it echoed back');

$request = new Request($baseurl . '/http_json_echo.php');
$request->post = array('test'=>1);
$request->method = 'PUT';
$response = $request->send();
T::like( $response->request_header, '#PUT \/http_json_echo\.php#i', 'successfully sent a PUT request');
$headers = Util::parseHeaders( $response->response_header );
T::is( $headers['X-Request-Method'], 'PUT', 'response header shows the PUT request came through');
T::is( trim($response->body), '{"__raw__":"test=1"}', 'post data echoed back as raw');


$request = new Request($baseurl . '/http_json_echo.php?test=1');
$request->method = 'DELETE';
$response = $request->send();

T::like( $response->request_header, '#DELETE \/http_json_echo\.php#i', 'successfully sent a DELETE request');
$headers = Util::parseHeaders( $response->response_header );
T::is( $headers['X-Request-Method'], 'DELETE', 'response header shows the DELETE request came through');


$ch = curl_init($url = $baseurl . '/http_json_echo.php?test=1');

$request = new Request($ch);

T::cmp_ok( $request->resource, '===', $ch, 'passed in a curl handle to constructor ... set up as the request handle');

T::cmp_ok( $request->url, '===', $url, 'url extracted out of the curl handle and set in as the request url');

$response = $request->send();
T::is( trim($response->body), '{"test":"1"}', 'sent request with the request constructed from the curl handle and got expected result');


T::debug( $response );
