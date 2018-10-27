defmodule ChapterThree.LoopsAndIterations.TailFunctionCalls do
  """
  Practice functions:

    - list_len/1 function that calculates the length of a list
    - range/2 function that takes two integers: from and to and returns a list
    of all numbers in a given range
    - positive/1 function that takes a list and returns another list that 
    contains only positive numbers from the input list
  """

  # First part: counting the length of a list
  def list_len(list) do
    count_len(0, list)
  end

  defp count_len(current_len, []), do: current_len

  defp count_len(current_len, [_head | tail]) do
    count_len(current_len + 1, tail)
  end

  
  # Second part: returning all numbers in a given range
  # Non-tail recursive version
  def range_nontr(from, to) do
    if from == to do
      [to]
    else
      [from | range(from+1, to)]
    end
  end

  # Tail recursive version
  def range(from, to) do
    create_range([], from, to)
  end

  defp create_range(current_range, from, to) do
    if from > to do
      current_range
    else
      create_range([to | current_range], from, to-1)
    end
  end

  # Third part: Returns only the positive numbers in input list
  def positives(list) do
    filter_positives([], list)
  end

  defp filter_positives(current_list, []), do: current_list

  defp filter_positives(current_list, [head | tail]) do
    if head > 0 do
      filter_positives([head | current_list], tail)
    else
      filter_positives(current_list, tail)
    end
  end
end