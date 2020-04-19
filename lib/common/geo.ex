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

  defp parse_asn(nil), do: {:error, "Result is nil"}
  defp parse_asn(%Geolix.Adapter.MMDB2.Result.ASN{autonomous_system_number: asn} = _c) when is_nil(asn), do: {:error, "Problem getting asn record"}
  defp parse_asn(%Geolix.Adapter.MMDB2.Result.ASN{autonomous_system_number: asn} = _c) do
    {:ok, "AS" <> Integer.to_string(asn)}
  end

  @doc """
  Translate ip address to ASN number.

  The data is taken from MMDB2 database.
  The app's config/config.exs is responsible for setting the database files paths.

  ## Examples

  iex> Ipaddr.Common.Geo.lookup_asn({23,22,39,120})
  {:ok, "AS14618"}

  """
  @spec lookup_asn(:inet.ip_address) :: {:ok, String.t} | {:error, String.t}
  def lookup_asn(ip) do
    ip
    |> Geolix.lookup(where: :asn)
    |> parse_asn()
  end

  defp parse_aso(nil), do: {:error, "Result is nil"}
  defp parse_aso(%Geolix.Adapter.MMDB2.Result.ASN{autonomous_system_organization: aso} = _c) when is_nil(aso), do: {:error, "Problem getting aso record"}
  defp parse_aso(%Geolix.Adapter.MMDB2.Result.ASN{autonomous_system_organization: aso} = _c) do
    {:ok, aso}
  end

  @doc """
  Translate ip address to ASN organization.

  The data is taken from MMDB2 database.
  The app's config/config.exs is responsible for setting the database files paths.

  ## Examples

  iex> Ipaddr.Common.Geo.lookup_aso({23,22,39,120})
  {:ok, "AMAZON-AES"}

  """
  @spec lookup_aso(:inet.ip_address) :: {:ok, String.t} | {:error, String.t}
  def lookup_aso(ip) do
    ip
    |> Geolix.lookup(where: :asn)
    |> parse_aso()
  end
end
