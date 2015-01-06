defmodule TableSoccer.Db.Repo.Migrations.GamesCreate do
  use Ecto.Migration

  def up do
    "CREATE TABLE games( \
      id serial primary key, \
      player_l_id integer, \
      player_r_id integer, \
      score_l integer, \
      score_r integer, \
      created_at timestamp, \
      updated_at timestamp)"
  end

  def down do
    "DROP TABLE games"
  end
end