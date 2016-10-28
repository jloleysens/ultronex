defmodule Ultronex.Registry do
  use GenServer

  ## Client API

  @doc """
  Starts the registry with a name
  """
  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  @doc """
  Look up the scraper pid for 'name' stored in 'server'.

  Returns '{:ok, pid}' if the bucket exists, ':error' otherwise.
  """
  def lookup(server, name) do
    GenServer.call(server, {:lookup, name})
  end

  @doc """
  Create a scraper for 'name' in 'server' if one does not exist
  """
  def create(server, name) do
    GenServer.call(server, {:create, name})
  end

  @doc """
  Stops the registry
  """
  def stop(server) do
    GenServer.stop(server)
  end

  ## Server Callbacks
  

  def init(:ok) do
    names = %{}
    refs = %{}
    {:ok, {names, refs}}
  end

  def handle_call({:lookup, name}, _from, {names, _} = state) do
    {:reply, Map.fetch(names, name), state}
  end

  def handle_call({:create, name}, _from, {names, refs} = state ) do
    if Map.has_key?(names, name) do
      {:reply, name, state}
    else
      # Do not link the registry to the scraper directly, rather call supervisor
      {:ok, pid} = Ultronex.Scraper.Supervisor.start_scraper(name)
      ref = Process.monitor(pid)
      refs = Map.put(refs, ref, name)
      names = Map.put(names, name, pid)
      {:reply, name, {names, refs}}
    end
  end

  # Take the following action for DOWN message (when the process terminates for whatever reason)
  def handle_info({:DOWN, ref, :process, _pid, _reason}, {names, refs}) do
    {name, refs} = Map.pop(refs, ref)
    names = Map.delete(names, name)
    {:noreply, {names, refs}}
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end

end
