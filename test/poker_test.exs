defmodule PokerTest do
  use ExUnit.Case, async: true

  describe "Poker" do
    @tag :results
    test "check game results" do
        c1 = {3, :clubs}
        c2 = {4, :hearts}
        c3 = {12, :hearts}
        c4 = {12, :clubs}
        c5 = {14, :clubs}
        hand1 = [c1, c2, c3, c4, c5]

        d1 = {2, :clubs}
        d2 = {4, :spades}
        d3 = {8, :clubs}
        d4 = {10,  :spades}
        d5 = {13,  :hearts}
        hand2 = [d1, d2, d3, d4, d5]

      assert Poker.get_map_of_game_results(hand1, hand2) == 
      %{
        :hand1 => hand1,
        :hand2 => hand2,
        :winner => :hand1,
        :won_with => :pair,
        :score => {:pair, {12,12}} 
      }
    end

    @tag :results
    test "check game results with tie" do
        c1 = {3, :clubs}
        c2 = {4, :hearts}
        c3 = {5, :hearts}
        c4 = {12, :clubs}
        c5 = {14, :clubs}
        hand1 = [c1, c2, c3, c4, c5]

        d1 = {3, :hears}
        d2 = {4, :spades}
        d3 = {5, :clubs}
        d4 = {12,  :spades}
        d5 = {14,  :hearts}
        hand2 = [d1, d2, d3, d4, d5]

      assert Poker.get_map_of_game_results(hand1, hand2) == 
      %{
        :hand1 => hand1,
        :hand2 => hand2,
        :winner => :tie,
        :won_with => "-",
        :score => {:highcard, 14} 
      }
    end
  end

  describe "Card" do
    test "create deck" do
      assert length(Card.generate_deck()) == 52
    end

    test "hands comprises of 5 cards" do
     deck = Card.generate_deck()
     [hand|deck] = Card.generate_hand(deck)
     assert length(hand) == 5
    end
  end


  describe "Sort" do
  @tag :insertion
    test "sorting cards from lowest to highest" do
      unorderd_list = [14, 4, 6, 2, 8]
      assert Sort.sort(unorderd_list) == [2, 4, 6, 8, 14]
    end

  @tag :bubble
    test "use bubble sort to sort list" do
    assert Sort.sort([5,1,8,4]) == [1,4,5,8]
    assert Sort.sort([1,2,3,4]) == [1,2,3,4]
    assert Sort.sort([5,2,2,4]) == [2,2,4,5]
  end

  @tag :selection
    test "use selection sort to sort list" do
    assert Sort.sort([5,1,8,4]) == [1,4,5,8]
    assert Sort.sort([1,2,3,4]) == [1,2,3,4]
    assert Sort.sort([5,2,2,4]) == [2,2,4,5]
    end

  end

  describe "Score" do
    @tag :flush
    test "Both flush, hand 1 wins" do
      c1 = {6, :heart}
      c2 = {8, :heart}
      c3 = {10,:heart}
      c4 = {13,:heart}
      c5 = {14,:heart}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {1, :diamonds}
      d2 = {3, :diamonds}
      d3 = {4, :diamonds}
      d4 = {6, :diamonds}
      d5 = {7, :diamonds}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand1, {6, 8, 10, 13, 14} }, {:flush, {6, 8, 10, 13, 14}}}
    end

    @tag :tie
    test "Both cards have the same value cards, results in tie" do
      c1 = {2, :spades}
      c2 = {5, :diamonds}
      c3 = {6, :clubs}
      c4 = {11, :heart}
      c5 = {14, :diamonds}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {2, :heart}
      d2 = {5, :heart}
      d3 = {6, :diamonds}
      d4 = {11, :clubs}
      d5 = {14, :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert  Score.who_is_winner?(hand1, hand2) == :tie
    end



    @tag :highest_card
    test "Highest card, hand 2 should win with 13" do
      c1 = {1, :heart}
      c2 = {2, :clubs}
      c3 = {4, :heart}
      c4 = {11, :heart}
      c5 = {12, :clubs}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {2, :heart}
      d2 = {6, :diamonds}
      d3 = {7, :heart}
      d4 = {11, :clubs}
      d5 = {13, :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand2, 13 }, {:highcard, 13}}
    end
    
    @tag :highest_card
    test "Hand 2 wins with 3rd card" do
      c1 = {2, :diamond}
      c2 = {3, :heart}
      c3 = {4, :club}
      c4 = {11, :heart}
      c5 = {12, :heart}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {2, :heart}
      d2 = {5, :club}
      d3 = {6, :diamond}
      d4 = {11, :heart}
      d5 = {12, :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand2, 6 }, {:highcard, 12}}
    end

    @tag :highest_card
    test "highcard hand1 should win with 14" do

      c1 = {2, :hearts}
      c2 = {4, :diamonds}
      c3 = {5, :spades}
      c4 = {13, :spades}
      c5 = {14, :diamonds}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {3, :clubs}
      d2 = {4, :clubs}
      d3 = {6, :spades}
      d4 = {8, :diamonds}
      d5 = {9, :clubs}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand1, 14 }, {:highcard, 14}}
    end

  @tag :highest_card
    test "function findHighcard" do
      c1 = {3, :heart}
      c2 = {4, :heart}
      c3 = {6, :heart}
      c4 = {11, :heart}
      c5 = {14, :diamonds}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {2, :heart}
      d2 = {5, :clubs}
      d3 = {6, :heart}
      d4 = {11, :heart}
      d5 = {14, :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand2, 5}, {:highcard, 14}}
  end



    @tag :three_of_a_kind
    test "Both three_of_a_kind, winner hand1." do
      c1 = {2, :heart}
      c2 = {3, :diamond}
      c3 = {9, :club}
      c4 = {9, :club}
      c5 = {9, :heart}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {2, :heart}
      d2 = {6, :diamond}
      d3 = {5, :heart}
      d4 = {5, :club}
      d5 = {5, :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == ({{:hand1, {9, 9, 9}}, {:three_of_a_kind, {9, 9, 9} }})
    end



    @tag :pair
    test "one pair vs highcard" do
      c1 = {3, :clubs}
      c2 = {4, :hearts}
      c3 = {12, :hearts}
      c4 = {12, :clubs}
      c5 = {14, :clubs}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {2, :clubs}
      d2 = {4, :spades}
      d3 = {8, :clubs}
      d4 = {10,  :spades}
      d5 = {13,  :hearts}
      hand2 = [d1, d2, d3, d4, d5]

      assert Score.who_is_winner?(hand1, hand2) == {{:hand1, :pair }, {:pair, {12, 12}}}
    end

    @tag :pair
    test "Both one pair, winner hand1 with highest pair cards 12." do
      c1 = {2, :heart}
      c2 = {3, :diamond}
      c3 = {4, :club}
      c4 = {12, :club}
      c5 = {12, :heart}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {2, :heart}
      d2 = {6, :diamond}
      d3 = {6, :heart}
      d4 = {11, :club}
      d5 = {12, :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand1, {12, 12}}, {:pair, {12, 12}}}
    end


    @tag :pair
    test "Both one pair, winner hand1 with highest pair cards 14." do
      c1 = {2, :heart}
      c2 = {3, :diamond}
      c3 = {12, :spades}
      c4 = {12, :club}
      c5 = {14, :heart}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {2, :heart}
      d2 = {6, :diamond}
      d3 = {8, :heart}
      d4 = {12, :club}
      d5 = {12, :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand1, 14}, {:pair, {12, 12}}}
    end

    @tag :pair
    test "Both two pair, winner hand1." do
      c1 = {2, :heart}
      c2 = {2, :diamond}
      c3 = {4, :club}
      c4 = {12, :club}
      c5 = {12, :heart}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {2, :heart}
      d2 = {8, :diamond}
      d3 = {8, :heart}
      d4 = {10, :club}
      d5 = {10, :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand1, {12, 12} }, {:two_pair, {{2, 2}, {12, 12}}}}
    end



    @tag :full_house
    test "full house vs straight flush" do
      c1 = {8, :heart}
      c2 = {8, :diamond}
      c3 = {2, :diamond}
      c4 = {2, :club}
      c5 = {2, :heart}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {2, :heart}
      d2 = {3, :heart}
      d3 = {4, :heart}
      d4 = {5, :heart}
      d5 = {6, :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand2, :straight_flush}, {:straight_flush, {2, 3, 4, 5, 6}}}
    end


    @tag :full_house 
    test "full house and flush." do
      c1 = {2, :heart}
      c2 = {2, :diamond}
      c3 = {2, :diamond}
      c4 = {8, :club}
      c5 = {8, :heart}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {2, :heart}
      d2 = {6, :heart}
      d3 = {6, :heart}
      d4 = {11, :heart}
      d5 = {13, :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand1, :full_house}, {:full_house, {{2,2,2}, {8,8}}}}
    end
    
    @tag :full_house
    test "Different scores" do
      c1 = {3, :heart}
      c2 = {3, :diamond}
      c3 = {7, :diamond}
      c4 = {8, :club}
      c5 = {9, :heart}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {6, :heart}
      d2 = {6, :club}
      d3 = {6, :diamond}
      d4 = {11, :heart}
      d5 = {11, :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand2, :full_house}, {:full_house, {{6, 6, 6}, {11, 11}}}}
    end


    @tag :two_pair
    test "two pair" do
      c1 = {3, :heart}
      c2 = {3, :diamond}
      c3 = {7, :diamond}
      c4 = {8, :club}
      c5 = {8, :diamond}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {2, :heart}
      d2 = {2, :club}
      d3 = {6, :diamond}
      d4 = {8, :spades}
      d5 = {8, :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand1, {3, 3}}, {:two_pair, {{3, 3}, {8, 8}}}}
    end


    @tag :four_of_a_kind
    test "Four of a kind correct" do
      c1 = {10,  :heart}
      c2 = {10,  :diamonds}
      c3 = {10,  :star}
      c4 = {10,  :spades}
      c5 = {14,  :heart}
      hand1 = [c1, c2, c3, c4, c5]

      d1 = {6,  :heart}
      d2 = {10,  :diamonds}
      d3 = {10,  :star}
      d4 = {10,  :spades}
      d5 = {10,  :heart}
      hand2 = [d1, d2, d3, d4, d5]
      assert Score.who_is_winner?(hand1, hand2) == {{:hand1, 14}, {:four_of_a_kind, {10, 10, 10, 10}}}
    end

  end
end

