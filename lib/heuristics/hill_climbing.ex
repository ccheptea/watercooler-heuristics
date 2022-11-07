defmodule Heuristics.HillClimbing do
  @behaviour Heuristic

  @type state :: Heuristic.state
  @type fitness_func :: Heuristic.fitness_func

  @opts %{
    iterations: 100
  }

  @spec start(state, fitness_func, any()) :: state
  def start(initial_state, fitness_func, opts \\ @opts), do:
    0..opts[:iterations]
      |> Enum.to_list()
      |> Enum.reduce(initial_state, fn _, best -> next_best(best, fitness_func) end)

  defp next_best(candidate, fitness_func) do
    next_candidate  = neighbour(candidate)
    current_score   = fitness_func.(candidate)
    next_score      = fitness_func.(next_candidate)

    if next_score > current_score,
      do: next_candidate,
      else: candidate
  end

  def neighbour(state) do
    count = Enum.count(state)

    first_index = :rand.uniform(count) - 1
    second_index = :rand.uniform(count) - 1

    ListHelper.swap(state, first_index, second_index)
  end

end
