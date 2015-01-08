defmodule TableSoccer.Table  do
  alias TableSoccer.Player
  alias TableSoccer.Game

  use GenServer

  def start_link() do
    options = %{status: :waiting, player_l: nil, player_r: nil, game_pid: nil}
    {:ok, _pid} = GenServer.start_link(__MODULE__, options, name: __MODULE__)
  end

  def current_state do
    GenServer.call __MODULE__, :status
  end

  def add_player(id) do
    GenServer.call __MODULE__, {:add_player, id}
  end

  def add_point(side) do
    case current_state do
      :ready ->
        GenServer.call __MODULE__, {:add_point, side}
      :waiting ->
        {:error, "game not started"}
    end
  end

  def handle_call(:status, _from, options) do
    {:reply, options.status, options}
  end

  def handle_call({:add_point, side}, _from, options) do
    case GenServer.call(options.game_pid, {:point, side}) do
      {:ok, opt} ->
        {:reply, {:ok, side, opt }, opt }
      {:win, win_side, options} ->
        {:reply, {:win, win_side, options}, options }
    end
  end

  def handle_call({:add_player, id}, _from, options) do
    case Player.add_player(id, options, options.status) do
      {:ok, new_options, side} ->
        opt = if_ready_to_play(new_options)
        {:reply, {:ok, opt.status, opt, side}, opt }
      {:noting, _} ->
        {:reply, {:error, options.status, options}, options }
    end
  end

  def if_ready_to_play(options) do
    if is_integer(options.player_r) && is_integer(options.player_r) do
      {:ok, pid} = start_game(options)
      %{options | status: :ready} |>
      Map.put(:game_pid, pid)
    else
      options
    end
  end

  defp start_game(options) do
    ids = %{id_r: options.player_l, id_l: options.player_l}
    {:ok, pid} = Game.start_link(ids)
    {:ok, pid}
  end
end