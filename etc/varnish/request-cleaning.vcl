sub vcl_recv {
  /* Normalizing all user agents so that we can support both caching
   * and (partial) device detection on backend servers like
   * VMEO/Adactus and Mobiletech .
   *
   * All iPhones are treated as the same one, all iPads as the same
   * iPad, all Opera Mini as the same one and all Android. If the
   * client (browser) is neither of the above, a common UA string is
   * set.
   *
   * We check for Opera Mini before Android as some user agents
   * contain both.
   */
    set req.http.User-Agent = "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; VOSA 1.0)";
}

/* We unset all request headers before hitting the backend, except:
 * - Host
 * - User-Agent
 * - X-Forwarded-For
 * - Referer
 * - Accept
 * - X-OperaMini-Phone-UA
 *
 * The reason for this, is that we're optimising the device detection
 * through the use of buckets. Hence, we must unset all headers that
 * backend software (such as Mobiletech) may use to determine the
 * client and by that deliver web content. */
sub vcl_pipe {
  unset bereq.http.accept-charset;
  unset bereq.http.accept-encoding;
  unset bereq.http.accept-language;
  unset bereq.http.accept-ranges;
  unset bereq.http.accounting-session-id;
  unset bereq.http.apn;
  unset bereq.http.authorization;
  unset bereq.http.bearer-type;
  unset bereq.http.cache-control;
  unset bereq.http.charging-characteristics;
  unset bereq.http.clientip;
  unset bereq.http.client-ip;
  unset bereq.http.connection;
  unset bereq.http.content-disposition;
  unset bereq.http.content-length;
  unset bereq.http.content-range;
  unset bereq.http.content-type;
  unset bereq.http.cookie;
  unset bereq.http.cookie2;
  unset bereq.http.cuda_cliip;
  unset bereq.http.date;
  unset bereq.http.device-stock-ua;
  unset bereq.http.dnt;
  unset bereq.http.drm-version;
  unset bereq.http.etag;
  unset bereq.http.expires;
  unset bereq.http.from;
  unset bereq.http.if-modified-since;
  unset bereq.http.if-none-match;
  unset bereq.http.if-range;
  unset bereq.http.ip-address;
  unset bereq.http.last-modified;
  unset bereq.http.location;
  unset bereq.http.msisdn;
  unset bereq.http.mt-proxy-id;
  unset bereq.http.nas-ip-address;
  unset bereq.http.origin;
  unset bereq.http.pnp;
  unset bereq.http.pragma;
  unset bereq.http.proxy-connection;
  unset bereq.http.range;
  unset bereq.http.server;
  unset bereq.http.set-cookie;
  unset bereq.http.sgsn-ip-address;
  unset bereq.http.transfer-encoding;
  unset bereq.http.ua-cpu;
  unset bereq.http.unless-modified-since;
  unset bereq.http.vary;
  unset bereq.http.via;
  unset bereq.http.wap-connection;
  unset bereq.http.x-amz-cf-id;
  unset bereq.http.x-att-deviceid;
  unset bereq.http.x-bluecoat-via;
  unset bereq.http.x-cnection;
  unset bereq.http.x-country-code;
  unset bereq.http.x-d-forwarder;
  unset bereq.http.x-ebo-ua;
  unset bereq.http.x-ee-brand-id;
  unset bereq.http.x-ee-client-ip;
  unset bereq.http.x-flash-version;
  unset bereq.http.x-forwarded-port;
  unset bereq.http.x-forwarded-proto;
  unset bereq.http.x-imforwards;
  unset bereq.http.x-mcproxyfilter;
  unset bereq.http.x-mobile-gateway;
  unset bereq.http.x-network-type;
  unset bereq.http.x-nokia-bearer;
  unset bereq.http.x-nokiabrowser-features;
  unset bereq.http.x-nokia-device-type;
  unset bereq.http.x-nokia-ipaddress;
  unset bereq.http.x-nokia-musicshop-bearer;
  unset bereq.http.x-nokia-musicshop-version;
  unset bereq.http.x-nokia-upgradeid;
  unset bereq.http.x-ob;
  unset bereq.http.x-online-host;
  unset bereq.http.x-opera-id;
  unset bereq.http.x-opera-info;
  unset bereq.http.x-operamini-features;
  unset bereq.http.x-operamini-phone;
  unset bereq.http.x-operamini-route;
  unset bereq.http.x-operator-domain;
  unset bereq.http.x-orange-rat;
  unset bereq.http.x-orange-roaming;
  unset bereq.http.x-p2p-peerdist;
  unset bereq.http.x-p2p-peerdistex;
  unset bereq.http.x-piper-id;
  unset bereq.http.x-powered-by;
  unset bereq.http.x-proxy-id;
  unset bereq.http.x-proxyuser-ip;
  unset bereq.http.x-purpose;
  unset bereq.http.x-rbt-optimized-by;
  unset bereq.http.x-requested-with;
  unset bereq.http.x-ucbrowser-phone;
  unset bereq.http.x-ucbrowser-phone-ua;
  unset bereq.http.x-ucbrowser-ua;
  unset bereq.http.x-up-calling-line-id;
  unset bereq.http.x-up_devcap-screendepth;
  unset bereq.http.x-view-mode;
  unset bereq.http.x-wap-network-client-msisdn;
  unset bereq.http.x-wap-profile;
  unset bereq.http.x-wap-profile-diff;
  unset bereq.http.x-pingback;
}
