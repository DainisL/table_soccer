defmodule Table  do
  use GenServer

  def start_link() do
    options = %{status: :waiting, player_l: nil, player_r: nil, counter_pid: nil}
    {:ok, _pid} = GenServer.start_link(__MODULE__, options, name: __MODULE__)
  end

  def current_state do
    GenServer.call __MODULE__, :status
  end

  def add_player(id) do
    GenServer.call __MODULE__, {:add_player, id}
  end

  def add_point(side, options, :ready) do
    {:noting, options}
  end

  def add_point(side, options, :ready) do
    GenServer.call(options.counter_pid, {:point, side})
    {:noting, options}
  end


  def handle_call(:status, _from, options) do
    {:reply, options.status, options}
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
    if is_bitstring(options.player_r) && is_bitstring(options.player_r) do
      {:ok, pid} = start_game
      %{options | status: :ready} |>
      Map.put(:counter_pid, pid)
    else
      options
    end
  end

  defp start_game do
    {:ok, pid} = Counter.start_link
  end
end