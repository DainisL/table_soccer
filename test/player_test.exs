defmodule PlayerTest do
  use ExUnit.Case

  setup do
    value = TableSoccer.Db.Repo.delete_all(Models.Player)
    {:ok, val: value}
  end

  test "add palyers" do
    def_options = %{status: :waiting, player_l: nil, player_r: nil}

    attrs_1 = %{first_name: "first_name", last_name: "last_name",email: "email@email.lv", rfid: "232432hhdh"}
    attrs_2 = %{first_name: "first_name", last_name: "last_name",email: "email@email.lv", rfid: "33333333"}

    {:ok, item_1} = Models.Player.create(attrs_1)
    {:ok, item_2} = Models.Player.create(attrs_2)

    {:ok, options, side_l} = TableSoccer.Player.add_player(item_1.rfid, def_options, def_options.status)
    assert (Map.get(options, side_l) |> is_integer)

    {:ok, new_options, side_r} = TableSoccer.Player.add_player(item_2.rfid, options, options.status)
    assert (Map.get(new_options, side_r) |> is_integer)
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