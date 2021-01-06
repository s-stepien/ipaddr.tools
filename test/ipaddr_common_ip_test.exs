defmodule IpaddrCommonIpTest do
  import Ipaddr.Common.Ip

  use ExUnit.Case
  doctest Ipaddr.Common.Ip

  test "change ip to string" do
    assert ip_to_string!({127, 0, 0, 1}) == "127.0.0.1"
    assert ip_to_string({192, 168, 255, 10}) == {:ok, "192.168.255.10"}
    assert ip_to_string({8193, 3512, 34_211, 0, 0, 35_374, 880, 29_492}) == {:ok, "2001:db8:85a3::8a2e:370:7334"}
    assert ip_to_decimal({127, 0, 0, 1}) == 2_130_706_433
    assert ip_to_decimal({8193, 18_528, 18_528, 0, 0, 0, 0, 34_952}) == 42_541_956_123_769_884_636_017_138_956_568_135_816
  end
end
