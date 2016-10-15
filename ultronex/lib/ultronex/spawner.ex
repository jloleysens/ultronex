defmodule Ultronex.Spawner do
  use GenServer
  use Ultronex.Spawner.Helpers

  ## A GenServer which just checks the state of the current workers
  

  # Worker state struct
  defmodule WorkerState do
    defstruct last_run: nil,
              last_run_success: nil,
              times_run: 0
  end

  ## Client API
  
  @doc """
  Starts registry with a name
  """
  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  ## Server Callbacks
  
  def init(:ok) do
    # Stores a map of worker states
    state = %{}
    Process.send_after(self(), :check, :timer.seconds(1))
    {:ok, state}
  end

  def handle_info(:check, state) do
    # Check which data sources need to be run

    # Check what data sources are running
    # Start what needs to be started...
    Process.send_after(self(), :check, :timer.seconds(1))
    {:noreply, state}
  end

end
