defmodule TableSoccerTest do
  use ExUnit.Case, async: true

  test "set waiting game" do
    assert Table.current_state ==  {:options, :waiting, nil, nil}
  end

  test "add players" do
    assert Table.add_player("ertt42") ==  %{done: :left}
    # assert Table.add_player("e22t42") ==  %{done: :right}
  end

  # test "change status when added players" do
  #   assert Table.add_player({id: "ertt42"}) ==  {done: :left}
  #   assert Table.add_player({id: "e22t42"}) ==  {done: :right}
  #   assert Table.current_state ==  :ready
  # end
end
