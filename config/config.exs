use Mix.Config

config :geolix,
  databases: [
    %{
      id: :city,
      adapter: Geolix.Adapter.MMDB2,
      source: File.cwd!() <> "/db/GeoLite2-City.mmdb",
    },
    %{
      id: :country,
      adapter: Geolix.Adapter.MMDB2,
      source: File.cwd!() <> "/db/GeoLite2-Country.mmdb",
    }
  ]
