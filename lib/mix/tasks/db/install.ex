defmodule Mix.Tasks.Ipaddr.Db.Install do
  use Mix.Task

  @shortdoc "Installs the geolocation databases"
  @moduledoc """
  This task will use the 'install_db.sh' script to install the geolocation databases into 'db' subdirectory of the main project.
  """
  @impl Mix.Task
  def run(args) do
    System.cmd(File.cwd! <> "/install_db.sh", args)
  end
end
