defmodule HillClimbing do

  @max_iterations 100

  def start(initial_state, group_size, edges) do
    Enum.to_list 0..@max_iterations
    |> Enum.reduce(initial_state, fn _, best -> next_best(best, group_size, edges) end)
  end

  defp next_best(candidate, group_size, edges) do
    next_candidate = Candidate.neighbour(candidate)

    # IO.inspect(next_candidate, label: FoundNeighbour)

    current_score = Candidate.score(candidate, group_size, edges)
    next_score = Candidate.score(next_candidate, group_size, edges)

    # IO.inspect(next_score, label: NextScore)

    if next_score > current_score do
      next_candidate
    else
      candidate
    end
  end
end
