defmodule Table  do
  require TableOptions
  use GenServer

  def start_link() do
    options = TableOptions.options()
    {:ok, _pid} = GenServer.start_link(__MODULE__, options, name: __MODULE__)
  end

  def current_state do
    GenServer.call __MODULE__, :status
  end

  def add_player(id) do
    GenServer.call __MODULE__, {:add_player, id}
  end

  def add_player(id, options) do
    {:ok, pid} = Player.start_link(id, :left)
    TableOptions.options(options, player_l: pid)
  end


  def handle_call(:status, _from, options) do
    {:reply, options, ""}
  end

  def handle_call({:add_player, id}, _from, options) do
    new_options = add_player(id, options)
    {:reply, new_options, new_options }
    # %{done: :left}
  end
end