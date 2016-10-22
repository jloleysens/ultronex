defmodule Ultronex.Scraper.Supervisor do
  import Supervisor.Spec

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def start_child(name) do
    Supervisor.start_child(name)
  end

  def init(domain) do
    children = [
      worker(Ultronex.Scraper, [domain], restart: :transient)
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
