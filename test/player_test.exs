defmodule PlayerTest do
  use ExUnit.Case
  test "add palyers" do
    def_options = %{status: :waiting, player_l: nil, player_r: nil}

    {:ok, options, side_l} = TableSoccer.Player.add_player("12345", def_options, def_options.status)
    assert (Map.get(options, side_l) |> is_bitstring)

    {:ok, new_options, side_r} = TableSoccer.Player.add_player("98765", options, options.status)
    assert (Map.get(new_options, side_r) |> is_bitstring)
  end

  test "validate uniq player" do
    assert {:ok, _} = TableSoccer.Player.validate_uniq("12345", %{status: :waiting, player_l: nil, player_r: nil})
    assert {:already_exists, _} = TableSoccer.Player.validate_uniq("12345", %{status: :waiting, player_l: "12345", player_r: nil})
  end

  test "select_side" do
    options_1 = %{status: :waiting, player_l: nil, player_r: nil}
    assert {:ok, :player_l} == TableSoccer.Player.select_side(options_1)
    options_2 = %{status: :waiting, player_l: "someid", player_r: nil}
    assert {:ok, :player_r} == TableSoccer.Player.select_side(options_2)

    options_3 = %{status: :waiting, player_l: "someid", player_r: "someid"}
    assert {:error} == TableSoccer.Player.select_side(options_3)
  end
end