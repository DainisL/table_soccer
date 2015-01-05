defmodule CounterTest do
  use ExUnit.Case

  test "add point to left side" do
    game_id = "223"
    {:ok, pid} = Counter.start_link(game_id)
    {:ok, options} =  GenServer.call(pid, {:point, :player_l})
    assert options == %{player_l: 1, player_r: 0, game_id: game_id}
  end

  test "add many points" do
    game_id = "223"
    {:ok, pid} = Counter.start_link(game_id)
    GenServer.call(pid, {:point, :player_l})
    GenServer.call(pid, {:point, :player_l})
    GenServer.call(pid, {:point, :player_l})
    GenServer.call(pid, {:point, :player_r})

    {:ok, options} =  GenServer.call(pid, :points)
    assert options == %{player_l: 3, player_r: 1, game_id: game_id}
  end
end