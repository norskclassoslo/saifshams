sub vcl_fetch {
  /*   Cache everything for 2 minutes. */
  if (beresp.status == 200) {
    set beresp.ttl = 120m;
  }

  /* Remove cookies from these resource types and cache them for a
   * long time */
  if (req.url ~ "\.(png|gif|jpg|css|js)$" ||
      req.url == "/favicon.ico" && beresp.status == 200) {
    set beresp.ttl = 24h;
  }
}

sub vcl_deliver {
  if (req.url ~ "\.(png|gif|jpg)$" && resp.status == 200) {
    set resp.http.Cache-Control = "public, max-age=7200";
  }
  else if ((req.url ~ "\.(css|js)$" || req.url == "/favicon.ico") &&
           resp.status == 200) {
    set resp.http.Cache-Control = "public, max-age=7200";
  }

  /* Since we're normalising the UA, we include it in the Vary header
   * so that itermiediary proxies get all the information they need to
   * create desired behaviour. We also add a debug header to show
   * which UA we've used to produce the response. */
  set resp.http.X-UA = req.http.User-Agent;
  set resp.http.Vary = "Accept-Encoding,User-Agent";
}
