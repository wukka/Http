#!/usr/bin/env php
<?php
use Wukka\Test as T;
use Wukka\Http\Request;

include __DIR__ . '/setup.php';

T::plan(4);

$request = new Request($baseurl . '/bigdoc.php?size=100&iterations=500&usleep=100');

$buf = '';
$write_ct = 0;

$writer = function( $ch, $data ) use( & $buf, & $write_ct){
    $buf .= $data;
    $write_ct++;
    return strlen( $data );
};

$request->build = function( $request, array & $opts ) use( $writer ) {
    $opts[ CURLOPT_WRITEFUNCTION ] = $writer;
};

$res = $request->send();
$len = strlen( $buf );

T::cmp_ok( $len, '>', 10000, "subverted the writing handler, got back a block of text: $len chars");
T::cmp_ok($write_ct, '>', 10, "my write function callback was triggered more than 10 times: $write_ct");

$buf = '';
$write_ct = 0;

$request = new Request($baseurl . '/bigdoc.php?size=100&iterations=500&usleep=100');
$res = $request->send(array(CURLOPT_WRITEFUNCTION =>$writer));
$len = strlen( $buf );

T::cmp_ok( $len, '>', 10000, "passed the CURLOPT_WRITEFUNCTION to send , got back a block of text: $len chars");
T::cmp_ok($write_ct, '>', 10, "my write function callback was triggered more than 10 times: $write_ct");