defmodule Scrabble do
  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score(word) do
    word
    |> String.downcase
    |> String.split("")
    |> Enum.reduce(0, fn letter, acc -> points(letter) + acc end)
  end

  defp points(l) when l in ~w/a e i o u l n r s t/, do: 1
  defp points(l) when l in ~w/d g/, do: 2
  defp points(l) when l in ~w/b c m p/, do: 3
  defp points(l) when l in ~w/f h v w y/, do: 4
  defp points(l) when l in ~w/k/, do: 5
  defp points(l) when l in ~w/j x/, do: 8
  defp points(l) when l in ~w/q z/, do: 10
  defp points(_), do: 0
end
