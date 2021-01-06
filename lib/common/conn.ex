defmodule Ipaddr.Common.Conn do
  @moduledoc """
  A set of helper functions that could be used to send different types of data.
  """

  import Plug.Conn

  @doc """
  This is a helper function that will transform the given response into json using Jason.
  The opts will be used by the json engine (Jason).

  ## Examples

      iex> Ipaddr.Common.Conn.response_to_json(%{field => true})
      {:ok, "{\"field\":true}"}

  """
  @spec response_to_json(map, list) :: {:ok | :error, String.t}
  def response_to_json(response, opts \\ []) do
    case Jason.encode(response, opts) do
      {:ok, json} ->
        {:ok, json}
      {:error, %Jason.EncodeError{message: reason}} ->
        {:error, reason}
      {:error, %Protocol.UndefinedError{description: reason}} ->
        {:error, reason}
    end
  end

  @doc """
  Send json as the response to the conn.
  This function will set correct content type and HTTP code.
  """
  @spec send_json({:ok, String.t}, Plug.Conn.t) :: Plug.Conn.t
  def send_json({:ok, json}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, json)
  end

  @spec send_json({:error, String.t}, Plug.Conn.t) :: Plug.Conn.t
  def send_json({:error, reason}, conn) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(500, "{\"error\":\"#{reason}\"}")
  end

  @doc """
  Send plain text as response to conn.
  This function will set correct content type and HTTP code.
  """
  @spec send_plain({:ok, String.t}, Plug.Conn.t) :: Plug.Conn.t
  def send_plain({:ok, text}, conn) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, text <> "\n")
  end

  @spec send_plain({:error, String.t}, Plug.Conn.t) :: Plug.Conn.t
  def send_plain({:error, reason}, conn) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(500, reason <> "\n")
  end
end
