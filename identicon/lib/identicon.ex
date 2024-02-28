defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello()
      :world

  """
  def hello do
    :world
  end

  def main(input) do
    input |> hash_it()
  end

  def hash_it(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list()
  end
end
