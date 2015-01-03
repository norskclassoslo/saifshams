backend localhost0 {
  .host = "localhost";
  .port = "81";
}

/* The client director gives us session stickiness based on client
 * IP. */
director webdirector client {
  {
     .backend = localhost0;
     .weight = 1;
  }
}
sub vcl_recv {
  /* This is the default backend */
  set req.backend = webdirector;
}
