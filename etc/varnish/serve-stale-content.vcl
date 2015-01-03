backend unhealthy {
  .host = "127.0.0.1";
  .port = "1";
  .probe = {
    .url = "/fake.html";
    .interval = 600s;
    .timeout = 0.1s;
    .window = 1;
    .threshold = 1;
    .initial = 1;
  }
}

sub vcl_recv {
  /* We accept up to this old data, if backends for some reason
   * don't deliver (fresh) content, typically when they're down */
  set req.grace = 2h;

  if (req.http.unhealthy && req.http.unhealthy == "true" ) {
    set req.backend = unhealthy;
  }
}

sub vcl_fetch {
  /* Store objects 1 hour after they are due to be purged for
   * grace-purposes (this means that we've got 1 hour to serve stale
   * content in case of failing backends).
  */
  if (beresp.status == 200) {
    set beresp.grace = 1h;
  }
  else if (beresp.status == 503) {
    /* For this URL, don't ask the backend again for this amount of
     * time. */
    set beresp.saintmode = 60s;
    return(restart);
  }
}

sub vcl_error {
  /* If we're serving a 503 and haven't restarted (this means the
   * backend is down, 503 is the typical Varnish 'guru meditation',
   * try to invoke grace mode. We do this by setting the backend to be
   * the unhealthy, phony packend. This will never work, so Varnish
   * will invoke grace mode, i.e. serve stale/old content from the
   * previous status=200 for that URL.  */
  if (obj.status == 503 && req.restarts == 0) {
    set req.http.unhealthy = "true";
    return(restart);
  }
}
