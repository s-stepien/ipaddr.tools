defmodule IpaddrCommonGeoTest do
  import Ipaddr.Common.Geo
  use ExUnit.Case
  doctest Ipaddr.Common.Geo

  test "change ip to location" do
    assert lookup_location("213.180.141.140") == {:ok, 52.2492, 21.0003}
  end

  test "change ip to city" do
    assert lookup_city("213.180.141.140") == {:ok, "Warsaw"}
  end

  test "change ip to country" do
    assert lookup_country({212, 77, 98, 9}) == {:ok, "Poland", true, "PL"}
  end
end
