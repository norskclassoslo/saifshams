sub vcl_fetch {
  if (beresp.http.content-type ~ "^text/") {
    set beresp.do_gzip = true;
  }
}
