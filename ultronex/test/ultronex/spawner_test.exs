defmodule Ultronex.SpawnerTest do
  use ExUnit.Case, async: true

  setup context do
    {:ok, spawner} = Ultronex.Spawner.start_link(context.test)
    {:ok, spawner: spawner}
  end

  test "Setting initial state", %{spawner: spawner} do
    {:ok, list} = Ultronex.Spawner.list_scripts
    assert not Enum.empty?(list)

    state = Ultronex.Spawner.state?(spawner)
    struct_type = hd(Enum.map(Map.keys(state), fn(worker) -> state[worker].__struct__ end))
    assert struct_type === Ultronex.WorkerState

  end
  
end
