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

/* We remove all request headers before hitting the backend, except:
 * - Host
 * - User-Agent
 * - X-Forwarded-For
 * - Referer
 * - Accept
 * - X-OperaMini-Phone-UA
 *
 * The reason for this, is that we're optimising the device detection
 * through the use of buckets. Hence, we must remove all headers that
 * backend software (such as Mobiletech) may use to determine the
 * client and by that deliver web content. */
sub vcl_miss {
  remove bereq.http.accept-charset;
  remove bereq.http.accept-encoding;
  remove bereq.http.accept-language;
  remove bereq.http.accept-ranges;
  remove bereq.http.accounting-session-id;
  remove bereq.http.apn;
  remove bereq.http.authorization;
  remove bereq.http.bearer-type;
  remove bereq.http.cache-control;
  remove bereq.http.charging-characteristics;
  remove bereq.http.clientip;
  remove bereq.http.client-ip;
  remove bereq.http.connection;
  remove bereq.http.content-disposition;
  remove bereq.http.content-length;
  remove bereq.http.content-range;
  remove bereq.http.content-type;
  remove bereq.http.cookie;
  remove bereq.http.cookie2;
  remove bereq.http.cuda_cliip;
  remove bereq.http.date;
  remove bereq.http.device-stock-ua;
  remove bereq.http.dnt;
  remove bereq.http.drm-version;
  remove bereq.http.etag;
  remove bereq.http.expires;
  remove bereq.http.from;
  remove bereq.http.if-modified-since;
  remove bereq.http.if-none-match;
  remove bereq.http.if-range;
  remove bereq.http.ip-address;
  remove bereq.http.last-modified;
  remove bereq.http.location;
  remove bereq.http.msisdn;
  remove bereq.http.mt-proxy-id;
  remove bereq.http.nas-ip-address;
  remove bereq.http.origin;
  remove bereq.http.pnp;
  remove bereq.http.pragma;
  remove bereq.http.proxy-connection;
  remove bereq.http.range;
  remove bereq.http.server;
  remove bereq.http.set-cookie;
  remove bereq.http.sgsn-ip-address;
  remove bereq.http.transfer-encoding;
  remove bereq.http.ua-cpu;
  remove bereq.http.unless-modified-since;
  remove bereq.http.vary;
  remove bereq.http.via;
  remove bereq.http.wap-connection;
  remove bereq.http.x-amz-cf-id;
  remove bereq.http.x-att-deviceid;
  remove bereq.http.x-bluecoat-via;
  remove bereq.http.x-cnection;
  remove bereq.http.x-country-code;
  remove bereq.http.x-d-forwarder;
  remove bereq.http.x-ebo-ua;
  remove bereq.http.x-ee-brand-id;
  remove bereq.http.x-ee-client-ip;
  remove bereq.http.x-flash-version;
  remove bereq.http.x-forwarded-port;
  remove bereq.http.x-forwarded-proto;
  remove bereq.http.x-imforwards;
  remove bereq.http.x-mcproxyfilter;
  remove bereq.http.x-mobile-gateway;
  remove bereq.http.x-network-type;
  remove bereq.http.x-nokia-bearer;
  remove bereq.http.x-nokiabrowser-features;
  remove bereq.http.x-nokia-device-type;
  remove bereq.http.x-nokia-ipaddress;
  remove bereq.http.x-nokia-musicshop-bearer;
  remove bereq.http.x-nokia-musicshop-version;
  remove bereq.http.x-nokia-upgradeid;
  remove bereq.http.x-ob;
  remove bereq.http.x-online-host;
  remove bereq.http.x-opera-id;
  remove bereq.http.x-opera-info;
  remove bereq.http.x-operamini-features;
  remove bereq.http.x-operamini-phone;
  remove bereq.http.x-operamini-route;
  remove bereq.http.x-operator-domain;
  remove bereq.http.x-orange-rat;
  remove bereq.http.x-orange-roaming;
  remove bereq.http.x-p2p-peerdist;
  remove bereq.http.x-p2p-peerdistex;
  remove bereq.http.x-piper-id;
  remove bereq.http.x-powered-by;
  remove bereq.http.x-proxy-id;
  remove bereq.http.x-proxyuser-ip;
  remove bereq.http.x-purpose;
  remove bereq.http.x-rbt-optimized-by;
  remove bereq.http.x-requested-with;
  remove bereq.http.x-ucbrowser-phone;
  remove bereq.http.x-ucbrowser-phone-ua;
  remove bereq.http.x-ucbrowser-ua;
  remove bereq.http.x-up-calling-line-id;
  remove bereq.http.x-up_devcap-screendepth;
  remove bereq.http.x-view-mode;
  remove bereq.http.x-wap-network-client-msisdn;
  remove bereq.http.x-wap-profile;
  remove bereq.http.x-wap-profile-diff;
  remove bereq.http.x-pingback;
}
