sub vcl_recv {
  if (req.http.host ~ "^beta\." && req.url == "/robots.txt") {
    set req.http.marker-robots = "true";
    return (synth(200, "OK"));
  }
}

sub vcl_backend_error {
  if (beresp.status == 200 && beresp.http.marker-robots == "true") {
    unset beresp.http.marker-robots;
    synthetic ("Disallow /");
    return(deliver);
  }
}
