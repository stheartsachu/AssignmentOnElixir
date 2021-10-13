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
  Examples
  mingle_main("abcd", "1234")
  "a1b2c3d4"
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
  Examples
  mingle_maker_for_equal_ln("abc", "123", 3)
  "a1b2c3"
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

  Examples
  mingle_maker_for_equal_ln("abc", "123", 3)
  "a1b2c3"
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
  Examples
  check_len("1243", "abc")
  {4,true}
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
  @doc """
    check_input_bracket(bracket_string))
    and returns true or false
  """

  # Below mention function is the first fall fucntion
  # takes input string and split it into list of string
  def check_input_bracket(bracket_string) do
    String.codepoints(bracket_string) |> check_input_bracket([])
  end

  # This the termination condition for recusion
  # we insert element in stack and pop out
  # In this case stack operation are performed at the head of the list
  def check_input_bracket([], []), do: true
  # If stack contain some value,element it means some bracket wont be poped out
  def check_input_bracket([], _stack), do: false

  # below mentioned fucntion take two list
  # first is the list of the brackets
  # Second is the stack

  # take head from the list of brackets then inser at the head of the stack
  # pass tail for further iterations
  def check_input_bracket([head | tail], stack) when head in ["{", "[", "("] do
    check_input_bracket(tail, [head | stack])
  end

  # Here pass tail for further iterations and updated value of stack

  # below mention function , while iterating sometime we encounter closing pranthesis before opening bracket
  # So, it raise an error to avoid it we have used this fucntionality
  def check_input_bracket([head | _], []) when head in ["}", "]", ")"],
    do: false

  # here we are only check head of the list is closing bracket then

  # "}" pattern matched function
  def check_input_bracket(["}" | tail], stack) do
    if hd(stack) == "{" do
      check_input_bracket(tail, tl(stack))
    else
      false
    end
  end

  # "]" pattern matched function

  def check_input_bracket(["]" | tail], stack) do
    if hd(stack) == "[" do
      check_input_bracket(tail, tl(stack))
    else
      false
    end
  end

  # ")" pattern matched function
  def check_input_bracket([")" | tail], stack) do
    if hd(stack) == "(" do
      check_input_bracket(tail, tl(stack))
    else
      false
    end
  end

  ################################ (END)#############################
end
