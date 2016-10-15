defmodule Ultronex.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(Ultronex.Registry, [Ultronex.Registry]),
      supervisor(Ultronex.Scraper.Supervisor, []),
      worker(Ultronex.Spawner, [Ultronex.Spawner])
    ]

    supervise(children, strategy: :rest_for_one)
  end
end
