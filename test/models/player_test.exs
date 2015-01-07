defmodule Moduls.PlayerTest do
  use ExUnit.Case

  setup do
    value = TableSoccer.Db.Repo.delete_all(Models.Player)
    {:ok, val: value}
  end

  test "create player" do
    attrs = %{first_name: "first_name", last_name: "last_name",email: "email@email.lv"}
    assert {:ok, item} = Models.Player.create(attrs)
  end
end