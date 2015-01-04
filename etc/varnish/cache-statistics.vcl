sub vcl_deliver {
  /* Adds debug header to the result so that we can easily see if a
   * URL has been fetched from cache or not.
   */
  if (obj.hits > 0 && (resp.status == 200 || resp.status == 301)) {
    set resp.http.X-Cache = "HIT #" + obj.hits + "/" + resp.http.Age + "s";
  }
  else if (resp.status == 200) {
    set resp.http.X-Cache = "MISS";
  }
  set resp.http.X-Cache-Backend = req.backend_hint;
}
