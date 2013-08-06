<?php
use Wukka\Test as T;

if( ! @fsockopen('127.0.0.1', 5432) ){
    T::plan('skip_all', 'postgres not running on 127.0.0.1:5432');
}
