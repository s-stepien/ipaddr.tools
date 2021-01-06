defmodule Ipaddr.Http.Ip do
  @moduledoc false

  import Plug.Conn
  import Ipaddr.Common.Ip
  import Ipaddr.Common.Geo
  import Ipaddr.Common.Conn
  import Ipaddr.Common.UserAgent

  @doc """
  This function will init this plug with opts.
  """
  @spec init(list) :: list
  def init(opts) do
    opts
  end

  defp build_response(conn) do
    remote_ip = conn.remote_ip

    data = %{
      ip: ip_to_string!(remote_ip),
      ip_decimal: ip_to_decimal(remote_ip),
    }

    data = case lookup_country(remote_ip) do
      {:ok, country, country_eu, country_iso} ->
        data
        |> Map.put(:country, country)
        |> Map.put(:country_eu, country_eu)
        |> Map.put(:country_iso, country_iso)
      _ ->
        data
    end

    data = case lookup_city(remote_ip) do
      {:ok, city} ->
        Map.put(data, :city, city)
      _ ->
        data
    end

    data = case lookup_location(remote_ip) do
      {:ok, latitude, longitude} ->
        data
        |> Map.put(:latitude, latitude)
        |> Map.put(:longitude, longitude)
      _ ->
        data
    end

    data = case lookup_asn(remote_ip) do
      {:ok, asn} ->
        Map.put(data, :asn, asn)
      _ ->
        data
    end

    data = case lookup_aso(remote_ip) do
      {:ok, aso} ->
        Map.put(data, :aso, aso)
      _ ->
        data
    end

    data = case lookup_user_agent(conn) do
      {:ok, user_agent} ->
        Map.put(data, :user_agent, user_agent)
      _  ->
        data
    end

    case :inet.gethostbyaddr(remote_ip) do
      {:ok, {:hostent, hostname, _, _, _, _}} ->
        Map.put(data, :hostname, to_string(hostname))
      _ ->
        data
    end
  end

  defp build_template_data(response, host) do
    data = with true <- Map.has_key?(response, :longitude),
                true <- Map.has_key?(response, :latitude) do
      %{
        box_lon_left: response.longitude - 0.05,
        box_lon_right: response.longitude + 0.05,
        box_lat_bottom: response.latitude - 0.05,
        box_lat_top: response.latitude + 0.05,
      }
    else
      false ->
        %{}
    end

    case response_to_json(response, [pretty: true]) do
      {:ok, json} ->
        data = data
               |> Map.put(:host, host)
               |> Map.put(:data, response)
               |> Map.put(:json, json)
        {:ok, data}
      {:error, reason} ->
        {:error, reason}
    end
  end

  defp call_json(conn) do
    conn
    |> build_response()
    |> response_to_json()
    |> send_json(conn)
  end

  defp call_html(conn) do
    conn = put_resp_content_type(conn, "text/html")

    with {:ok, data} <- conn
                        |> build_response()
                        |> build_template_data(conn.host) do
      send_resp(conn, 200, Ipaddr.Http.Template.generate(data))
    else
      {:error, reason} ->
        send_resp(conn, 500, "Internal server error #{reason}")
    end
  end

  defp call_plain(conn) do
    conn.remote_ip
    |> ip_to_string()
    |> send_plain(conn)
  end

  @doc """
  This function will generate the response to given conn.
  """
  @spec call(Plug.Conn.t, list) :: Plug.Conn.t
  def call(%Plug.Conn{request_path: "/json"} = conn, _opts) do
    call_json(conn)
  end

  @spec call(Plug.Conn.t, list) :: Plug.Conn.t
  def call(%Plug.Conn{request_path: "/"} = conn, _opts) do
    accepts = case get_req_header(conn, "accept") do
      [] ->
        ""
      [accepts] ->
        accepts
    end

    cond do
      String.contains?(accepts, "text/html") ->
        call_html(conn)
      String.contains?(accepts, "application/json") ->
        call_json(conn)
      true ->
        call_plain(conn)
    end
  end

  @spec call(Plug.Conn.t, list) :: Plug.Conn.t
  def call(conn, _opts) do
    call_plain(conn)
  end
end
