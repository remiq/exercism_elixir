defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(_s, size) when size < 1, do: []
  def slices(s, size) when length(s) < size, do: []
  def slices(s, size) do
    s
    |> String.graphemes
    |> rest(size)
    |> Enum.filter(&(&1))
  end

  defp rest([], _size), do: []
  defp rest([_ | rest] = arr, size), do:
    [first(arr, size) | rest(rest, size)]

  defp first(arr, size) when length(arr) < size, do: nil
  defp first(arr, size), do:
    arr
    |> Enum.take(size)
    |> Enum.join



end
