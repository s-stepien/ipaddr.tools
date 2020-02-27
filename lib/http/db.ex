defmodule Ipaddr.Http.Db do
  @moduledoc """
  This module handles /db/* route path.
  """

  import Ipaddr.Common.Conn

  defp to_atom(db) do
    try do
      {:ok, String.to_existing_atom(db)}
    rescue
      e in ArgumentError -> {:error, e.message}
    end
  end

  defp get_build_epoch({:ok, id}) do
    {%MMDB2Decoder.Metadata{build_epoch: epoch}, _, _} = Geolix.Adapter.MMDB2.Storage.get(id)
    {:ok, "#{epoch}"}
  end

  defp get_build_epoch({:error, reason}) do
    {:error, reason}
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
    conn.path_params["id"]
    |> to_atom()
    |> get_build_epoch()
    |> send_plain(conn)
  end
end
