defmodule Models.Game do
  use Ecto.Model

  schema "games" do
    belongs_to :player_l, Models.Player, foreign_key: :player_l_id
    belongs_to :player_r, Models.Player, foreign_key: :player_r_id
    field :score_l, :integer, default: 0
    field :score_r, :integer, default: 0
    field :created_at, :datetime, default: Ecto.DateTime.local
    field :updated_at, :datetime, default: Ecto.DateTime.local
  end
end