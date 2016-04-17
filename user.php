<?php
 
// Get the username from the url
$id = $_GET['id'];
 
?><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Simple mod\_rewrite example</title>
    <style type="text/css"> .green { color: green; } </style>
</head>
<body>
  <h1>You Are on user.php!</h1>
  <p>Welcome: <span class="green"><?php echo $id; ?></span></p>
</body>
</html>
