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
    File.stream!(file_path)
    |> Stream.map(&remove_newline_character(&1))
  end

  defp remove_newline_character(string) do
    string
    |> String.replace("\n", "")
  end

  defp parse_entry(row) do
    [date, title] = String.split(row, ",")

    %{date: parse_date(date), title: title}
  end

  defp parse_date(date) do
    date
    |> String.split("/")
    |> Enum.map(&String.to_integer(&1))
    |> List.to_tuple
    |> Date.from_erl!
  end
end