defmodule Integration.AddPointsTest do
  use ExUnit.Case

  setup do
    TableSoccer.Db.Repo.delete_all(Models.Player)
    TableSoccer.Db.Repo.delete_all(Models.Game)
    Application.stop(:table_soccer)
    Application.start(:table_soccer)
    :ok
  end

  test "add points with table" do
    attrs_1 = %{first_name: "first_name", last_name: "last_name",email: "email@email.lv", rfid: "232432hhdh"}
    attrs_2 = %{first_name: "first_name", last_name: "last_name",email: "email@email.lv", rfid: "33333333"}
    {:ok, item_1} = Models.Player.create(attrs_1)
    {:ok, item_2} = Models.Player.create(attrs_2)

    TableSoccer.Table.add_player(item_1.id)
    TableSoccer.Table.add_player(item_2.id)

    assert :ready == TableSoccer.Table.current_state
  end
end