use Mix.Config

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
      source: "http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz",
    },
    %{
      id: :country,
      adapter: Geolix.Adapter.MMDB2,
      source: "http://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz",
    }
  ]
