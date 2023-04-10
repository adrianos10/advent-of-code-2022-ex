defmodule AdventOfCode.DayOne do
  defp get_summed_entries do
    Utils.read_input("lib/day_1/input.txt")
    |> String.split("\n")
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.reject(&(&1 == [""]))
    |> Enum.map(fn x ->
      x |> Enum.map(&String.to_integer(&1)) |> Enum.sum()
    end)
  end

  def part_1_solution do
    get_summed_entries()
    |> Enum.max()
  end

  def part_2_solution do
    get_summed_entries() |> Enum.sort(&(&1 >= &2)) |> Enum.slice(0..2) |> Enum.sum()
  end
end
