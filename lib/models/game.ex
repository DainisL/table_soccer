defmodule Models.Game do
  alias TableSoccer.Db.Repo, as: Repo

  use Ecto.Model
  validate game, player_l_id: present(), player_r_id: present()

  schema "games" do
    belongs_to :player_l, Models.Player, foreign_key: :player_l_id
    belongs_to :player_r, Models.Player, foreign_key: :player_r_id
    field :score_l, :integer, default: 0
    field :score_r, :integer, default: 0
    field :created_at, :datetime, default: Ecto.DateTime.local
    field :updated_at, :datetime, default: Ecto.DateTime.local
  end

   def create(attrs) when is_map(attrs) do
    item = Map.merge(%__MODULE__{}, attrs)
    case __MODULE__.validate(item) do
      nil ->
        Repo.insert(item)
      errors ->
        "Errors #{ inspect errors}"
    end
  end

  def create(attrs) do
    "attrs need to be map %{}"
  end
end