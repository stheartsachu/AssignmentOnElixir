defmodule Assignments do
  @moduledoc """
  Documentation for `Assignments`.
  """
  ######################## (Assignment - I) ######################################
  @spec super_digit(any, non_neg_integer) :: integer
  def super_digit(num, k) do
    # k * Enum.sum(Integer.digits(num))
    num_string = to_string(num)

    String.duplicate(num_string, k)
    |> :erlang.binary_to_integer()
    |> super_digit_maker()
  end

  @spec super_digit_maker(integer) :: integer
  def super_digit_maker(num) do
    sum_value = Enum.sum(Integer.digits(num))
    sum_value_in_string = Integer.to_string(sum_value)
    sum_ln = String.codepoints(sum_value_in_string)

    if length(sum_ln) != 1 do
      super_digit_maker(sum_value)
    else
      sum_value
    end
  end

  ############################### (END)###################################

  ############################### (Assignment-II)##############################

  def mingle_main(input1, input2) do
    if String.length(input1) == 1 and String.length(input1) == 1 do
      "#{input2}#{input1}"
    else
      if String.length(input1) == String.length(input2) do
        Enum.join(mingle_maker_for_equal_ln(input1, input2, String.length(input2)), "")
      else
        mingle_maker_for_unequal_ln(input1, input2)
      end
    end
  end

  def mingle_maker_for_equal_ln(input_one, input_two, idx) do
    for i <- 0..(idx - 1) do
      char_one = String.at(input_one, i)
      char_two = String.at(input_two, i)
      "#{char_one}#{char_two}"
    end
  end

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

  def swap_logic(input_string) do
    for i <- 0..(String.length(input_string) - 1) do
      if rem(i, 2) != 0 do
        String.at(input_string, i - 1)
      else
        String.at(input_string, i + 1)
      end
    end
    |> Enum.join("")
  end

  def swap_the_positions(input_string) do
    inp_len = String.length(input_string)

    if rem(inp_len, 2) == 0 do
      swap_logic(input_string)
    else
      "#{swap_logic(input_string)}#{String.at(input_string, inp_len - 1)}"
    end
  end

  ############################### (END)#############################

  ########################### (Assignment-IV)###################################

  def check_brackets(str) do
    check_brackets(String.codepoints(str), [])
  end

  def check_brackets(["[" | chars], stack) do
    check_brackets(chars, ["]" | stack])
  end

  def check_brackets(["{" | chars], stack) do
    check_brackets(chars, ["}" | stack])
  end

  def check_brackets(["(" | chars], stack) do
    check_brackets(chars, [")" | stack])
  end

  def check_brackets([next | chars], [top | stack]) when next === top do
    check_brackets(chars, stack)
  end

  def check_brackets([next | chars], stack) when next not in ["[", "{", "(", ")", "}", "]"] do
    check_brackets(chars, stack)
  end

  def check_brackets([], []) do
    true
  end

  def check_brackets(_, _) do
    false
  end

  ################################ (END)#############################
end
