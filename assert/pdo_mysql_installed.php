<?php
use Wukka\Test as T;

if( ! in_array( 'mysql', PDO::getAvailableDrivers()) ){
    T::plan('skip_all', 'this version of PDO does not support mysql');
}
