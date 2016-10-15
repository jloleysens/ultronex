defmodule Ultronex.Spawner.Helpers do

  # Module attribute that stores the path to the scripts
  @path_to_scripts "lib/ultronex/scripts"

  def list_scripts do
    {:ok, scripts} = File.ls(@path_to_scripts)
    Enum.each(scripts, &IO.puts(&1))
  end

  @spec running?(String.t) :: boolean
  def running?(domain) do
  end

  def start(domain) do
  end

end
