defmodule Pangram do
  @doc """
  Determines if a word or sentence is a pangram.
  A pangram is a sentence using every letter of the alphabet at least once.

  Returns a boolean.

    ## Examples

      iex> Pangram.pangram?("the quick brown fox jumps over the lazy dog")
      true

  """
  @letters ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
"o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  @spec pangram?(String.t) :: boolean
  def pangram?(sentence) do
    result = sentence
      |> String.downcase
      |> String.split("")
      |> Enum.uniq
      |> Enum.sort
    Enum.map(@letters, fn l -> l in result end)
      |> Enum.all?
  end
end
