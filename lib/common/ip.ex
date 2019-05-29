defmodule Ipaddr.Common.Ip do
  @moduledoc """
  A set of functions for working with ip addresses.

  Here you will find functions that will transform ip address to:
  * string (`ip_to_string` and `ip_to_string!`)

  The type of ip for that functions is `:inet.ip_address`.
  """

  @doc """
  Parses an `:inet.ip_address()` and returns an IPv4 or IPv6 address string.

  ## Examples

      iex> Ipaddr.Common.Ip.ip_to_string!({127,0,0,1})
      "127.0.0.1"

  """
  @spec ip_to_string!(:inet.ip_address) :: String.t
  def ip_to_string!(ip) do
    ip
    |> :inet.ntoa()
    |> to_string()
  end

  @doc """
  Parses an `:inet.ip_address()` and returns an IPv4 or IPv6 address string in a
  `:ok` tuple.

  ## Examples

      iex> Ipaddr.Common.Ip.ip_to_string({127,0,0,1})
      {:ok, "127.0.0.1"}

  """
  @spec ip_to_string(:inet.ip_address) :: {:ok, String.t}
  def ip_to_string(ip) do
    {:ok, ip_to_string!(ip)}
  end

  @doc """
  Translate ipv4 address to decimal value.

  ## Examples

      iex> Ipaddr.Common.Ip.ip_to_decimal({78,11,8,249})
      1309346041

  """
  @spec ip_to_decimal(:inet.ip4_address) :: number
  def ip_to_decimal({o1, o2, o3, o4}) do
    <<i :: size(32)>> = <<o1, o2, o3, o4>>
    i
  end

  @doc """
  Translate ipv6 address to decimal value.

  ## Examples

      iex> Ipaddr.Common.Ip.ip_to_decimal({8193,18528,18528,0,0,0,0,34952})
      42541956123769884636017138956568135816

  """
  @spec ip_to_decimal(:inet.ip6_address) :: number
  def ip_to_decimal({o1, o2, o3, o4, o5, o6, o7, o8}) do
    <<i :: big-integer-size(128)>> = <<o1 :: big-integer-size(16), o2 :: big-integer-size(16), o3 :: big-integer-size(16), o4 :: big-integer-size(16), o5 :: big-integer-size(16), o6 :: big-integer-size(16), o7 :: big-integer-size(16), o8 :: big-integer-size(16)>>
    i
  end
end
