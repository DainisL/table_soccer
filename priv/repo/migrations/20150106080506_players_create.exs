defmodule TableSoccer.Db.Repo.Migrations.PlayersCreate do
  use Ecto.Migration

  def up do
    "CREATE TABLE players( \
      id serial primary key, \
      first_name varchar(255), \
      last_name varchar(255), \
      rfid varchar(255), \
      email varchar(255), \
      created_at timestamp, \
      updated_at timestamp)"
  end

  def down do
    "DROP TABLE players"
  end
end
