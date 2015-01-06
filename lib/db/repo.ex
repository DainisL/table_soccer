defmodule TableSoccer.Db.Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres
  # mix ecto.migrate TableSoccer.Db.Repo

  def conf do
    parse_url "ecto://iex_dev:iex_dev@localhost/table_soccer"
  end

  def priv do
    app_dir(:table_soccer, "priv/repo")
  end
end