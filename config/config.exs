import Config

config :ipaddr,
  servers: [
    %{
      id: "https",
      enable: false,
      port: 8443,
      certfile: "/etc/letsencrypt/live/ipaddr.tools/fullchain.pem",
      keyfile: "/etc/letsencrypt/live/ipaddr.tools/privkey.pem",
    },
    %{
      id: "http",
      enable: true,
      port: 8080,
    }
  ]

config :geolix,
  databases: [
    %{
      id: :city,
      adapter: Geolix.Adapter.MMDB2,
      source: "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-City&license_key=YOUR_KEY_HERE&suffix=tar.gz",
    },
    %{
      id: :country,
      adapter: Geolix.Adapter.MMDB2,
      source: "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-Country&license_key=YOUR_KEY_HERE&suffix=tar.gz",
    },
    %{
      id: :asn,
      adapter: Geolix.Adapter.MMDB2,
      source: "https://download.maxmind.com/app/geoip_download?edition_id=GeoLite2-ASN&license_key=YOUR_KEY_HERE&suffix=tar.gz",
    },
  ]
