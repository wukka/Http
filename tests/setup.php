<?php

use Wukka\Test as T;

include __DIR__ . '/../autoload.php';

$host = '127.0.0.1';
$port = 11295;

if( ! function_exists('curl_init') ){
    T::plan('skip_all', 'php curl library not installed');
}

if( ! @fsockopen($host, $port) ){
    T::plan('skip_all', "http://$host:$port/ not started. run ./tests/start_webservice.sh");
}

$baseurl = "http://$host:$port";
