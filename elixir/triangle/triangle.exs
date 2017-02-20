defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) do
    [a, b, c]
    |> Enum.sort
    |> kindp
  end

  defp kindp([a, b, c]) when a <= 0 or b <= 0 or c <= 0, do:
    { :error, "all side lengths must be positive" }
  defp kindp([a, b, c]) when a + b <= c, do:
    { :error, "side lengths violate triangle inequality" }
  defp kindp([a, a, a]), do: { :ok, :equilateral }
  defp kindp([a, a, _b]), do: { :ok, :isosceles }
  defp kindp([_a, b, b]), do: { :ok, :isosceles }
  defp kindp([_a, _b, _c]), do: { :ok, :scalene }
end
