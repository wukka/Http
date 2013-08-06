<?php
use Wukka\Test as T;

if( ! @fsockopen('127.0.0.1', '3306')) {
    T::plan('skip_all', 'mysql-server not running on localhost');
}