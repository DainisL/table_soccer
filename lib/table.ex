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
    pid = spawn_link
  end


  def handle_call(:status, _from, options) do
    {:reply, options, ""}
  end

  def handle_call({:add_player, id}, _from, options) do
    player = add_player(id, options)
    {:reply, player, options }
    # %{done: :left}
  end
end