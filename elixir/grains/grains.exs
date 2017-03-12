defmodule Grains do
  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(1), do: {:ok, 1}
  # optimize for speed
  Enum.reduce(2..64, 1, fn n, last ->
    next = last * 2
    def square(unquote(n)), do: {:ok, unquote(next)}
    next
  end)
  def square(_), do: { :error, "The requested square must be between 1 and 64 (inclusive)" }

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total do
    sum = Enum.reduce(1..64, 0, fn n, acc ->
      {:ok, square} = square(n)
      square + acc
    end)
    {:ok, sum}
  end

end
