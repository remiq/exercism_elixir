defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    {_, result} = string
    # process each letter
    |> String.split("", trim: true)
    # reduce while interpreting single-letter strings as int
    |> Enum.reduce({:force_next, ""}, fn <<char_int>>, {state, acc} ->
      cond do
        # space forces next [a-zA-Z] to be in acronym
        char_int == 32 -> {:force_next, acc}
        # if forced, add and unforce
        state == :force_next and char_int in ?a..?z -> {:normal, acc <> <<char_int>>}
        # append all upcased
        char_int in ?A..?Z -> {:normal, acc <> <<char_int>>}
        # otherwise ignore
        :otherwise -> {state, acc}
      end
    end)
    String.upcase(result)
  end
end
