defmodule CounterTest do
  use ExUnit.Case

  test "add point to left side" do
    {:ok, pid} = Counter.start_link
    {:ok, options} =  GenServer.call(pid, {:point, :player_l})
    assert %{player_l: 1, player_r: 0, game_id: ""} == options
  end

  test "add many points" do
    {:ok, pid} = Counter.start_link
    GenServer.call(pid, {:point, :player_l})
    GenServer.call(pid, {:point, :player_l})
    GenServer.call(pid, {:point, :player_l})
    GenServer.call(pid, {:point, :player_r})

    {:ok, options} =  GenServer.call(pid, :points)
    assert options == %{player_l: 3, player_r: 1, game_id: ""}
  end
end