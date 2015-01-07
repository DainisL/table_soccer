defmodule Models.Player do
  use Ecto.Model
  import Models.CrudActions

  validate game, first_name: present(), last_name: present(), email: present()

  schema "players" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :rfid, :string
    field :created_at, :datetime, default: Ecto.DateTime.local
    field :updated_at, :datetime, default: Ecto.DateTime.local
  end

  def find_by_id(id), do: find_by_id(id, __MODULE__)

  def create(attrs), do: create(attrs, __MODULE__ )

  def update(id, attrs), do: update(id, attrs, __MODULE__ )
end