defmodule Ipaddr.Common.UserAgent do
  @moduledoc """
  A set of functions for working with user agent.
  """

  defp parse_header({"user-agent", user_agent}, _), do: user_agent
  defp parse_header(_, acc), do: acc

  defp parse_req_headers(headers) do
    Enum.reduce(headers, nil, &parse_header/2)
  end

  @doc """
  This function will get the User-Agent value from connection
  """
  @spec lookup_user_agent(Plug.Conn.t) :: {:ok, String.t} | {:error, String.t}
  def lookup_user_agent(conn) do
    case parse_req_headers(conn.req_headers) do
      nil ->
        {:error, "User-Agent not found"}
      user_agent ->
        {:ok, user_agent}
    end
  end
end
