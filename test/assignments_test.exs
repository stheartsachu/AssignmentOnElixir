defmodule AssignmentsTest do
  use ExUnit.Case
  doctest Assignments

  test "Assinment 1 : Wneather Number is super_digit or not" do
    assert Assignments.super_digit(148, 3) == 3
  end

  test "Assignment 2 : create mingle string" do
    assert Assignments.mingle_main("abcd", "1234") == "a1b2c3d4"
  end

  test "Assignment 3 : swap the positions" do
    assert Assignments.swap_the_positions("abcdpqrs") == "badcqpsr"
  end

  test "Assignment 4 : check the brackets and return true or false" do
    assert Assignments.check_input_bracket("[{()}]") == true
  end
end
