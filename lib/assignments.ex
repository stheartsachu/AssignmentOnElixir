defmodule Assignments do
  @moduledoc """
  Documentation for `Assignments`.
  Assignments.super_digit(Number as argument) -> returns super digit of (number)
  Assignments.mingle_main(stringOne,stringTwo) -> returns mingle string of two inputed String
  Assignments.swap_the_positions(inputed string) -> returns swaped position string
  Assignments.check_bracket(inputed String) -> returns true or false , wheather have complete pair of digits or not
  """

  ######################## (Assignment - I) ######################################
  @doc """
  super_digit is funntion takes two arguments
  1st argument is the number whose super digit is to find
  2nd argument is the times_multiply number
  ex -> 9456*2 = 94569456
  ## Examples
        iex>super_digit(148, 3)
        iex>3
  """
  @spec super_digit(any, non_neg_integer) :: integer
  def super_digit(num, k) do
    # k * Enum.sum(Integer.digits(num))
    # Hack
    num_string = to_string(num)
    # Convert number into string

    String.duplicate(num_string, k)
    # make k times a given number
    |> :erlang.binary_to_integer()
    # Now again Convert Given string into number
    # Pass this converted number to the super_digit_maker function
    |> super_digit_maker()
  end

  @doc """
  super_digit is funntion takes one arguments
  argument : Numbers

  ## Examples
        iex>super_digit_maker(9875)
        iex>2
  """
  @spec super_digit_maker(integer) :: integer
  def super_digit_maker(num) do
    # Create sum of the digits of a number
    sum_value = Enum.sum(Integer.digits(num))

    # convert sum_value into string for caculating the total number of digits in a number
    sum_value_in_string = Integer.to_string(sum_value)
    sum_ln = String.codepoints(sum_value_in_string)
    # evaluate length of the string by spliting string into list of digits
    # because this is the need for making super digit
    # super_digit is  sum untill the digits sum of number become single digit

    if length(sum_ln) != 1 do
      # call recusively until sigle digit get remains
      super_digit_maker(sum_value)
    else
      # If condition get failed then return the last value of the computed sum of digits
      sum_value
    end
  end

  ############################### (END)###################################

  ############################### (Assignment-II)##############################
  @doc """
  mingle_main is funntion takes two arguments
  1st argument is the input string
  2nd argument is also a inputed string
  Task : we have to create mingle string using given strings
  ## Examples
        iex>mingle_main("abcd", "1234")
        iex>"a1b2c3d4"
  """
  def mingle_main(input1, input2) do
    # If the both given strings contains only One charcter then interchage the postion to create mingle
    # If both string of length one
    if String.length(input1) == 1 and String.length(input1) == 1 do
      # Here returns the interchanged or swapped values
      "#{input2}#{input1}"
    else
      # If string of the equal length then call for the mingle_maker_for_equal_ln function
      if String.length(input1) == String.length(input2) do
        Enum.join(mingle_maker_for_equal_ln(input1, input2, String.length(input2)), "")
        # The above mentioned fucntion is used to create list of string into String
      else
        mingle_maker_for_unequal_ln(input1, input2)
        # The above mention fucntion is for those strings whose lengths are diffrent of unequal
      end
    end
  end

  #
  @doc """
  mingle_maker_for_equal_ln(input_one, input_two, idx)

  1st argument : 1st inputed String
  2nd argument : 2nd inputed String
  3rd argument : length for upto range
  ex -> string_one = "abc"
        string_two = "123"
        length of string(3rd argument) i.e, 3 here

  Task : we have to create mingle string using given strings
  ## Examples
        iex>mingle_maker_for_equal_ln("abc", "123", 3)
        iex>"a1b2c3"
  """
  def mingle_maker_for_equal_ln(input_one, input_two, idx) do
    for i <- 0..(idx - 1) do
      char_one = String.at(input_one, i)
      char_two = String.at(input_two, i)
      "#{char_one}#{char_two}"
    end
  end

  @doc """
  mingle_maker_for_unequal_ln(input1, input2)
  if string of unequal length then , shorter length string will be the new range length

  1st argument : 1st inputed String
  2nd argument : 2nd inputed String
  ex -> string_one = "abcd"
        string_two = "123"
        Here original length will be three because shorter string have length of 3

  ## Examples
        iex>mingle_maker_for_equal_ln("abc", "123", 3)
        iex>"a1b2c3"
  """
  def mingle_maker_for_unequal_ln(input1, input2) do
    {org_len_for_mingle, first_input_is_greater} = check_len(input1, input2)

    if first_input_is_greater do
      last_chars_of_input1 =
        for i <- org_len_for_mingle..(String.length(input1) - 1) do
          String.at(input1, i)
        end

      Enum.join(
        mingle_maker_for_equal_ln(input1, input2, org_len_for_mingle) ++
          last_chars_of_input1,
        ""
      )
    else
      last_chars_of_input2 =
        for i <- org_len_for_mingle..(String.length(input2) - 1) do
          String.at(input2, i)
        end

      Enum.join(
        mingle_maker_for_equal_ln(input1, input2, org_len_for_mingle) ++ last_chars_of_input2,
        ""
      )
    end
  end

  @doc """
  This is the helper or mate function which computes the which string is shorter
  and return the length of the greater string with bolean status in tuple form
  check_len(input1, input2)
  1st argument : 1st given string
  2nd argument : 2nd given string
  ## Examples
        iex>check_len("1243", "abc")
        iex>{4,true}
  """

  def check_len(input1, input2) do
    input_one_len = String.length(input1)
    input_two_len = String.length(input2)

    if input_one_len > input_two_len do
      {input_two_len, true}
    else
      {input_one_len, false}
    end
  end

  ########################### (END)#########################################

  ############################## (Assignment - III)#########################################

  @doc """
  swap_the_positions(input_string)
  argument will be the inputed string
  """
  def swap_the_positions(input_string) do
    inp_len = String.length(input_string)
    # If the length of the given string is even then we can swaped easily other
    # if it is odd we will trim the odd position character at the end of swapping all values we will apend it

    if rem(inp_len, 2) == 0 do
      # if even then swaped the position of character
      swap_logic(input_string)
    else
      "#{swap_logic(input_string)}#{String.at(input_string, inp_len - 1)}"
      # if odd then first swaped postion upto even length then concatenate the
      # odd postion value character at the end
    end
  end

  def swap_logic(input_string) do
    # perform range operation upto len of the string -1 because range start from 0

    for i <- 0..(String.length(input_string) - 1) do
      if rem(i, 2) != 0 do
        # get the previous value
        String.at(input_string, i - 1)
      else
        # get the next value
        String.at(input_string, i + 1)
      end
    end
    |> Enum.join("")

    # join list of charater swapped elements into string
  end

  ############################### (END)#############################

  ########################### (Assignment-IV)###################################

  # Firstly below mention function is main function.
  # This function is of arity/1 which split string into list and call check_bracket functions
  def check_bracket(str) do
    check_brackets(String.codepoints(str), [])
  end

  # [elements of string ],[]

  def check_brackets(["[" | chars_list], stack) do
    check_brackets(chars_list, ["]" | stack])
  end

  def check_brackets(["{" | chars_list], stack) do
    check_brackets(chars_list, ["}" | stack])
  end

  def check_brackets(["(" | chars_list], stack) do
    check_brackets(chars_list, [")" | stack])
  end

  def check_brackets([next | chars_list], [top | stack]) when next === top do
    check_brackets(chars_list, stack)
  end

  def check_brackets([next | chars_list], stack)
      when next not in ["[", "{", "(", ")", "}", "]"] do
    check_brackets(chars_list, stack)
  end

  # if our stack and out mate list i.e., chars_list is empty then return true
  def check_brackets([], []) do
    true
  end

  # This is basically the else case for above condtion
  def check_brackets(_, _) do
    false
  end

  ################################ (END)#############################
end
