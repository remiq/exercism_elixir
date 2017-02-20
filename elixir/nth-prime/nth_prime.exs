defmodule Prime do

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0, do: nth(count, [2])

  def nth(count, [h | _rest] = acc) when length(acc) == count, do: h
  def nth(count, [h | _rest] = acc) when length(acc) < count do
    nth(count, [next(h + 1, acc) | acc])
  end

  @doc """
  Returns `i` if it's prime or first prime after `i`.
  """
  @spec next(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def next(i, primes) when i > 0 do
    prime? = Enum.all?(primes, fn j -> rem(i, j) != 0 end)
    case prime? do
      true -> i
      false -> next(i + 1, primes)
    end
  end

end
