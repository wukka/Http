<?php
use Wukka\Test as T;

if( ! class_exists('\MySQLi') ){
    T::plan('skip_all', 'php-mysqli not installed');
}
