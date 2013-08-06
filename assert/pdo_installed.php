<?php
use Wukka\Test as T;

if( ! class_exists('\PDO') ){
    T::plan('skip_all', 'php-pdo not installed');
}