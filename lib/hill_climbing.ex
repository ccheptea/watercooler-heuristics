defmodule HillClimbing do

  @default_iterations 100

  def start(initial_state, group_size, edges, iterations \\ @default_iterations) do
    0..iterations
    |> Enum.to_list()
    |> Enum.reduce(initial_state, fn _, best -> next_best(best, group_size, edges) end)
  end

  defp next_best(candidate, group_size, edges) do
    next_candidate = Candidate.neighbour(candidate)
    current_score = Candidate.score(candidate, group_size, edges)
    next_score = Candidate.score(next_candidate, group_size, edges)

    if next_score > current_score do
      next_candidate
    else
      candidate
    end
  end
end
