defmodule Ultronex.Scraper.Supervisor do
  use Supervisor


  # Module variable to store the supervisor name
  @name Ultronex.Scraper.Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: @name)
  end

  def start_scraper(domain) do
    Supervisor.start_child(@name, [domain])
  end

  def init(:ok) do
    children = [
      worker(Ultronex.Scraper, [], restart: :transient)
    ]


    supervise(children, strategy: :simple_one_for_one)
  end
  
end
