defmodule ChapterThree.LoopsAndIterations.Streams do
  """
  @moduledoc
  Using large_lines!/1 as a model, write the following functions:

      - lines_lengths!/1 that takes a file path and returns a list of numbers, with each number
      representing the length of the corresponding line from the file.
      - longest_line_length!/1 that returns the length of the longest line in a file.
      - longest_line!/1 that returns the contents of the longest line in a file.
      - words_per_line!/1 that returns a list of numbers, with each number representing the word
      count in a file. Hint: to get the word count of a line, use length(String.split(line)).

  Solutions are provided in the enum_streams_practice.ex file, but it’s strongly suggested that you
  spend some time trying to crack these problems yourself.
  """
  # Example:
  def large_lines!(path) do
    File.stream!(path)
    |> Stream.map(&String.replace(&1, "\n", ""))
    |> Enum.filter(&(String.length(&1) > 80))
  end

  # Common helpers
  defp read_file!(file_path) do
    File.stream!(file_path)
    |> Stream.map(&remove_newline_character/1)
  end

  defp remove_newline_character(text) do
    String.replace(text, "\n", "")
  end

  # Exercise 1
  def lines_lengths!(file_path) do
    File.stream!(file_path)
    |> Stream.map(&remove_newline_character/1)
    |> Enum.map(&String.length/1)
  end

  # Exercise 2
  def longest_line_length!(file_path) do
    read_file!(file_path)
    |> Stream.map(&String.length/1)
    |> Enum.max
  end

  # Exercise 3
  def longest_line!(file_path) do
    read_file!(file_path)
    |> Enum.max_by(&String.length/1)
  end

  # Exercise 4
  def words_per_line!(file_path) do
    read_file!(file_path)
    |> Stream.map(&String.split/1)
    |> Enum.map(&Enum.count/1)
  end
end