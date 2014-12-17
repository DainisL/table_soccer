  defmodule Player do
  use GenServer

  defstruct side: nil, id: nil, score: 0

  def start_link() do
    {:ok, _pid} = GenServer.start_link(__MODULE__, name: __MODULE__)
  end

  def handle_call(:add, _from, [h|t]) do
    {:reply, h, t}
  end

  def handle_call(:side, _from) do
    {:reply, :side}
  end
end