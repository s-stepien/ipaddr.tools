defmodule Ipaddr.MixProject do
  use Mix.Project

  def project do
    [
      app: :ipaddr,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        ipaddr: [
          applications: [
            mmdb2_decoder: :permanent,
            inets: :permanent,
          ],
        ],
      ],
    ]
  end

  def application do
    [
      extra_applications: [:logger, :geolix],
      mod: {Ipaddr.Application, []}
    ]
  end

  defp deps do
    [
      {:plug_cowboy, "~> 2.0"},
      {:jason, "~> 1.1"},
      {:geolix, "~> 2.0.0"},
      {:geolix_adapter_mmdb2, git: "https://github.com/elixir-geolix/adapter_mmdb2.git"},
      {:slime, git: "https://github.com/slime-lang/slime"},
      #{:remote_ip, "~> 0.1.0"},
      {:benchee, "~> 1.0", only: [:dev, :test]},
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0-rc.6", only: [:dev, :test], runtime: false},
    ]
  end
end
