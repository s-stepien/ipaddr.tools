defmodule IpaddrCommonGeoTest do
  import Ipaddr.Common.Geo
  use ExUnit.Case
  doctest Ipaddr.Common.Geo

  test "change ip to location" do
    assert lookup_location("213.180.141.140") == {:ok, 52.2394, 21.0362}
  end

  test "change ip to city" do
    assert lookup_city("80.252.0.145") == {:ok, "Warsaw"}
  end

  test "change ip to country" do
    assert lookup_country({212, 77, 98, 9}) == {:ok, "Poland", true, "PL"}
  end

  test "change ip to asn" do
    assert lookup_asn("213.180.141.140") == {:ok, "AS12990"}
  end

  test "change ip to aso" do
    assert lookup_aso("213.180.141.140") == {:ok, "Ringier Axel Springer Polska Sp. z o.o."}
  end

end
