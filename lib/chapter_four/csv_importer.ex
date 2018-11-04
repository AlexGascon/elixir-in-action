defmodule ChapterFour.TodoList.CsvImporter do
  alias ChapterFour.TodoList.TodoList

  def import(file_path) do
    file_path
    |> read_lines
    |> Stream.map(&parse_entry(&1))
    |> Enum.to_list
    |> TodoList.new
  end

  defp read_lines(file_path) do
    File.read!(file_path)
    |> String.split("\n")
  end

  def parse_entry(row) do
    [date, title] = String.split(row, ",")

    %{date: parse_date(date), title: title}
  end

  def parse_date(date) do
    date
    |> String.split("/")
    |> Enum.map(&String.to_integer(&1))
    |> List.to_tuple
    |> Date.from_erl!
  end
end