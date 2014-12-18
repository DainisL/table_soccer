defmodule TableSoccerTest do
  require TableOptions
  use ExUnit.Case, async: true

  test "set waiting game" do
    assert TableOptions.options(Table.current_state, :status) ==  :waiting
  end

  test "add players" do
    response = Table.add_player("ertt42")
    assert true ==  TableOptions.options(response, :player_l) |> Process.alive?
    # assert Table.add_player("e22t42") ==  %{done: :right}
  end

  # test "change status when added players" do
  #   assert Table.add_player({id: "ertt42"}) ==  {done: :left}
  #   assert Table.add_player({id: "e22t42"}) ==  {done: :right}
  #   assert Table.current_state ==  :ready
  # end
end
