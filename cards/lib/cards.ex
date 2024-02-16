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
end
