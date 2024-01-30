defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suites = ["Spades", "Clubs", "Heards", "Diamonds"]

    for value <- values, suite <- suites do
      "#{value} of #{suite}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    {hand, _rest} = Enum.split(deck, hand_size)

    hand
  end
end
