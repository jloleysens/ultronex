defmodule Ultronex.WorkerState do
  defstruct last_run: nil,
            last_run_success: nil,
            domain: nil,
            pid: nil
end
