defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t
  def convert(number) do
    {:notmatched, number, ""}
      |> match(3, "Pling")
      |> match(5, "Plang")
      |> match(7, "Plong")
      |> print
  end

  def match({_, number, acc}, divisor, sound) when rem(number, divisor) == 0, do:
    {:matched, number, acc <> sound}
  def match({state, number, acc}, _divisor, _sound), do:
    {state, number, acc}

  def print({:notmatched, number, _}), do: "#{number}"
  def print({:matched, _, result}), do: result
end
