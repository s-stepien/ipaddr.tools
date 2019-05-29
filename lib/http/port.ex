defmodule Ipaddr.Http.Port do
  @moduledoc """
  This module handles /port/:port route path.
  """

  import Ipaddr.Common.Ip
  import Ipaddr.Common.Conn

  defp reachable?(ip, port) do
    case :gen_tcp.connect(ip, port, [], 5_000) do
      {:ok, socket} ->
        :gen_tcp.close(socket)
        true
      _ ->
        false
    end
  end

  defp build_response({remote_ip, port}) do
    %{
      ip: ip_to_string!(remote_ip),
      port: port,
      reachable: reachable?(remote_ip, port)
    }
  end

  defp port_valid?(port) when (port < 1) or (port > 65_535), do: false
  defp port_valid?(_), do: true

  defp parse_port(port) do
    case Integer.parse(port) do
      {port, _} ->
        case port_valid?(port) do
          true ->
            {:ok, port}
          false ->
            {:error, "invalid port: #{port}"}
        end
      :error ->
        {:error, "invalid port: #{port}"}
    end
  end

  @doc """
  This function will init this plug with opts.
  """
  @spec init(list) :: list
  def init(opts) do
    opts
  end

  @doc """
  This function will generate the response to given conn.
  """
  @spec call(Plug.Conn.t, list) :: Plug.Conn.t
  def call(conn, _opts) do
    case parse_port(conn.path_params["port"]) do
      {:ok, port} ->
        {conn.remote_ip, port}
        |> build_response()
        |> response_to_json()
        |> send_json(conn)
      {:error, reason} ->
        send_json({:error, reason}, conn)
    end
  end
end
