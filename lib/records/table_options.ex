defmodule TableOptions do
  require Record
  Record.defrecord :options, [status: :waiting, player_l: "open", player_r: "open"]
end