<?php
ob_start();
include __DIR__ . '/../../autoload.php';
use Wukka\Http\AuthDigest;


// instantiate the digest
$auth = new AuthDigest( $realm = 'Restricted Area', $domain = '/' );

// normally you would pre-load your usernames and passwords into your storage.
// using the auth object to hash the password. 

// hashing the password is as simple as doing:
// md5( $username . ':' . $realm . ':' . $password );
// don't need the authdigest object to do it technically.
// but it is more convenient.
// not super encrypted, but it is a 1 way hash and unlikely that a dictionary attack
// will work to be able to reverse a list of passwords from the hashed password.
$map = array();
$map['foo'] = $auth->hashPassword('foo', 'bar');

// also a plain-text password example. both work.
$map['bazz'] = 'quux';


// a simple wrapper for authentication. use whatever logic you need here,
// db lookup, whatever.
$auth_lookup = function( $request ) use ( $map ){
  return isset( $map[ $request ] ) ? $map[ $request ] : NULL;
};



// if not authenticated, send the usual unauthorized header, along with 
// a challenge header.
if( ! $is_authenticated = $auth->authenticate( $auth_lookup ) ){
    header('HTTP/1.1 401 Unauthorized' );
    header( $auth->challenge() );
}
?>
<?php if( ! $is_authenticated ): ?>
<html>
 <head>
  <title>401 - Unauthorized</title>
 </head>
 <body>
  <h1>401 - Unauthorized</h1>
 </body>
</html>
<?php else: ?>
<html>
<body>
<h1>all ur base r belong 2 us</h1>
</body>
</html>
<?php endif; ?>