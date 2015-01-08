defmodule TableSoccerTest do
  use ExUnit.Case

  test "set waiting game" do
    assert TableSoccer.Table.current_state ==  :waiting
  end

  test "if_ready_to_play" do
    def_options = %{status: :waiting, player_l: nil, player_r: nil}
    {:ok, options, _} = TableSoccer.Player.to_place_player("12345", def_options)
    {:ok, last_opt, _} = TableSoccer.Player.to_place_player("98765", options)

    status = TableSoccer.Table.if_ready_to_play(last_opt) |> Map.get(:status)
    assert status == :ready
  end
end
