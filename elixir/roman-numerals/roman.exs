defmodule Roman do
  @doc """
  Convert the number to a roman number.
  """
  @spec numerals(pos_integer) :: String.t
  def numerals(int) when is_integer(int), do: to_roman_macro(int, "")

  def to_roman_macro(int), do: to_roman_macro(int, "")
  def to_roman_macro(int, acc) when int <= 0, do: acc
  [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"},
  ] |> Enum.each(fn {value, char} ->
    def to_roman_macro(int, acc) when int >= unquote(value), do: to_roman_macro(int - unquote(value), acc <> unquote(char))
  end)

end
