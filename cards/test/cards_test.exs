defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "Check create deck returns 20 cards" do
    assert length(Cards.create_deck()) == 20
  end

  test "Shuffling a deck randomize it" do
    deck = Cards.create_deck()
    refute deck == Cards.shuffle(deck)
  end
end
