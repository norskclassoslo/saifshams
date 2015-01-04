sub vcl_hash {
  /* We've normalised the UA string in request-cleaning.vcl so we can
   * include the UA in the hash */
  if(req.http.TVKioskenMobileApp == "yes"){
   hash_data(req.http.TVKioskenMobileApp);
  }
}

sub vcl_deliver {
  /* It seems that Varnish changes the Date header and the age header
   * becomes wrong because of this. For this reason, we set the Age
   * header to 0 to be standards compliant. */
  set resp.http.Age = "0";
}





