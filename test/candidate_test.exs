defmodule CandidateTest do
  use ExUnit.Case
  doctest Candidate

  # ----------------------

  # ----------------------

  test "get group edges" do
    edges = Candidate.get_group_edges([1, 2, 3])

    assert edges == [{1, 2}, {1, 3}, {2, 3}]
  end

  test "get group edges for empty group" do
    edges = Candidate.get_group_edges([])

    assert edges == []
  end

  test "get group edges for single element group" do
    edges = Candidate.get_group_edges([1])

    assert edges == []
  end

   # ----------------------
end
