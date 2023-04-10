defmodule AdventOfCodeTest do
  use ExUnit.Case
  doctest AdventOfCode

  test "Day 1 - part 1" do
    assert AdventOfCode.DayOne.part_1_solution() == 71124
  end

  test "Day 1 - part 2" do
    assert AdventOfCode.DayOne.part_2_solution() == 204639
  end

  test "Day 2 - part 1" do
    assert AdventOfCode.DayTwo.part_1_solution() == 10994
  end

  test "Day 2 - part 2" do
    assert AdventOfCode.DayTwo.part_2_solution() == 12526
  end
end
