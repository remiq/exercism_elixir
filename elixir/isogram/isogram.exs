defmodule Isogram do
  @can_repeat [" ", "-"]
  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    letters = sentence
      |> String.graphemes
      |> Enum.reject(fn l -> l in @can_repeat end)
    length(letters) == length(Enum.uniq(letters))
  end

end
