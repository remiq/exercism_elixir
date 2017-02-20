defmodule BracketPush do

  @bracket_open ~w/{ ( [/
  @bracket_close ~w/} ) ]/
  @invalid [:invalid]

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets(str) do
    str
    |> String.graphemes
    |> Enum.reduce([], &match/2)
    |> Enum.empty?
  end

  @type ret :: [String.t] | [:invalid]
  @spec match(String.t, ret) :: ret
  defp match(char, acc)
  # "braking" the loop
  defp match(_, @invalid), do: @invalid
  # adding new bracket
  defp match(open, acc) when open in @bracket_open, do: [open | acc]
  # closing last bracket
  defp match("}", ["{" | rest]), do: rest
  defp match(")", ["(" | rest]), do: rest
  defp match("]", ["[" | rest]), do: rest
  # closing invalid bracket
  defp match(close, [open | _rest]) when
    close in @bracket_close and open in @bracket_open, do: @invalid
    # special case - closing bracket as first char
  defp match(close, []) when close in @bracket_close, do: @invalid
  # ignoring the rest
  defp match(_, acc), do: acc

end
