defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t) :: String.t
  def encode(string) do
    string
    |> String.split("")
    |> Enum.reduce({"", 0, []}, fn
      # "" means it's the end of the string
      "", {last, count, acc} -> "#{acc}#{print_short(last, count)}"

      " ", {last, count, acc} -> {"", 0, "#{acc}#{print_short(last, count)} "}
      letter, {"", _count, acc} -> {letter, 1, acc}
      # pattern-matching letter with state letter
      letter, {letter, count, acc} -> {letter, count + 1, acc}
      letter, {last, count, acc} -> {letter, 1, "#{acc}#{print_short(last, count)}"}
    end)
  end

  defp print_short(letter, 0), do: ""
  defp print_short(letter, 1), do: "#{letter}"
  defp print_short(letter, count), do: "#{count}#{letter}"

  @digits ~w/1 2 3 4 5 6 7 8 9/
  @spec decode(String.t) :: String.t
  def decode(string) do
    string
    |> String.split("")
    |> Enum.reduce({"", ""}, fn
      "", {_num_s, acc} -> acc
      digit, {num_s, acc} when digit in @digits ->
        {"#{num_s}#{digit}", acc}
      letter, {num_s, acc} ->
        {"", acc <> print_long(letter, num_s)}
    end)
  end

  def print_long(letter, ""), do: letter
  def print_long(letter, count_s) do
    count = String.to_integer(count_s)
    1..count
    |> Enum.map(fn _ -> letter end)
    |> Enum.join
  end

end
