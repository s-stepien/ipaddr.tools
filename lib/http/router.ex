defmodule Ipaddr.Router do
  @moduledoc """
  This is the application router. It will route the given paths to given plug modules.
  """

  use Plug.Router

  #plug RemoteIp
  plug :match
  plug :dispatch

  get "/",            to: Ipaddr.Http.Ip
  get "/ip",          to: Ipaddr.Http.Ip
  get "/json",        to: Ipaddr.Http.Ip
  get "/country",     to: Ipaddr.Http.Country
  get "/country-iso", to: Ipaddr.Http.Country
  get "/city",        to: Ipaddr.Http.City
  get "/coordinates", to: Ipaddr.Http.Coordinates
  get "/port/:port",  to: Ipaddr.Http.Port

  get "/test",        to: Ipaddr.Http.Test

  match _ do
    send_resp(conn, 404, "Not found")
  end
end
