defmodule Advent2021.Day2 do
  def part1 do
    [horizontal, depth] = command_list() |> get_position([0, 0])

    IO.puts horizontal * depth
  end

  def part2 do
    [horizontal, depth, _aim] = command_list() |> get_position_with_aim([0, 0, 0])

    IO.puts horizontal * depth
  end

  defp get_position_with_aim([h | t], position) do
    updated_position = String.split(h, " ") |> update_movement_with_aim(position)
    get_position_with_aim(t, updated_position)
  end

  defp get_position_with_aim([], position) do
    position
  end

  defp get_position([h | t], position) do
    updated_position = String.split(h, " ") |> update_movement(position)
    get_position(t, updated_position)
  end

  defp get_position([], position) do
    position
  end

  defp update_movement([command, units], [horizontal, depth]) do
    unit_integer = String.to_integer(units)
    case command do
      "forward" -> [horizontal + unit_integer, depth]
      "down" -> [horizontal, depth + unit_integer]
      "up" -> [horizontal, depth - unit_integer]
    end
  end

  defp update_movement_with_aim([command, units], [horizontal, depth, aim]) do
    unit_integer = String.to_integer(units)
    case command do
      "forward" -> [horizontal + unit_integer, depth + (aim * unit_integer), aim]
      "down" -> [horizontal, depth, aim + unit_integer]
      "up" -> [horizontal, depth, aim - unit_integer]
    end
  end

  defp command_list do
    "../assets/day2.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end

Advent2021.Day2.part2()
