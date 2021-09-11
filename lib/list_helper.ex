defmodule ListHelper do
  def swap(list, index1, index2) do
    element1 = Enum.at(list, index1)
    element2 = Enum.at(list, index2)

    list
    |> List.replace_at(index1, element2)
    |> List.replace_at(index2, element1)
  end
end
