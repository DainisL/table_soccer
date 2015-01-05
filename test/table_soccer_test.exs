defmodule TableSoccerTest do
  use ExUnit.Case

  test "set waiting game" do
    assert Table.current_state ==  :waiting
  end

  test "if_ready_to_play" do
    def_options = %{status: :waiting, player_l: nil, player_r: nil}
    {:ok, options, _} = Player.add_player("12345", def_options, def_options.status)
    {:ok, last_opt, _} = Player.add_player("98765", options, options.status)

    status = Table.if_ready_to_play(last_opt) |> Map.get(:status)
    assert status == :ready
  end
end
