defmodule Table  do
  use GenServer

  def start_link() do
    options = %{status: :waiting, player_l: nil, player_r: nil}
    {:ok, _pid} = GenServer.start_link(__MODULE__, options, name: __MODULE__)
  end

  def current_state do
    GenServer.call __MODULE__, :status
  end

  def add_player(id) do
    GenServer.call __MODULE__, {:add_player, id}
  end

  def add_player(id, options, :ready) do
    {:noting, options}
  end


  def handle_call(:status, _from, options) do
    {:reply, options.status, options}
  end

  def handle_call({:add_player, id}, _from, options) do
    case add_player(id, options, options.status) do
      {:ok, new_options, side} ->
        {:reply, {new_options.status, new_options, side}, new_options }
      {:noting, _} ->
        {:reply, {options.status, options}, options }
    end
  end

  def add_player(id, options, :waiting) do
    case select_side(options) do
      {:ok, side} ->
        {:ok, pid} = Player.start_link(id, side)
        new_options = Map.put(options, side, pid) |> if_ready_to_play
        {:ok, new_options, side}
      {:error} ->
        {:error, options}
    end
  end

  def if_ready_to_play(options) do
    if is_pid(options.player_r) && is_pid(options.player_r) do
      %{options | status: :ready}
    else
      options
    end
  end

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
end