defmodule Constantin do
  def can_construct(ransom_note, magazine) do
    freq = ransom_note
      |> String.codepoints()
      |> Enum.frequencies()

    magazine
    |> String.codepoints()
    |> Enum.reduce(freq, fn x, acc ->
      if acc[x] != nil and acc[x] > 0 do
        Map.put(acc, x, acc[x] - 1)
      else
        acc
      end
    end)
    |> Enum.all?(fn {_, count} -> count == 0 end)
  end
end
