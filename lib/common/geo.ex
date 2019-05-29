defmodule Ipaddr.Common.Geo do
  @moduledoc """
  A set of functions for getting data out of the MMDB2 databases.
  """

  @type lat :: number
  @type lon :: number

  defp parse_location(nil), do: {:error, "Result is nil"}
  defp parse_location(%Geolix.Adapter.MMDB2.Result.City{location: record} = _c) when is_nil(record), do: {:error, "Problem getting location record"}
  defp parse_location(%Geolix.Adapter.MMDB2.Result.City{location: record} = _c) do
    {:ok, record.latitude, record.longitude}
  end

  @doc """
  This function will transform the ip address into location tuple.

  The data is taken from MMDB2 database.
  The app's config/config.exs is responsible for setting the database files paths.

  ## Examples

      iex> Ipaddr.Common.Geo.lookup_location({8,8,8,8})
      {:ok, 37.751, -97.822}

  """
  @spec lookup_location(:inet.ip_address) :: {:ok, lat, lon} | {:error, String.t}
  def lookup_location(ip) do
    ip
    |> Geolix.lookup(where: :city)
    |> parse_location()
  end

  defp parse_city(nil), do: {:error, "Result is nil"}
  defp parse_city(%Geolix.Adapter.MMDB2.Result.City{city: record} = _c) when is_nil(record), do: {:error, "Problem getting city record"}
  defp parse_city(%Geolix.Adapter.MMDB2.Result.City{city: record} = _c) do
    {:ok, record.name}
  end

  @doc """
  This function will lookup a city name associated with the given ip.

  The data is taken from MMDB2 database.
  The app's config/config.exs is responsible for setting the database files paths.

  ## Examples

      iex> Ipaddr.Common.Geo.lookup_city({23,22,39,120})
      {:ok, "Ashburn"}

  """
  @spec lookup_city(:inet.ip_address) :: {:ok, String.t} | {:error, String.t}
  def lookup_city(ip) do
    ip
    |> Geolix.lookup(where: :city)
    |> parse_city()
  end

  defp parse_country(nil), do: {:error, "Result is nil"}
  defp parse_country(%Geolix.Adapter.MMDB2.Result.Country{country: record} = _c) when is_nil(record), do: {:error, "Problem getting country record"}
  defp parse_country(%Geolix.Adapter.MMDB2.Result.Country{country: record} = _c) do
    {:ok, record.name, record.is_in_european_union, record.iso_code}
  end

  @doc """
  Translate ip address to country tuple.
  The tuple will have:
  * country full name,
  * information if the country is in EU,
  * country ISO name

  The data is taken from MMDB2 database.
  The app's config/config.exs is responsible for setting the database files paths.

  ## Examples

      iex> Ipaddr.Common.Geo.lookup_country({23,22,39,120})
      {:ok, "United States", false, "US"}

  """
  @spec lookup_country(:inet.ip_address) :: {:ok, String.t, boolean, String.t} | {:error, String.t}
  def lookup_country(ip) do
    ip
    |> Geolix.lookup(where: :country)
    |> parse_country()
  end
end
