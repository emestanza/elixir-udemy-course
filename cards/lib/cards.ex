defmodule Cards do
  @moduledoc """
  Documentation for `Cards` module.
  """

  @doc """
  Creates an initial deck of cards, combination of "values of suites"
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

  @doc """
  Check wether exists a specific card in the deck list

  ## Examples

      iex> deck = Cards.create_deck()
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Returns a tuple with the following result:
  {hand, rest_of_the_deck}

  hand will have cards according to the hand_size parameter

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) when is_bitstring(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "Something went wrong"
    end
  end

  def load(_) do
    :not_a_valid_string
  end

  def create_hand(hand_size) do
    create_deck()
    |> shuffle()
    |> deal(hand_size)
  end

  def hello() do
    :world
  end
end
