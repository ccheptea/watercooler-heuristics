defmodule Yappy do
  @moduledoc """
  Documentation for `Yappy`.
  """

  def data() do
    %{
      state: [1, 2, 3, 4],
      amity: %{
        {1, 2} => 1,
        {1, 3} => 3,
        {1, 4} => 2,
        {2, 3} => 3,
        {2, 4} => 4,
        {3, 4} => 7
      }
    }
  end

  defp candidate_score() do

  end

  def find() do
    %{state: state, amity: edges} = data()

    HillClimb.start(state, edges)
  end

end
