defmodule Moduls.PlayerTest do
  use ExUnit.Case

  setup do
    value = TableSoccer.Db.Repo.delete_all(Models.Player)
    {:ok, val: value}
  end

  test "create player" do
    attrs = %{first_name: "first_name", last_name: "last_name",email: "email@email.lv"}
    assert {:ok, item} = Models.Player.create(attrs)
    assert item.id |> is_integer
  end

  test "update player " do
    attrs = %{first_name: "first_name", last_name: "last_name",email: "email@email.lv"}
    update_attrs = %{first_name: "new_name", last_name: "last_name", email: "email@email.com"}
    {:ok, item} = Models.Player.create(attrs)
    assert {:ok, update_item} = Models.Player.update(item.id, update_attrs)
    assert update_item.email == update_attrs.email
    assert update_item.first_name == update_attrs.first_name
  end

  test "is_rfid_active" do
    attrs = %{first_name: "first_name", last_name: "last_name",email: "email@email.lv", rfid: "232432hhdh"}
    {:ok, item} = Models.Player.create(attrs)
    assert {:ok, true, item} = Models.Player.is_rfid_active(item.id)
    assert {:failed, _} = Models.Player.is_rfid_active("-1")
  end

  test "find_by_rfid" do
    attrs = %{first_name: "first_name", last_name: "last_name",email: "email@email.lv", rfid: "77777777"}
    {:ok, item} = Models.Player.create(attrs)
    assert {:ok, item} = Models.Player.find_by_rfid(attrs.rfid)
    assert {:failed, _} = Models.Player.find_by_rfid("not_found")
  end
end