defmodule Ipaddr.Database do
  @moduledoc """
  A set of functions that will determine when the GeoLite2 databases are ready.
  """

  defp check() do
    IO.write(".")
    Process.send_after(self(), :check, 1000)
  end

  defp loop() do
    db = Application.get_env(:geolix, :databases, [])
    receive do
      :check ->
        if length(Geolix.Database.Loader.loaded_databases()) == length(db) do
          IO.puts("done")
        else
          check()
          loop()
      end
    end
  end

  def wait_until_ready() do
    IO.write("Downloading databases")
    check()
    loop()
  end
end
