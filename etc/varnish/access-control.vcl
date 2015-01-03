/* IPs that are allowed to access the administrative pages/webapps. */
acl staff {
  "localhost";
  "82.164.194.140";
  "127.0.0.1";
  "127.0.1.1";
  "128.199.106.226";
  "109.189.163.15";
  "202.4.173.61";
}

sub vcl_recv {
  if (!client.ip ~ staff) {
    error 200 "The site is under construction.";
  }
}
