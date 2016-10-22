defmodule Ultronex.Supervisor do
  import Supervisor.Spec

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(Ultronex.Spawner, [Ultronex.Spawner]),
      supervisor(Task.Supervisor, [[name: Ultronex.Scraper.Supervisor]])
    ]

    supervise(children, strategy: :rest_for_one)
  end
end
