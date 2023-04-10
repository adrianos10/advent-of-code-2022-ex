defmodule AdventOfCode.DayTwo do
  @win :win
  @draw :draw
  @loss :loss

  @result_points %{
    @loss => 0,
    @draw => 3,
    @win => 6
  }

  @shape_points_1 %{
    A: 1,
    B: 2,
    C: 3,
    X: 1,
    Y: 2,
    Z: 3
  }

  @game_possibilities_1 %{
    ["A", "X"] => {@draw, @draw},
    ["A", "Y"] => {@loss, @win},
    ["A", "Z"] => {@win, @loss},
    ["B", "X"] => {@win, @loss},
    ["B", "Y"] => {@draw, @draw},
    ["B", "Z"] => {@loss, @win},
    ["C", "X"] => {@loss, @win},
    ["C", "Y"] => {@win, @loss},
    ["C", "Z"] => {@draw, @draw}
  }

  @game_possibilities_2 %{
    ["A", "A"] => {@draw, @draw},
    ["A", "B"] => {@loss, @win},
    ["A", "C"] => {@win, @loss},
    ["B", "A"] => {@win, @loss},
    ["B", "B"] => {@draw, @draw},
    ["B", "C"] => {@loss, @win},
    ["C", "A"] => {@loss, @win},
    ["C", "B"] => {@win, @loss},
    ["C", "C"] => {@draw, @draw}
  }

  @indicator_to_result %{
    X: @loss,
    Y: @draw,
    Z: @win
  }

  @desired_result_choice %{
    A: %{@win => :B, @loss => :C},
    B: %{@win => :C, @loss => :A},
    C: %{@win => :A, @loss => :B}
  }

  defp get_input, do: Utils.read_input("lib/day_2/input.txt") |> String.split("\n")

  defp calculate_game_result(rounds_list, game_possibilities) do
    rounds_list
    |> Enum.reduce(%{player_1_score: 0, player_2_score: 0}, fn round, result ->
      round_choices = round |> String.split(" ")
      [player_1_choice, player_2_choice] = round_choices

      {player_1_round_result, player_2_round_result} = game_possibilities[round_choices]

      player_1_round_score =
        @result_points[player_1_round_result] +
          @shape_points_1[player_1_choice |> String.to_atom()]

      player_2_round_score =
        @result_points[player_2_round_result] +
          @shape_points_1[player_2_choice |> String.to_atom()]

      %{
        player_1_score: result[:player_1_score] + player_1_round_score,
        player_2_score: result[:player_2_score] + player_2_round_score
      }
    end)
  end

  def part_1_solution do
    result = get_input()
    |> calculate_game_result(@game_possibilities_1)

    result[:player_2_score]
  end

  defp get_player_2_choice(player_1_choice, desired_result) do
    @desired_result_choice[player_1_choice |> String.to_atom()][desired_result]
  end

  defp get_round_choice([player_1_choice, player_2_result_indicator]) do
    required_result = @indicator_to_result[player_2_result_indicator |> String.to_atom()]

    case required_result do
      @draw -> "#{player_1_choice} #{player_1_choice}"
      _ -> "#{player_1_choice} #{get_player_2_choice(player_1_choice, required_result)}"
    end
  end

  def part_2_solution do
    result = get_input()
    |> Enum.map(fn round ->
      get_round_choice(round |> String.split(" "))
    end)
    |> calculate_game_result(@game_possibilities_2)

    result[:player_2_score]
  end
end
