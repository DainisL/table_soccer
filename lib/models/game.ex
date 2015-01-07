defmodule Models.Game do
  use Ecto.Model
  import Models.CrudActions

  validate game, player_l_id: present(), player_r_id: present()

  schema "games" do
    belongs_to :player_l, Models.Player, foreign_key: :player_l_id
    belongs_to :player_r, Models.Player, foreign_key: :player_r_id
    field :score_l, :integer, default: 0
    field :score_r, :integer, default: 0
    field :created_at, :datetime, default: Ecto.DateTime.local
    field :updated_at, :datetime, default: Ecto.DateTime.local
  end

  def find_by_id(id), do: find_by_id(id, __MODULE__)

  def create(attrs), do: create(attrs, __MODULE__ )

  def update(id, attrs), do: update(id, attrs, __MODULE__ )
end