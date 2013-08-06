<?php
use Wukka\Test as T;

if( ! in_array( 'pgsql', PDO::getAvailableDrivers()) ){
    T::plan('skip_all', 'this version of PDO does not support postgres');
}
