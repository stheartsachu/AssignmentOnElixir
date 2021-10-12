defmodule AssignmentsTest do
  use ExUnit.Case
  doctest Assignments

  test "greets the world" do
    assert Assignments.hello() == :world
  end
end
