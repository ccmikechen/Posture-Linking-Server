alias Export.Python

defmodule ListHelper do
  def duplst(item, n) do
    do_duplst(item, n, [])
  end

  defp do_duplst(item, n, acc) when n > 0 do
    do_duplst(item, n - 1, [item | acc])
  end
  defp do_duplst(item, _, acc) do
    acc
  end
end

data =
  1.0
  |> ListHelper.duplst(17)
  |> ListHelper.duplst(16)
  |> ListHelper.duplst(10)

type = ListHelper.duplst(1, 10)

{:ok, pid} = Python.start_link(python_path: "python/", python: "python2")
Python.call(pid, "poselink", "build_posture_model", [data, type, {17, 16}, 4, "./test/models/"])
