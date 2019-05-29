defmodule IpaddrCommonGeoTest do
  import Ipaddr.Common.Geo
  use ExUnit.Case
  doctest Ipaddr.Common.Geo

  test "change ip to location" do
    assert lookup_location({212, 77, 98, 9}) == {:ok, 54.3584, 18.6529}
  end

  test "change ip to city" do
    assert lookup_city({212, 77, 98, 9}) == {:ok, "Gdańsk"}
  end

  test "change ip to country" do
    assert lookup_country({212, 77, 98, 9}) == {:ok, "Poland", true, "PL"}
  end
end
