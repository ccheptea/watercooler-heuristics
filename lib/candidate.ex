defmodule Candidate do

  def score(candidate, group_size, edges), do:
    candidate
      # |> IO.inspect(label: Groups)
      |> group_scores(group_size, edges)
      |> calculate_score()

  def group_scores(state, group_size, edges), do:
    state
      |> Enum.chunk_every(group_size)
      |> Enum.map(fn group -> get_group_score(group, edges) end)

  def get_group_score(group, edges), do:
    get_group_edges(group)
      |> Enum.map(fn {a, b} -> edges[{a, b}] || edges[{b, a}] end)
      |> Enum.filter(fn value -> value != nil end)
      # |> IO.inspect(label: "Valid Edges: ")
      |> calculate_score()

  def calculate_score(values) do
    mean = Statistics.mean(values)
    stdev = Statistics.stdev(values)
    penalty = stdev / (mean + 1)
    score = mean - penalty
    score
  end

  def get_group_edges([]), do: []
  def get_group_edges([_ | []]), do: []
  def get_group_edges(group) do
    for i <- 0..(Enum.count(group) - 2),
        j <- (i + 1)..Enum.count(group) - 1 do
          { Enum.at(group, i), Enum.at(group, j) }
    end
  end

end
