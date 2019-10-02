use Mix.Config

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
