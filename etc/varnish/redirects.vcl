sub vcl_recv {
  if (req.http.host == "ripon.saifshams.com") {
    return (synth(301, "Moved Temporarily"));
  }
  if (req.http.host == "fardin.saifshams.com") {
    return (synth(301, "Moved Temporarily"));
  }
  if (req.url == "/login") {
    return (synth(301, "Move Temporarily"));
  }  
}
sub vcl_synth {
  /* We want both web sites to be identified by one URL, hence we make
   * an HTTP re-direct here. See vcl_recv for how these 301 error
   * directives.
   */
  if (resp.status == 301 && req.http.host == "ripon.saifshams.com") {
    set resp.http.Location = "http://saifshams.com/index.php/category/friendsnfamily/ripon/";
    return (deliver);
  }
  if (resp.status == 301 && req.http.host == "fardin.saifshams.com") {
    set resp.http.Location = "http://saifshams.com/index.php/category/friendsnfamily/fardin/";
    return (deliver);
  }
 if (resp.status == 301 && req.url == "/login") {
   set resp.http.Location = "http://saifshams.com/wp-login.php";
   return (deliver);
  }
}
