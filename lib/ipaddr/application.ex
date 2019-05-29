defmodule Ipaddr.Application do
  @moduledoc """
  This module will start a root supervisor with two Cowboy servers.
  """

  use Application

  @doc """
  A callback that will be used to start the ipaddr application
  """
  @spec start(Application.start_type, start_args :: term) :: {:ok, pid} | {:ok, pid, Application.state} | {:error, reason :: term}
  def start(_type, _args) do
    children = [
      # HTTPS server specification
      Plug.Cowboy.child_spec(scheme: :https, plug: Ipaddr.Router, options: [
        port: 443,
        certfile: "/etc/letsencrypt/live/ipaddr.tools/fullchain.pem",
        keyfile: "/etc/letsencrypt/live/ipaddr.tools/privkey.pem",
      ]),

      # HTTP server specification
      Plug.Cowboy.child_spec(scheme: :http, plug: Ipaddr.Router, options: [port: 80]),
    ]

    opts = [strategy: :one_for_one, name: Ipaddr.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
