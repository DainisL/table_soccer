defmodule Integration.AddPointsTest do
  use ExUnit.Case
  setup do
    Application.stop(:table_soccer)
    Application.start(:table_soccer)
  end

  test "add points with table" do
    Table.add_player("12345")
    Table.add_player("98765")
  end
end