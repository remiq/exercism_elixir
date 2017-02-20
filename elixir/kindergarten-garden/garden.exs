defmodule Garden do

  @default_names ~w/alice bob charlie david eve fred ginny harriet
                    ileana joseph kincaid larry/a

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @spec info(String.t(), list) :: map
  def info(info_string, student_names \\ @default_names) do
    student_names = Enum.sort(student_names)
    [top, bot] = String.split(info_string, "\n")
    generate(top, bot, student_names, %{})
  end

  defp generate("", "", [], acc), do: acc
  defp generate("", "", [name | names], acc), do:
    generate("", "", names, Map.put_new(acc, name, {}))
  defp generate(<<a, b, top :: binary>>, <<c, d, bot :: binary>>, [name | names], acc) do
    new_acc = Map.put_new(acc, name, {plant(a), plant(b), plant(c), plant(d)})
    generate(top, bot, names, new_acc)
  end


  defp plant(?V), do: :violets
  defp plant(?C), do: :clover
  defp plant(?R), do: :radishes
  defp plant(?G), do: :grass
end
