defmodule Advent2021.Day1 do
  def part1 do
    total_increase_count = sonar_measurements_list() |> funhere(nil, 0)

    IO.puts total_increase_count
  end

  def part2 do
    total_increase_count =
      sonar_measurements_list()
      |> three_measurement_sliding()
      |> Enum.map(fn window_arr -> Enum.reduce(window_arr, fn (num, acc) -> num + acc end) end)
      |> funhere(nil, 0)

    IO.puts total_increase_count
  end

  defp three_measurement_sliding(u) do
    convert_list_of_three(u, Enum.count(u) >= 3, [])
  end

  defp convert_list_of_three([n1, n2, n3 | t], true, list_of_three) do
    without_head = [n2, n3 | t] 
    get_list_of_three(without_head, Enum.count(without_head) >= 3, [[n1, n2, n3] | list_of_three])
  end

  defp convert_list_of_three(list, false, list_of_three) do
    final_list = [list | list_of_three] |> Enum.reverse()
  end

  defp funhere([h | t], nil, count) do
    funhere(t, h, count)
  end

  defp funhere([h | t], previous_measurement, count) do
    increase_number = increase_by(h > previous_measurement)
    funhere(t, h, count + increase_number)
  end

  defp funhere([], _previous_measurement, count) do
    count
  end

  defp increase_by(true), do: 1
  defp increase_by(false), do: 0

  defp sonar_measurements_list do
    "../assets/day1.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
    |> Enum.map(fn num_string -> String.to_integer(num_string) end)
  end
end

Advent2021.Day1.part1()
Advent2021.Day1.part2()
