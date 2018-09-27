defmodule Mix.Tasks.Play do
  use Mix.Task

  def run(_) do
    IO.puts "Starting poker game.."
    Poker.play()
  end
end
