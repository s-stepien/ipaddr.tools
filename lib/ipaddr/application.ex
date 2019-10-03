defmodule Ipaddr.Application do
  @moduledoc """
  This module will start a root supervisor with two Cowboy servers.
  """

  use Application

  defp add_server(%{id: "http", enable: true, port: port} = _server) do
    [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Ipaddr.Router,
        options: [
          port: port
        ]
      )
    ]
  end

  defp add_server(%{id: "https", enable: true, port: port, keyfile: keyfile, certfile: certfile} = _server) do
    [
      Plug.Cowboy.child_spec(
        scheme: :https,
        plug: Ipaddr.Router,
        options: [
          port: port,
          certfile: certfile,
          keyfile: keyfile,
        ]
      )
    ]
  end

  defp add_server(_server) do
    []
  end

  @doc """
  A callback that will be used to start the ipaddr application
  """
  @spec start(Application.start_type, start_args :: term) :: {:ok, pid} | {:ok, pid, Application.state} | {:error, reason :: term}
  def start(_type, _args) do
    config = Application.get_env(:ipaddr, :servers, [])

    children =
      Enum.reduce(config, [], fn server, servers ->
        servers ++ add_server(server)
      end)

    opts = [strategy: :one_for_one, name: Ipaddr.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
