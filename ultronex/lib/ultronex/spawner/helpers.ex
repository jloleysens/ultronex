defmodule Ultronex.Spawner.Helpers do

  defmacro __using__(_) do
    quote do
      import Supervisor.Spec

      @path_to_scripts "lib/ultronex/scripts"

      def list_scripts do
        {:ok, scripts} = File.ls(@path_to_scripts)
      end

      @spec running?(String.t) :: boolean
      def running?(domain) do
      end

      def start(domain) do
        children = [
          worker(CollectionSupervisor, [domain], restart: :transient)
        ]
        Supervisor.start_child(children, strategy: :simple_one_for_one)
      end

    end
  end

end
