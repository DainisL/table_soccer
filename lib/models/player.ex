defmodule Models.Player do
  use Ecto.Model

  schema "players" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :rfid, :string
    field :created_at, :datetime, default: Ecto.DateTime.local
    field :updated_at, :datetime, default: Ecto.DateTime.local
  end
end