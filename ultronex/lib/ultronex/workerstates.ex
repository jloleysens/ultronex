defmodule Ultronex.WorkerState do
  defstruct last_run: nil,
            last_run_success: nil,
            times_run: 0,
            pid: nil
end
