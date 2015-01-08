defmodule Models.Player do
  use Ecto.Model
  import Ecto.Query
  import Models.CrudActions
  alias TableSoccer.Db.Repo, as: Repo

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

  def find_by_rfid(rfid) do
    item = from(p in __MODULE__, where: p.rfid == ^rfid) |>
    Repo.all |> List.last
    case item do
      item  when is_map item  ->
        {:ok, item}
      _ ->
        {:failed, "not found"}
    end
  end

  def is_rfid_active(id) do
    case find_by_id(id) do
      item  when is_map item  ->
        {:ok, valid_rfid(item.rfid)}
      _ ->
        {:failed, "not found"}
    end
  end

  def valid_rfid(rfid) do
    String.length(rfid) > 7
  end
end