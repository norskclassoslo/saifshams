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


backend vmeo {
  .host = "vmeo-controller.mbl.cust.vizrtsaas.com";
  .port = "80";
}

sub vcl_recv {
  if (client.ip ~ staff &&
      req.url ~ "^/diactus/DiRetriever") {
    set req.http.authorization = "Basic ZXNjZW5pY0B2aXpydC5jb206NGRtMW5FU0NFTklD";
    set req.backend = vmeo;
  }
  /* escenic@vizrt.com:4dm1nESCENIC */

if (req.url ~ "^/config/") {
error 404 "Not Found";
}
}


