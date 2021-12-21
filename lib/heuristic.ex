defmodule Heuristic do

  @typedoc """
  The number of groups the list of
  members should be split into
  """
  @type group_size :: integer

  @typedoc """
  An array representing the compositions
  of all groups.
  """
  @type state :: [integer]

  @typedoc """
  The relationship between vertices, where
  each vertex is a member and each edge value
  represents how close the two are in terms of
  friendship.
  """
  @type edges :: %{
    optional({integer, integer}) => integer
  }

  # @typedoc """
  # A fitness function determining the score of
  # a given state.
  # """
  @type fitness_func :: (state(), edges(), group_size() -> float())

  @callback start(state, fitness_func) :: state
end
