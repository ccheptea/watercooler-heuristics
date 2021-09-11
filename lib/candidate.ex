defmodule Candidate do

  def score(candidate, group_size, amity) do
    candidate
      # |> IO.inspect(label: Groups)
      |> group_scores(group_size, amity)
      |> calculate_score()
  end

  def group_scores(state, group_size, amity) do
    state
      |> Enum.chunk_every(group_size)
      |> Enum.map(fn group -> get_group_score(group, amity) end)
  end

  def get_group_score(group, amity) do
    get_group_edges(group)
      |> Enum.map(fn {a, b} -> amity[{a, b}] || amity[{b, a}] end)
      |> Enum.filter(fn value -> value != nil end)
      # |> IO.inspect(label: "Valid Edges: ")
      |> calculate_score()
  end

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

  def neighbour(state) do
    count = Enum.count(state)

    first_index = :rand.uniform(count) - 1
    second_index = :rand.uniform(count) - 1

    ListHelper.swap(state, first_index, second_index)
  end

end
