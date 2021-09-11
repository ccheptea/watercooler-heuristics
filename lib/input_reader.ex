defmodule InputReader do

  def load_data_from_file(filename) do
    data = File.read!(filename)
    [count | edges] = String.split(data, "\n")
    count = String.to_integer(count)

    amity = edges
      |> Enum.filter(fn s -> s != "" end)
      |> Enum.map(&edge_to_map_entry/1)
      |> Map.new()

    %{
      state: Enum.to_list(1..count),
      amity: amity
    }
  end

  defp edge_to_map_entry(edge) do
    [a, b, weight] = edge
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)

    {{a, b}, weight}
  end
end
