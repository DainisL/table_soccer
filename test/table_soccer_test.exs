defmodule TableSoccerTest do
  use ExUnit.Case

  test "set waiting game" do
    assert Table.current_state ==  :waiting
  end

  test "add palyers" do
    def_options = %{status: :waiting, player_l: nil, player_r: nil}

    {:ok, options, side_l} = Table.add_player("12345", def_options, def_options.status)
    assert (Map.get(options, side_l) |> Process.alive?)

    {:ok, new_options, side_r} = Table.add_player("98765", options, options.status)
    assert (Map.get(new_options, side_r) |> Process.alive?)

    assert is_pid(new_options.player_l)
    assert is_pid(new_options.player_r)
  end

  test "if_ready_to_play" do
    def_options = %{status: :waiting, player_l: nil, player_r: nil}
    {:ok, options, _} = Table.add_player("12345", def_options, def_options.status)
    {:ok, last_opt, _} = Table.add_player("98765", options, options.status)

    status = Table.if_ready_to_play(last_opt) |> Map.get(:status)
    assert status = :ready
  end

  test "select_side" do
    options_1 = %{status: :waiting, player_l: nil, player_r: nil}
    assert {:ok, :player_l} == Table.select_side(options_1)
    options_2 = %{status: :waiting, player_l: :process, player_r: nil}
    assert {:ok, :player_r} == Table.select_side(options_2)

    options_3 = %{status: :waiting, player_l: :process, player_r: :process}
    assert {:error} == Table.select_side(options_3)
  end
end