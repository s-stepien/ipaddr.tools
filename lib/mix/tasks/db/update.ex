defmodule Mix.Tasks.Ipaddr.Db.Update do
  use Mix.Task

  @shortdoc "Updates the geolocation databases and reloads them"
  @moduledoc """
  This task will install the newest available geolocation databases.
  To reaload the databases type Geolix.reload_databases() in application iex shell.
  """
  @impl Mix.Task
  def run(args) do
    System.cmd(File.cwd! <> "/install_db.sh", args)
  end
end
