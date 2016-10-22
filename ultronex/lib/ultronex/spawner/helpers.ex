defmodule Ultronex.Spawner.Helpers do

  defmacro __using__(_) do
    quote do
      use Timex
      import Ultronex.WorkerState

      @path_to_scripts "lib/ultronex/scripts"

      @doc """
      List all of the scripts that need to be run
      """
      def list_scripts do
        {:ok, scripts} = File.ls(@path_to_scripts)
      end

      defp _start!(domain) do
        Task.Supervisor.start_child(Ultronex.Scraper, fn(x) -> IO.puts "Hello!" end)
        # children = [
        #   worker(CollectionSupervisor, [domain], restart: :transient)
        # ]
        # Supervisor.start_child(children, strategy: :simple_one_for_one)
      end


      @doc """
      Spawn the new scrapers or check APIs and return the new state
      """
      def spawn!(worker_states) do
        # Create a list of all the scripts that need to be run
        workers_to_run = Enum.reduce(Map.keys(worker_states), [],
                                     fn(x, acc) -> 
                                       if _run?(worker_states[x]) === true, do: acc ++ [x] 
                                     end)

        if workers_to_run !== nil do
          new_state = Enum.reduce(workers_to_run, %{}, 
                                   fn(worker, acc) ->
                                     _start!(worker)
                                     Map.put(acc, worker, %Ultronex.WorkerState{last_run: Timex.now})
                                   end)

          Map.merge(worker_states, new_state)
        else
          worker_states
        end

      end

      defp _run?(worker) do
        if worker.last_run == nil do
          true
        end
      end

    end
  end

end
