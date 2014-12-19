defmodule Player do
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

  def validate_uniq(id, options) do
    if Map.values(options) |> Enum.any?(&(&1 == id)) do
      {:already_exists, options}
    else
      {:ok, options}
    end
  end
end