sub vcl_deliver {
  set resp.http.X-Cache-Host = "prod1";
}
