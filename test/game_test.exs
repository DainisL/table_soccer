defmodule GameTest do
  use ExUnit.Case
  setup do
    TableSoccer.Db.Repo.delete_all(Models.Game)
    Application.stop(:table_soccer)
    Application.start(:table_soccer)
    :ok
  end

  test "add point to left side" do
    player_ids = %{id_l: 20, id_r: 21}
    {:ok, pid} = TableSoccer.Game.start_link(player_ids)
    {:ok, options} =  GenServer.call(pid, {:point, :score_l})

    assert options.score_l == 1
    assert options.score_r == 0
    assert options.game_id |> is_integer
  end

  test "add many points" do
    player_ids = %{id_l: 20, id_r: 21}
    {:ok, pid} = TableSoccer.Game.start_link(player_ids)
    GenServer.call(pid, {:point, :score_l})
    GenServer.call(pid, {:point, :score_l})
    GenServer.call(pid, {:point, :score_l})
    GenServer.call(pid, {:point, :score_r})

    {:ok, options} =  GenServer.call(pid, :points)
    assert options.score_l == 3
    assert options.score_r == 1
    assert options.game_id |> is_integer
  end

  test "finished game when one of player win" do
    player_ids = %{id_l: 20, id_r: 21}
    {:ok, pid} = TableSoccer.Game.start_link(player_ids)
    Enum.map(1..5, fn _ -> GenServer.call(pid, {:point, :score_r}) end)
    Enum.map(1..9, fn _ -> GenServer.call(pid, {:point, :score_l}) end)
    assert {:win, :score_l, opt} = GenServer.call(pid, {:point, :score_l})
  end

end