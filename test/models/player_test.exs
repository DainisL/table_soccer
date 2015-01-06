defmodule Moduls.PlayerTest do
  use ExUnit.Case

  setup do
    TableSoccer.Db.Repo.delete_all(Models.Player)
  end

  test "create player" do
    attrs = %{first_name: "first_name", last_name: "last_name",email: "email@email.lv"}
    assert {:ok, dict} = Models.Player.create(attrs)
  end
end