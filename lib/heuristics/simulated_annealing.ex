defmodule Heuristics.SimulatedAnnealing do
  @behaviour Heuristic

  @type state :: Heuristic.state
  @type fitness_func :: Heuristic.fitness_func

  @opts %{
    iterations: 100
  }

  @cooling_rate 0.999
  @temp 1000
  @temp_min 0.001

  @spec start(state, fitness_func, any()) :: state
  def start(state, fitness_func, opts \\ @opts) do
    result = 0..opts[:iterations]
      |> Enum.to_list()
      |> Enum.reduce(%{temp: @temp, state: state, best_state: state}, fn _, data ->
        next_iteration(data, fitness_func)
      end)

    result.best_state
  end

  defp next_iteration(%{temp: temp, state: state, best_state: best_state}, fitness_func) do
    next_state        = neighbour(state)
    best_state_score  = fitness_func.(best_state)
    next_state_score  = fitness_func.(next_state)
    curr_state_score  = fitness_func.(state)

    delta_energy = curr_state_score - next_state_score

    probability = cond do
      delta_energy < 0 -> 1
      true -> :math.exp(-delta_energy/temp)
    end

    next_state =
      if probability > :rand.uniform() do
        next_state
      else
        state
      end

    next_best =
      if next_state_score > best_state_score do
        next_state
      else
        best_state
      end

    %{
      temp: temp * @cooling_rate,
      state: next_state,
      best_state: next_best
    }
  end

  def neighbour(state) do
    count = Enum.count(state)

    first_index = :rand.uniform(count) - 1
    second_index = :rand.uniform(count) - 1

    ListHelper.swap(state, first_index, second_index)
  end

end
