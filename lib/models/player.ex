defmodule Models.Player do
  use Ecto.Model
  validate game, first_name: present(), last_name: present(), email: present()

  schema "players" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :rfid, :string
    field :created_at, :datetime, default: Ecto.DateTime.local
    field :updated_at, :datetime, default: Ecto.DateTime.local
  end

  def create(attrs) when is_map(attrs) do
    item = Map.merge(%__MODULE__{}, attrs)
    case __MODULE__.validate(item) do
      nil ->
        Repo.insert(item)
      errors ->
        "Errors #{ inspect errors }"
    end
  end

  def find_by_id(id) do
    Repo.get(__MODULE__, id)
  end

  def update(id, attrs) when is_map(attrs) do
    case find_by_id(id) do
      item when is_map(item) ->
        item = Map.merge(item, attrs)
        case __MODULE__.validate(item) do
          [] ->
            Repo.update(item)
            item
          _ ->
            nil
        end
      _ ->
        nil
    end
  end

  def update(_, _), do: "attrs need to be map %{}"
  def create(_), do: "attrs need to be map %{}"
end