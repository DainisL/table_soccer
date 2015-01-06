defmodule TableSoccer.Counter do
  use GenServer

  def start_link do
    options = %{player_l: 0, player_r: 0, game_id: create_game }
    {:ok, _pid} = GenServer.start_link(__MODULE__, options, name: __MODULE__)
  end

  def add_point(side) do
    GenServer.call __MODULE__, {:point, side}
  end

  def handle_call({:point, side}, _from, options) do
    new_opt = Map.put(options, side, options[side] + 1)
    {:reply, {:ok, new_opt}, new_opt}
  end

  def handle_call(:points, _from, options) do
    {:reply, {:ok, options}, options}
  end

  defp create_game do
    ""
  end
end