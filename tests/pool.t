#!/usr/bin/env php
<?php
use Wukka\Test as T;
use Wukka\Http\Request;
use Wukka\Http\Pool;

include __DIR__ . '/setup.php';

T::plan(5);

$pool = new Pool;

$ct = 0;
$iterations = 50;
$requests = array();

$pool->attach( 
    function ( Request $request ) use ( & $ct ){
        $ct++;
    }
);
for( $i = 0; $i < $iterations; $i++){
    $pool->add( $requests[] = new Request($baseurl . '/') );
}

$start = microtime(TRUE);
$pool->finish();
$elapsed = number_format(microtime(TRUE) - $start,5);

T::is( $ct, $iterations, "got $iterations responses back");
T::cmp_ok( $elapsed, '<', 1, "took less than 1 sec (actual time is $elapsed s)");

$status = TRUE;
foreach( $requests as $request ){
    if( $request->response->http_code != 200 ) $status = FALSE;
    break;
}

T::ok( $status , 'all the responses came back with http code 200');
if( ! $status ) T::debug( print_r($request, TRUE) );

$status = TRUE;
foreach( $requests as $request ){
    if( ! preg_match('/index page/i', $request->response->body ) ) $status = FALSE;
    break;
}

T::ok( $status , 'all the responses came back with correct body response');
if( ! $status ) T::debug( $request->response->body );

$status = TRUE;
$max = 0;
foreach( $requests as $request ){
    if(  $request->response->total_time == 0 || $request->response->total_time > 0.5 ) $status = FALSE;
    if( $request->response->total_time > $max ) $max = $request->response->total_time;
}

T::ok( $status , "all the responses came back in less than .5 secs each (max $max s)");
if( ! $status ) T::debug( $request->response->total_time );
