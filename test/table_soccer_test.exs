defmodule TableSoccerTest do
  use ExUnit.Case
  setup do
    Application.stop(:table_soccer)
    Application.start(:table_soccer)
  end

  test "add palyers" do
    Table.add_player("ertt42")
    {status, options, side} = Table.add_player("ertt42")
    assert(options.player_l |> Process.alive?)
    assert(options.player_r |> Process.alive?)
    assert Table.current_state ==  :ready
  end
end


defmodule DefaultState do
  use ExUnit.Case

  setup do
    Application.stop(:table_soccer)
    Application.start(:table_soccer)
  end

  test "set waiting game" do
    assert Table.current_state ==  :waiting
  end

  test "add player_l" do
    { state, options, side } = Table.add_player("ertt42")
    assert true == Map.get(options, side) |> Process.alive?
  end
end