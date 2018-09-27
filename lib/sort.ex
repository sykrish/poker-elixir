defmodule Sort do
  @doc"""
    The Sort module contains 3 sorting algorithms: insertion, bubble, and selection.
    Bubble sort is set as default. To enable a different sorting algorithm, comment and uncomment in sort(list) function.

    ## Parameters:
        - unorderd_list: unorderd list of numbers.

    ## Output:
        - orderd list: from lowest to highest.

  """

  def sort(list) when is_list(list) do
    #do_insertion_sort([], list)
    bubble_sort(list, 0)
    #do_selection_sort(list, [])
  end


  #Insertion sort
  #-------------------------------------------------------------------------
  def do_insertion_sort(_sorted_list = [], _unsorted_list = [head|tail]), do: do_insertion_sort([head], tail)
  def do_insertion_sort(sorted_list, _unsorted_list = [head|tail]), do: insert(head, sorted_list) |> do_insertion_sort(tail)
  def do_insertion_sort(sorted_list, _unsorted_list = []), do: sorted_list

  def insert(elem, _sorted_list = []) do
    [elem]
  end

  def insert(elem, sorted_list) do
    [min|rest] = sorted_list
    if min >= elem do [elem|[min|rest]] else [min|insert(elem, rest)] end
  end


  #Bubble sort
  #-------------------------------------------------------------------------
  def do_bubble_sort([head | [ second | tail ]]) when tail != [ ] and head >= second, do: [ second | do_bubble_sort([head|tail])]
  def do_bubble_sort([head | [ second | tail ]]) when tail != [ ] and head <  second, do: [ head | do_bubble_sort([second|tail])]
  def do_bubble_sort([head | [ second | _tail ]]) when head >= second, do: [second | [head | [ ] ]]
  def do_bubble_sort([head | [ second | _tail ]]) when head <  second, do: [head | [second | [ ] ]]

  def bubble_sort(list, accumulator) when accumulator < length(list), do: bubble_sort(do_bubble_sort(list), (accumulator + 1))
  def bubble_sort(list, _), do: list


  #Selection sort
  #-------------------------------------------------------------------------
  def do_selection_sort([head|[]], orderd_list), do: orderd_list ++ [head]

  def do_selection_sort(unorderd_list, orderd_list) do
    min = find_minimum(unorderd_list)
    do_selection_sort(List.delete(unorderd_list, min), orderd_list ++ [min])
  end

  def find_minimum([head|[second|tail]]) when head <= second, do: find_minimum([head|tail])
  def find_minimum([head|[second|tail]]) when head > second, do: find_minimum([second|tail])
  def find_minimum([head|[second|[]]]) when head <= second, do: head 
  def find_minimum([head|[second|[]]]) when head > second, do: second 
  def find_minimum([head|[]]), do: head 

end

