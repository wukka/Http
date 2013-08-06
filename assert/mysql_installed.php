<?php
use Wukka\Test as T;

if( ! function_exists('mysql_connect') ){
    T::plan('skip_all', 'php-postgres not installed');
}
