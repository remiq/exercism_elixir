defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """
  @spec flatten(list) :: list
  def flatten(list) do
    list
    |> Enum.reduce([], fn
      nil, acc -> acc
      i, acc when is_integer(i) -> acc ++ [i]
      new_list, acc when is_list(new_list) -> acc ++ flatten(new_list)
    end)
  end

end
