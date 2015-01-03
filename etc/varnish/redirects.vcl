sub vcl_recv {
  if (req.http.host == "ripon.saifshams.com") {
    error 301 "Moved Temporarily";
  }
  if (req.http.host == "fardin.saifshams.com") {
    error 301 "Moved Temporarily";
  }
}
sub vcl_error {
  /* We want both web sites to be identified by one URL, hence we make
   * an HTTP re-direct here. See vcl_recv for how these 301 error
   * directives.
   */
  if (obj.status == 301 && req.http.host == "ripon.saifshams.com") {
    set obj.http.Location = "http://saifshams.com/index.php/category/friendsnfamily/ripon/";
    return (deliver);
  }
  if (obj.status == 301 && req.http.host == "fardin.saifshams.com") {
    set obj.http.Location = "http://saifshams.com/index.php/category/friendsnfamily/fardin/";
    return (deliver);
  }
}
