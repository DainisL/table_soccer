defmodule TableSoccer.Db.Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres
  # mix ecto.migrate TableSoccer.Db.Repo

  def conf do
    db_config = %{ lc_collate: System.get_env["LANG"],
                   lc_ctype: System.get_env["LANG"]
                 }

    parse_url url(Mix.env), db_config
  end


  def priv do
    app_dir(:table_soccer, "priv/repo")
  end

  defp url(:dev),  do: "ecto://iex_dev:iex_dev@localhost/table_soccer_dev"
  defp url(:test), do: "ecto://iex_dev:iex_dev@localhost/table_soccer_test"
end