<?php
use Wukka\Test as T;

if( ! function_exists('pg_connect') ){
    T::plan('skip_all', 'php-postgres not installed');
}
