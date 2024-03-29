defmodule Card do
  @moduledoc"""
    The Card module is used to create a deck of 52 cards.
    The deck is used to create a set of cards called 'hand'.
    A card is removed from the deck when it is assigned to a hand.
    Cards are assigned randomly.

    Functions to use: 
    -  'Card.generate_deck()/1'
    -  'Card.generate_hand(deck)/1'

  """
  @type card :: {integer, String.t}
  @type hand :: [card]
  @type deck :: [card]

  @dos"""
    Generate a deck of 52 unique cards.
  """

  @spec generate_deck() :: deck
  def generate_deck(), do: for values <- Enum.to_list(2..14), suits <- [:diamonds, :stars, :spades, :hearts], do: {values, suits}

  @spec generate_hand(deck) :: hand
  def generate_hand(deck), do: generate_hand(deck, _hand = [ ],  _hand_size = 5)

  def generate_hand(deck, hand, cards_left) when cards_left > 0 do
    random_number = get_random_number(length(deck))
    {card, deck} = List.pop_at(deck, random_number)
    generate_hand(deck, [card | hand], cards_left-1) 
  end

  def generate_hand(deck, hand, _cards_left),  do: [ hand | deck ]


  defp get_random_number(cards_left_in_deck) do
    << i1 :: unsigned-integer-32, i2 :: unsigned-integer-32, i3 :: unsigned-integer-32>> = :crypto.strong_rand_bytes(12)
    :rand.seed(:exsplus, {i1, i2, i3})
    :rand.uniform(cards_left_in_deck-1)
  end

end

