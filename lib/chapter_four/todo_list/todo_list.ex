defmodule ChapterFour.TodoList.TodoList do
  alias ChapterFour.TodoList.TodoList

  defstruct auto_id: 1, entries: %{}

  def new(), do: %TodoList{}

  def new(entries) do
    Enum.reduce(
      entries,
      TodoList.new,
      fn entry, accumulator -> add_entry(accumulator, entry) end
    )
  end

  def add_entry(todo_list, entry) do
    # Result = Map.put(map_to_update, key, value)
    entry = Map.put(entry, :id, todo_list.auto_id)
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)

    # This updates a map (like the TodoList struct) affecting only existing
    # keys. This lets us be sure that todo_list is a TodoList
    %TodoList{todo_list |
      entries: new_entries,
      auto_id: todo_list.auto_id + 1
    }
  end

  def entries(todo_list, date) do
    todo_list.entries
    |> Stream.filter(fn {_, entry} -> entry.date == date end)
    |> Enum.map(fn {_, entry} -> entry end)
  end

  def update_entry(todo_list, %{} = new_entry) do
    update_entry(todo_list, new_entry.id, fn _ -> new_entry end)
  end

  def update_entry(todo_list, entry_id, updater_fun) do
    case Map.fetch(todo_list.entries, entry_id) do
      :error ->
        todo_list

      {:ok, old_entry} ->
        new_entry = updater_fun.(old_entry)
        new_entries = Map.put(todo_list.entries, new_entry.id, new_entry)
        %TodoList{todo_list | entries: new_entries}
    end
  end

  def delete_entry(todo_list, entry_id) do
    new_entries = Map.delete(todo_list.entries, entry_id)

    %TodoList{todo_list | entries: new_entries}
  end
end