defmodule TableSoccer.Player do
  def select_side(options) do
    case options do
      %{status: :waiting, player_l: nil, player_r: _} ->
        {:ok, :player_l}
      %{status: :waiting, player_l: _, player_r: nil} ->
        {:ok, :player_r}
      _ ->
        {:error}
    end
  end

  def add_player(id, options, :waiting) do
    case Models.Player.find_by_rfid(id) do
      {:ok, item} ->
        to_place_player(item.id, options)
      {:failed, message} ->
        {:failed, message }
    end
  end

  def to_place_player(id, options) do
    case validate_uniq(id, options) do
      {:ok, _} ->
        case select_side(options) do
          {:ok, side} ->
            new_options = Map.put(options, side, id)
            {:ok, new_options, side}
          {:error} ->
            {:error, options}
        end
      {:already_exists, _} ->
        {:already_exists, options}
    end
  end


  def add_player(_id, options, _) do
    {:noting, options}
  end

  def validate_uniq(id, options) do
    if Map.values(options) |> Enum.any?(&(&1 == id)) do
      {:already_exists, options}
    else
      {:ok, options}
    end
  end
end