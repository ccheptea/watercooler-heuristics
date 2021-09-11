defmodule Yappy do
  @moduledoc """
  Documentation for `Yappy`.
  """

  def find() do
    default_group_size = 2

    %{state: state, amity: edges} = InputReader.load_data_from_file("data/example1.txt")

    local_best = HillClimbing.start(state, default_group_size, edges)
    IO.puts("Initial")
    IO.inspect(state, label: "\tState")
    IO.inspect(Candidate.group_scores(state, default_group_size, edges), label: "\tValues")
    IO.puts("\tScore: #{Candidate.score(state, default_group_size, edges)}")

    IO.puts("Optimized")
    IO.inspect(local_best, label: "\tState")
    IO.inspect(Candidate.group_scores(local_best, default_group_size, edges), label: "\tValues")
    IO.puts("\tScore: #{Candidate.score(local_best, default_group_size, edges)}")
  end

end
