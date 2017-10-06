VirtualHost "localhost"
    enabled = true;
    authentication = "internal_plain";

    ssl = {
      key = "/jitsi-meet/data/ssl.key";
      certificate = "/jitsi-meet/data/ssl.crt";
    }

    modules_enabled = {
      "bosh";
      "pubsub";
      "ping";
      "time";
      "uptime";
    }

VirtualHost "auth.localhost"
    authentication = "internal_plain"

admins = { "focus@auth.localhost" }

Component "conference.localhost" "muc"

Component "focus.localhost"
    component_secret="secret"

Component "jitsi-videobridge.localhost"
    component_secret="secret"
