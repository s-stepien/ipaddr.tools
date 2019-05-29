defmodule Ipaddr.Http.Template do
  @moduledoc """
  """

  require Slime

  Slime.function_from_file :def, :generate, "lib/http/index.slime", [:params]
end
