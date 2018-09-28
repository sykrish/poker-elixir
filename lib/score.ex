defmodule Score do
  @moduledoc"""
    The Score module looks at both hands and determins the winner.

    Functions to use:
    -   'Score.who_is_winner?(hand1, hand2)/1'
  """


  @doc"""
    Return value from who_is_winner? are {winner = {winning_hand, winning_value*}, {score, score_related_cards}}.
    * = When hands have equal score, the winner is based on the highest pair / card.

    ## Input
          - hand1 and hand2: both sorted and comprises of five cards.

    ## Ouput
          - Tuple containing: {{winner, won_with}, {score, cards}} 
          - winner: hand1 or hand2
          - winning_value: the actual cards or score that made the hand win
          - score: a tuple containing the score and the related cards: {:pair, {6,6}}
  """

  @type card :: {integer, String.t}
  @type score :: {atom, {integer}}
  @type winner :: {{atom, String.t}, score}


  @spec who_is_winner?([card],[card]) :: winner
  def who_is_winner?(hand1, hand2) do
    score_hand1 = get_score(hand1)
    score_hand2 = get_score(hand2)

    winner = get_winner(score_hand1, score_hand2, hand1, hand2)
    who_is_winner?({winner, score_hand1, score_hand2})
  end

  def who_is_winner?({winner = {:hand1, _winning_value}, score, _}), do: {winner, score}
  def who_is_winner?({winner = {:hand2, _winning_value}, _, score}), do: {winner, score}
  def who_is_winner?({winner = {:tie, _winning_value}, score, _}), do: {winner, score}


  defp is_consecutive?(card1, _card2, _card3, _card4, card5 ) do 
    hand_size = 5
    if (card5 - card1 + 1 == hand_size), do: :true
  end


  @spec get_score([card]) :: score
  defp get_score([{value_a, suit}, {value_b, suit}, {value_c, suit}, {value_d, suit}, {value_e, suit}]) do
    if is_consecutive?(value_a, value_b, value_c ,value_d, value_e) do
      {:straight_flush, {value_a, value_b, value_c, value_d, value_e}}
    else
      {:flush, {value_a, value_b, value_c, value_d, value_e}}
    end
  end

  #Flush
  defp get_score([{_,  suit}, {_, suit}, {_, suit}, {_, suit}, {_, suit}]), do: {:flush, suit}

  #Full house
  defp get_score([{value_a, _}, {value_a, _}, {value_a, _}, {value_b, _}, {value_b, _}]), do: {:full_house, {{value_a, value_a, value_a}, {value_b, value_b}}}
  defp get_score([{value_a, _}, {value_a, _}, {value_b, _}, {value_b, _}, {value_b, _}]), do: {:full_house, {{value_b, value_b, value_b}, {value_a, value_a}}}

  #Four of a kind
  defp get_score([{value, _}, {value , _}, {value, _}, {value, _}, {_, _}]), do: {:four_of_a_kind, {value, value, value, value}}
  defp get_score([{_, _}, {value , _}, {value, _}, {value, _}, {value, _}]), do: {:four_of_a_kind, {value, value, value, value}}

  #Three pair
  defp get_score([{value, _}, {value , _}, {value, _}, {_, _}, {_, _}]), do: {:three_of_a_kind, {value, value, value}}
  defp get_score([{_, _}, {value , _}, {value, _}, {value, _}, {_, _}]), do: {:three_of_a_kind, {value, value, value}}
  defp get_score([{_, _}, {_ , _}, {value, _}, {value, _}, {value, _}]), do: {:three_of_a_kind, {value, value, value}}

  #Two pair
  defp get_score([{ value_a, _}, {value_a, _}, {value_b, _}, {value_b, _}, {_, _}]), do: {:two_pair, {{value_a, value_a}, {value_b, value_b}}}
  defp get_score([{value_a, _}, {value_a, _}, { _, _}, {value_b, _}, {value_b, _}]), do: {:two_pair, {{value_a, value_a}, {value_b, value_b}}}
  defp get_score([{_, _}, {value_a , _}, {value_a, _}, {value_b, _}, {value_b, _}]), do: {:two_pair, {{value_a, value_a}, {value_b, value_b}}}

  #Pair
  defp get_score([{value, _}, {value, _}, { _, _}, { _, _}, { _, _}]), do: {:pair, {value, value}}
  defp get_score([{ _, _}, {value, _}, {value, _}, { _, _}, { _, _}]), do: {:pair, {value, value}}
  defp get_score([{ _, _}, { _, _}, {value, _}, {value, _}, { _, _}]), do: {:pair, {value, value}}
  defp get_score([{ _, _}, { _, _}, { _, _}, {value, _}, {value, _}]), do: {:pair, {value, value}}

  #Highest card
  defp get_score([{_value_a, _}, {_value_b_, _}, {_value_c_, _}, {_value_d, _}, {value_e, _}]), do: {:highcard, value_e}
  defp get_score([]), do: {:error, "Could not get score, list is empty"}



  def get_winner(:highcard, :highcard, hand1, hand2), do: who_has_highest_card?(hand1, hand2)
  def get_winner(score, score, hand, hand), do: {:tie, "-"}

  def get_winner({score, {h1_pair1, _pair2}}, {score, {h2_pair1, _pair2}}, _hand1, _hand2) when h1_pair1 > h2_pair1, do: {:hand1, h1_pair1}
  def get_winner({score, {h1_pair1, _pair2}}, {score, {h2_pair1, _pair2}}, _hand1, _hand2) when h1_pair1 < h2_pair1, do: {:hand2, h2_pair1}

  def get_winner({:two_pair, {_h1_pair1, h1_pair2}}, {:two_pair, {_h2_pair1, h2_pair2}}, _hand1, _hand2) when h1_pair2 > h2_pair2, do: {:hand1, h1_pair2}
  def get_winner({:two_pair, {_h1_pair1, h1_pair2}}, {:two_pair, {_h2_pair1, h2_pair2}}, _hand1, _hand2) when h1_pair2 < h2_pair2, do: {:hand2, h2_pair2}


  def get_winner({score, cards1}, {score, cards2}, _hand1, _hand2) when cards1 > cards2, do: {:hand1, cards1}
  def get_winner({score, cards1}, {score, cards2}, _hand1, _hand2) when cards1 < cards2, do: {:hand2, cards2}

  def get_winner(score, score, hand1, hand2), do: who_has_highest_card?(hand1, hand2)

  def get_winner({score1, _cards1}, {score2, _cards2}, _hand1, _hand2), do: compare_score(score1, score2)


  defp compare_score(score1, score2) do
    if(atom_to_value(score1) > atom_to_value(score2)) do
        {:hand1, score1}
     else
        {:hand2, score2}
    end
  end
  

  # reverse hand since it is sorted from lowest to highest
  defp who_has_highest_card?(hand1, hand2) do
    hand1_reversed = Enum.reverse(hand1)
    hand2_reversed = Enum.reverse(hand2)
    find_highest_card_in_list(hand1_reversed, hand2_reversed)
  end


  defp find_highest_card_in_list([ {card, _} | [ ] ], [{card, _} | [ ] ]), do: {:tie, "-"}
  defp find_highest_card_in_list([ {card_hand1, _suit1} | rest_hand1], [ {card_hand2, _suit2} | rest_hand2] ) do
    cond do
      card_hand1 > card_hand2 -> {:hand1, card_hand1}
      card_hand1 < card_hand2 -> {:hand2, card_hand2}
      card_hand1 == card_hand2 -> find_highest_card_in_list(rest_hand1, rest_hand2)
    end
  end
  defp find_highest_card_in_list([ card_hand1 | [ ] ], [ card_hand2 | [ ] ]) when card_hand1 > card_hand2, do: {:hand1, card_hand1}
  defp find_highest_card_in_list([ card_hand1 | [ ] ], [ card_hand2 | [ ] ]) when card_hand1 < card_hand2, do: {:hand2, card_hand2}
  defp find_highest_card_in_list( _hand1= [ ], _hand2 = [ ] ), do: {:error, "Could not find highest card, lists are empty"}


  defp atom_to_value(:straight_flush),  do: 9
  defp atom_to_value(:four_of_a_kind),  do: 8
  defp atom_to_value(:full_house),      do: 7
  defp atom_to_value(:flush),           do: 6
  defp atom_to_value(:straight),        do: 5
  defp atom_to_value(:three_of_a_kind), do: 4
  defp atom_to_value(:two_pair),        do: 3
  defp atom_to_value(:pair),            do: 2
  defp atom_to_value(:highcard),        do: 1

end

