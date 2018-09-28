defmodule Sort do
  @moduledoc"""
    The Sort module contains 3 sorting algorithms: insertion, bubble, and selection.
    Bubble sort is set as default. To enable a different sorting algorithm, comment and uncomment in sort(list) function, see # CHANGEME

  """


  @doc"""
    Sort the given list of size n to an ascending list.

    Function to use:
    -   'Sort.sort/1'

    ## Input:
        - unsorted_list: unsorted list of numbers.

    ## Output:
        - sorted list: from lowest to highest.

    ## Example:
        - input = [5, 1, 8 4]
        - output = [1, 4, 5, 8]

  """

  @type unsorted_list :: list()
  @type sorted_list :: list()

  @spec sort(unsorted_list) :: sorted_list
  def sort(list) when is_list(list) do
    # CHANGEME

    #do_insertion_sort([], list)
    #do_selection_sort(list, [])
    bubble_sort(list, 0)
  end


  #Insertion sort
  #-------------------------------------------------------------------------
  defp do_insertion_sort(_sorted_list = [], _unsorted_list = [head|tail]), do: do_insertion_sort([head], tail)
  defp do_insertion_sort(sorted_list, _unsorted_list = [head|tail]), do: insert(head, sorted_list) |> do_insertion_sort(tail)
  defp do_insertion_sort(sorted_list, _unsorted_list = []), do: sorted_list

  defp insert(elem, _sorted_list = []) do
    [elem]
  end

  defp insert(elem, sorted_list) do
    [min|rest] = sorted_list
    if min >= elem do [elem|[min|rest]] else [min|insert(elem, rest)] end
  end


  #Bubble sort
  #-------------------------------------------------------------------------
  defp do_bubble_sort([head | [ second | tail ]]) when tail != [ ] and head >= second, do: [ second | do_bubble_sort([head|tail])]
  defp do_bubble_sort([head | [ second | tail ]]) when tail != [ ] and head <  second, do: [ head | do_bubble_sort([second|tail])]
  defp do_bubble_sort([head | [ second | _tail ]]) when head >= second, do: [second | [head | [ ] ]]
  defp do_bubble_sort([head | [ second | _tail ]]) when head <  second, do: [head | [second | [ ] ]]

  @spec bubble_sort([unsorted_list], integer) :: [sorted_list]
  defp bubble_sort(list, accumulator) when accumulator < length(list), do: bubble_sort(do_bubble_sort(list), (accumulator + 1))
  defp bubble_sort(list, _), do: list


  #Selection sort
  #-------------------------------------------------------------------------
  defp do_selection_sort([head|[]], sorted_list), do: sorted_list ++ [head]

  @spec do_selection_sort([unsorted_list], [sorted_list]) :: [sorted_list]
  defp do_selection_sort(unsorted_list, sorted_list) do
    min = find_minimum(unsorted_list)
    do_selection_sort(List.delete(unsorted_list, min), sorted_list ++ [min])
  end

  defp find_minimum([head|[second|tail]]) when head <= second, do: find_minimum([head|tail])
  defp find_minimum([head|[second|tail]]) when head > second, do: find_minimum([second|tail])
  defp find_minimum([head|[second|[]]]) when head <= second, do: head 
  defp find_minimum([head|[second|[]]]) when head > second, do: second 
  defp find_minimum([head|[]]), do: head 

end

