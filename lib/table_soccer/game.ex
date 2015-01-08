defmodule TableSoccer.Game do
  use GenServer

  def start_link(player_ids) do
    options = %{score_l: 0, score_r: 0, game_id: create_game(player_ids) }
    {:ok, _pid} = GenServer.start_link(__MODULE__, options, name: __MODULE__)
  end

  def add_point(side) do
    GenServer.call __MODULE__, {:point, side}
  end

  def handle_call({:point, side}, _from, options) do
    new_opt = Map.put(options, side, options[side] + 1)
    case update_game(new_opt, side) do
      {:ok, _} ->
        {:reply, {:ok, new_opt}, new_opt}
      {:win, win_side, opt} ->
        {:reply, {:win, win_side, opt}, opt}
      {_, message} ->
        {:reply, {:failed, message, new_opt}, new_opt}
    end
  end

  def handle_call(:points, _from, options) do
    case get_points_from_db(options) do
      {:ok, new_opt} ->
        {:reply, {:ok, new_opt}, new_opt}
      {:error, message} ->
        {:reply, {:error, message}, options}
    end
  end

  defp create_game(ids) do
     {:ok, item} = Models.Game.create(%{player_l_id: ids.id_l, player_r_id: ids.id_r})
     item.id
  end

  defp get_points_from_db(options) do
    case Models.Game.find_by_id(options.game_id) do
      {:ok, item} ->
        {:ok, %{score_l: item.score_l, score_r: item.score_r, game_id: item.id } }
      _->
        {:error, "can't find game"}
    end

  end

  defp update_game(options, side) do
    case add_point_to_db(options, side) do
      {:ok, _} ->
        checks_possible_winner(options)
      {_, message} ->
        {:error, message}
    end
  end

  defp checks_possible_winner(options) do
    case options do
      %{score_l: 10, score_r: _, game_id: _} ->
        {:win, :score_l, options}
      %{score_l: _, score_r: 10, game_id: _} ->
        {:win, :score_r, options}
      _->
        {:ok, options}
    end
  end


  defp add_point_to_db(options, side) do
    attrs = case side do
      :score_l ->
        %{score_l: Map.get(options, side)}
      :score_r ->
        %{score_r: Map.get(options, side)}
    end
    Models.Game.update(options.game_id, attrs)
  end
end