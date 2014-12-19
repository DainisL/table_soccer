defmodule PlayerTest do
  use ExUnit.Case
  test "add palyers" do
    def_options = %{status: :waiting, player_l: nil, player_r: nil}

    {:ok, options, side_l} = Player.add_player("12345", def_options, def_options.status)
    assert (Map.get(options, side_l) |> is_bitstring)

    {:ok, new_options, side_r} = Player.add_player("98765", options, options.status)
    assert (Map.get(new_options, side_r) |> is_bitstring)
  end

  test "validate uniq player" do
    assert {:ok, _} = Player.validate_uniq("12345", %{status: :waiting, player_l: nil, player_r: nil})
    assert {:already_exists, _} = Player.validate_uniq("12345", %{status: :waiting, player_l: "12345", player_r: nil})
  end

  test "select_side" do
    options_1 = %{status: :waiting, player_l: nil, player_r: nil}
    assert {:ok, :player_l} == Player.select_side(options_1)
    options_2 = %{status: :waiting, player_l: "someid", player_r: nil}
    assert {:ok, :player_r} == Player.select_side(options_2)

    options_3 = %{status: :waiting, player_l: "someid", player_r: "someid"}
    assert {:error} == Player.select_side(options_3)
  end
end