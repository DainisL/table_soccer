defmodule Player do
  def start_link(id, side) do
    options = %{side: side, id: id}
    pid = spawn_link(fn -> loop(options) end)
    {:ok, pid}
  end

  defp loop(options) do
    receive do
      {:get, key, caller} ->
        send caller, options
        loop(options)
      {:put, key, value} ->
        loop(options)
      _ ->
        loop(options)
    end
  end
end