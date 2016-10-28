defmodule Ultronex.Spawner.Helpers do

  defmacro __using__(_) do
    quote do
      use Timex
      import Ultronex.Scraper
      import Ultronex.WorkerState

      @path_to_scripts "lib/ultronex/scripts"

      @doc """
      List all of the scripts that need to be run
      """
      def list_scripts do
        {:ok, scripts} = File.ls(@path_to_scripts)
      end


      @doc """
      Spawn the new scrapers or check APIs and return the new state
      """
      def spawn!(worker_states) do
        # Create a list of all the scripts that need to be run
        workers_to_run = Enum.reduce(
                                     Map.keys(worker_states), 
                                     [],
                                     fn(x, acc) -> 
                                       if _run?(worker_states[x]) === true, do: acc ++ [x] 
                                     end
                                   )

        if workers_to_run !== nil do
          new_state = Enum.reduce(
                                  workers_to_run, 
                                  %{}, 
                                  fn(worker, acc) ->
                                    {:ok, pid, domain} = _start!(worker)
                                    Map.put(acc, worker, %Ultronex.WorkerState{
                                            last_run: Timex.now,
                                            domain: domain,
                                            pid: pid
                                          })
                                  end
                                )

          Map.merge(worker_states, new_state)
        else
          worker_states
        end

      end

      ## Private functions below

      defp _start!(domain) do
        {:ok, pid} = Task.Supervisor.start_child(Ultronex.Scraper.Supervisor, fn -> Ultronex.Scraper.start_link(domain)  end)
        {:ok, pid, domain}
      end

      defp _run?(worker) do
        # nil if it hasn't reached this function before
        cond do
          worker.last_run === nil ->
            true
          # Timex.diff(Timex.now, worker.last_run) > 120000000 and !Process.alive?(worker.pid) ->
          Timex.diff(Timex.now, worker.last_run) > 1200000 and !Process.alive?(worker.pid) ->
            true
          true ->
            false
        end
      end

    end
  end

end
