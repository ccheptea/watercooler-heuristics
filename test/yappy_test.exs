defmodule YappyTest do
  use ExUnit.Case
  doctest Yappy

  test "greets the world" do
    assert Yappy.hello() == :world
  end
end
