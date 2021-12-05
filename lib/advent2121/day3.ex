defmodule Advent2021.Day3 do
  def part1 do
    binary_list = get_binary_list()
    [h | t] = Enum.map(binary_list, fn n ->
      String.split(n, "", trim: true) |> Enum.map(&String.to_integer/1)
    end)
    list_half_size = Enum.count(binary_list) / 2
    gamma_arr = get_binary_acc(t, h) |> Enum.map(fn x -> get_binary_from_freq(x > list_half_size) end)
    epsilon_arr = gamma_arr |> Enum.map(&inverse_binary/1)
    {gamma, _} = gamma_arr |> Enum.join() |> Integer.parse(2)
    {epsilon, _} = epsilon_arr |> Enum.join() |> Integer.parse(2)

    IO.puts gamma * epsilon
  end

  def part2 do
    binary_list = get_binary_list()
    nested_list = Enum.map(binary_list, fn n ->
      String.split(n, "", trim: true) |> Enum.map(&String.to_integer/1)
    end)
    initial_index = 0
    {oxygen_rating, _} = something(nested_list, initial_index, "oxygen") |> Enum.at(0) |> Enum.join() |> Integer.parse(2)
    {co2_rating, _} = something(nested_list, initial_index, "co2") |> Enum.at(0) |> Enum.join() |> Integer.parse(2)
    IO.puts oxygen_rating * co2_rating
  end

  def something(nested_list, current_index, rating_type) do
    case Enum.count(nested_list) do
      1 -> nested_list
      x ->
        [h | t] = nested_list
        list_half_size = Enum.count(nested_list) / 2
        gamma_arr = get_binary_acc(t, h) |> Enum.map(fn x -> get_binary_for_type(x, list_half_size, rating_type) end)
        filter_num = Enum.at(gamma_arr, current_index)
        filtered_list = nested_list |> Enum.filter(fn x -> Enum.at(x, current_index) == filter_num end)
        something(filtered_list, current_index + 1, rating_type)
    end
  end

  def get_binary_from_freq(true), do: 1
  def get_binary_from_freq(false), do: 0
  def get_binary_for_type(num, size, "oxygen") do
    get_binary_from_freq(num >= size)
  end
  def get_binary_for_type(num, size, "co2") do
    get_binary_from_freq(num < size)
  end
  def inverse_binary(0), do: 1
  def inverse_binary(1), do: 0

  def get_binary_acc([], acc) do
    acc
  end

  def get_binary_acc([h | t], acc) do
    acc = h |> Enum.with_index() |> Enum.map(fn ({n, i}) -> Enum.at(acc, i) + n end)

    get_binary_acc(t, acc)
  end

  defp get_binary_list do
    "../assets/day3.txt"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split(~r/\n/)
  end
end

Advent2021.Day3.part1()
Advent2021.Day3.part2()
