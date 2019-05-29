defmodule Mix.Tasks.Ipaddr.Db.Update do
  use Mix.Task

  @shortdoc "Updates the geolocation databases and reloads them"
  @moduledoc """
  This task will install the newest available geolocation databases and will reload them in running application.
  """
  @impl Mix.Task
  def run(args) do
    System.cmd(File.cwd! <> "/install_db.sh", args)
    Geolix.reload_databases()
  end
end
