defmodule Ipaddr.Http.Country do
  @moduledoc """
  Module that handles /country and /country-iso route paths.
  """

  import Ipaddr.Common.Geo
  import Ipaddr.Common.Conn

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
  def call(%Plug.Conn{request_path: "/country-iso"} = conn, _opts) do
    case lookup_country(conn.remote_ip) do
      {:ok, _, _, iso} ->
        send_plain({:ok, iso}, conn)
      {:error, reason} ->
        send_plain({:error, reason}, conn)
    end
  end

  @spec call(Plug.Conn.t, list) :: Plug.Conn.t
  def call(conn, _opts) do
    case lookup_country(conn.remote_ip) do
      {:ok, country, _, _} ->
        send_plain({:ok, country}, conn)
      {:error, reason} ->
        send_plain({:error, reason}, conn)
    end
  end
end
