defmodule Table  do
  use GenServer

  # defstruct status: :waiting, player_l: nil, player_r: nil

  def start_link(status) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, status, name: __MODULE__)
  end

  def current_state do
    GenServer.call __MODULE__, :status
  end

  def add_player(id) do
    GenServer.call __MODULE__, {:add_player, id}
  end

  def handle_call(:status, _from, status) do
    {:reply, status, ""}
  end

  def handle_call({:add_player, id}, _from, status) do
    {:reply, %{done: :left}, status }
  end
end