defmodule Yappy do
  @moduledoc """
  Documentation for `Yappy`.
  """

  def find() do
    default_group_size = 2

    %{state: initial_state, amity: edges} = InputReader.load_data_from_file("data/example1.txt")

    fitness_func = fn state ->
      Candidate.score(state, default_group_size, edges)
    end

    optimized = HillClimbing.start(initial_state, fitness_func)
    IO.puts("Initial")
    IO.inspect(initial_state, label: "\tState")
    IO.inspect(Candidate.group_scores(initial_state, default_group_size, edges), label: "\tValues")
    IO.puts("\tScore: #{Candidate.score(initial_state, default_group_size, edges)}")

    IO.puts("Optimized")
    IO.inspect(optimized, label: "\tState")
    IO.inspect(Candidate.group_scores(optimized, default_group_size, edges), label: "\tValues")
    IO.puts("\tScore: #{Candidate.score(optimized, default_group_size, edges)}")
  end

end
