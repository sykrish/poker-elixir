defmodule Poker do
  @moduledoc"""
    Start a poker game with the command: mix play. 
    This poker game comprises a deck of cards and hands with each five cards.

    Functions to use:
    -   'Poker.play()/1'

  """


  def play() do
    deck = Card.generate_deck()

    [hand1|deck]  = Card.generate_hand(deck)
    [hand2|_deck] = Card.generate_hand(deck)

    hand1_sorted = Sort.sort(hand1)
    hand2_sorted = Sort.sort(hand2)

    Score.who_is_winner?(hand1_sorted, hand2_sorted)    |>
    get_map_of_game_results(hand1_sorted, hand2_sorted) |>
    show_results
  end

  @spec get_map_of_game_results(tuple(), list(), list()) :: map()
  def get_map_of_game_results(winner, hand1_sorted, hand2_sorted) do
    {{winner, winning_value}, score} = winner
    %{
      :hand1 => hand1_sorted,
      :hand2 => hand2_sorted,
      :winner => winner,
      :winning_value => winning_value,
      :score => score 
    }
  end

  @spec show_results(map())  :: none()
  def show_results(results) do
    IO.puts "\nResults:"
    IO.puts "------------------------------------"
    IO.inspect results[:hand1], label: "hand1 : \n"
    IO.puts "------------------------------------"
    IO.inspect results[:hand2], label: "hand2 : \n"
    IO.puts "------------------------------------"
    IO.inspect results[:winner], label: "winner is: \n"
    IO.inspect results[:score], label: "score: \n"
    IO.inspect results[:winning_value], label: "won with: \n"
  end
end

