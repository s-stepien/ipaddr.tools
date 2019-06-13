defmodule IpaddrCommonIpTest do
  import Ipaddr.Common.Ip

  use ExUnit.Case
  doctest Ipaddr.Common.Ip

  test "change ip to string" do
    assert ip_to_string!({127, 0, 0, 1}) == "127.0.0.1"
    assert ip_to_string({192, 168, 255, 10}) == {:ok, "192.168.255.10"}
    assert ip_to_string({8193, 3512, 34211, 0, 0, 35374, 880, 29492}) == {:ok, "2001:db8:85a3::8a2e:370:7334"}
    assert ip_to_decimal({127, 0, 0, 1}) == 2130706433
    assert ip_to_decimal({8193, 18528, 18528, 0, 0, 0, 0, 34952}) == 42541956123769884636017138956568135816
  end
end
