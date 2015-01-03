sub vcl_recv {
  if (req.http.host ~ "^beta\." && req.url == "/robots.txt") {
    set req.http.marker-robots = "true";
    error 200 "OK";
  }
}

sub vcl_error {
  if (obj.status == 200 && req.http.marker-robots == "true") {
    remove req.http.marker-robots;
    synthetic {"User-Agent: *
Disallow /
"};
    return(deliver);
  }
}
