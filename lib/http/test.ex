defmodule Ipaddr.Http.Test do
  @moduledoc """
  A test plug that handles /test route.
  """

  import Plug.Conn

  @doc """
  This function will init this plug with opts.
  """
  @spec init(list) :: list
  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Test")
  end
end
