defmodule TableOptions do
  require Record
  Record.defrecord :options, [status: :waiting, player_l: nil, player_r: nil]
end