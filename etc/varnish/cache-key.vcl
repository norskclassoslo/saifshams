/* Manipulate the cache keys in this method. */
sub vcl_hash {
  /* We've normalised the UA string in request-cleaning.vcl so we can
   * include the UA in the hash */
  hash_data(req.http.User-Agent);
}
