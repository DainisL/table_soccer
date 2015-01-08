defmodule Models.CrudActions do
  alias TableSoccer.Db.Repo, as: Repo

  def find_by_id(id, module) do
    case Repo.get(module, id) do
      item ->
        {:ok, item}
      _->
        {:failed, "not found"}
    end
  end

  def create(attrs, module) when is_map(attrs) do
    item = Map.merge(module.__struct__, attrs)
    case module.validate(item) do
      nil ->
        {:ok, Repo.insert(item)}
      errors ->
        "Errors #{ inspect errors}"
    end
  end

  def update(id, attrs, module) when is_map(attrs) do
    case find_by_id(id, module) do
      {:ok, item} when is_map(item) ->
        item = Map.merge(item, attrs)
        case module.validate(item) do
          nil ->
            new = Repo.update(item)
            {:ok, new}
          errors ->
            {:error, errors}
        end
      _ ->
        {:failed, "need to be Map %{}"}
    end
  end

  def update(_, _, _module), do: "attrs need to be map %{}"
  def create(_, _module), do: "attrs need to be map %{}"
end