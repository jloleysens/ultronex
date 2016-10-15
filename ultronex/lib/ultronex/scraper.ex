defmodule Ultronex.Scraper do
  use Hound.Helpers

  @path_to_scripts "lib/ultronex/scripts/"

  def run_script(name) do
    Code.eval_file(@path_to_scripts <> name)
  end

  @doc """
  Start a new scraper
  """
  def start_link(domain) do
    Task.start_link(fn -> run_script(domain) end)
  end

end
