defmodule Ultronex.Spawner do
  use GenServer
  use Ultronex.Spawner.Helpers
  import Ultronex.WorkerState

  ## A GenServer which checks the state of the current workers

  ## Client API
  
  @doc """
  Starts registry with a name
  """
  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  ## Server Callbacks
  
  def init(:ok) do

    {:ok, data_sources} = list_scripts


    # Read all of the data sources into the state map and init with empty worker states

    state = data_sources
            |> Enum.map(fn domain -> Map.put(%{}, domain, %Ultronex.WorkerState{}) end)
            |> Enum.reduce(%{}, &Enum.into/2)

    Process.send_after(self(), :check, :timer.seconds(1))
    {:ok, state}
  end

  def handle_info(:check, state) do

    # Run checks against the data sources
    state = spawn!(state)
    IO.inspect state
    # Set up the next message
    Process.send_after(self(), :check, :timer.seconds(1))
    {:noreply, state}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

end
