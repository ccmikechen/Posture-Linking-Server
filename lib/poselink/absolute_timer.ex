defmodule Poselink.AbsoluteTimer do

  def start_link(gap, module, func) do
    init(gap, module, func)
  end

  defp init(gap, module, func) do
    spawn_link(__MODULE__, :loop, [gap, module, func])
  end

  def stop(pid) do
    send pid, :stop
    :ok
  end

  def set_gap(pid, gap) do
    send pid, {:set_gap, gap}
    :ok
  end

  def loop(gap, module, func) do
    last_time = get_last_time(gap)

    receive do
      :stop -> :ok
      {:set_gap, new_gap} -> loop(new_gap, module, func)
    after
      last_time ->
        apply(module, func, [DateTime.utc_now()])
        loop(gap, module, func)
    end
  end

  defp get_last_time(gap) do
    current_ms = DateTime.utc_now |> DateTime.to_unix(:millisecond)
    gap - rem(current_ms, gap)
  end
end
