defmodule Ipaddr.Http.Asn do
  @moduledoc """
  Module that handles /asn route path.
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
  def call(conn, _opts) do
    conn.remote_ip
    |> lookup_asn()
    |> send_plain(conn)
  end
end
