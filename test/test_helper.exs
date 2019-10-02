defmodule Helper do
  def check() do
    IO.write(".")
    Process.send_after(self(), :check, 1000)
  end

  def loop() do
    receive do
      :check ->
        if length(Geolix.Database.Loader.loaded_databases()) == 2 do
          IO.puts("done")
          ExUnit.start()
        else
          check()
          loop()
      end
    end
  end
end

IO.write("Waiting for databases")

Helper.check()
Helper.loop()
