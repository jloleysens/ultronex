defmodule Ultronex do
  use Application

  @doc """
  The entry point for the Ultronex application

  Start the Ultronex Supervisor
  """
  def start(_type, _args) do
    Ultronex.Supervisor.start_link
  end

end
