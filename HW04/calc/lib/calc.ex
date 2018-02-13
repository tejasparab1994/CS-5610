defmodule Calc do

# <---------------------------Stack implementation ----------------------->
  def size(stack) do
    Enum.count(stack)
  end

  def pop(stack) do
    #IO.inspect [top | rest] = stack
    [top | rest] = stack
      {top, rest}
  end

  def push(stack, element) do
    [element | stack]
  end

#--------------------------------------Code starting point-------------------->
  def main do
    input = IO.gets "> Enter expression: "
    IO.puts eval(input)
    main()
  end
#_____________________________________________________________________________#
  def eval(input) do
    operator = []
    operand = []
    input
    |> String.replace("+", " + ")
    |> String.replace("-", " - ")
    |> String.replace("*", " * ")
    |> String.replace("/", " / ")
    |> String.replace("("," ( ")
    |> String.replace(")"," ) ")
    |> String.trim()
    |> String.split(" ")
    |> Enum.filter(fn(x) -> x != "" end)
    |> eval_expression(operator, operand)
    |> List.to_string
    |> String.to_integer

  end


  def eval_expression([element | expression],operator, operand) do
    {operator, operand} =
    cond do
      String.match?(element, ~r/^[0-9]*$/)
      -> {operator, push(operand, element)}

      String.match?(element, ~r/[-+*\/]/) && Enum.count(operator) == 0
       -> {push(operator, element), operand}

      String.match?(element, ~r/[-+*\/]/) && Enum.count(operator) != 0
      -> calc_preference(element, operator, operand)

      element == "("
       -> {push(operator, element), operand}

      element == ")"
       -> calculate(operator, operand)

      true -> exit("incorrect input")
    end
    eval_expression(expression,operator,operand)
  end
#____________________________________________________________________________#
  def eval_expression([],operator,operand) do

    #CHECK WHETHER OPERATOR STACK EMPTY BEFORE GIVING FINAL ANSWER
    # Returns operand stack

    if operator == [] do
      operand
  else if hd(operator) != "(" do
    {operator, operand} = calculate_once(operator, operand)
    operand = eval_expression([], operator, operand)
  else {_, operator}  = pop(operator)
        operand = eval_expression([], operator, operand)
  end
end
end

#____________________________________________________________________________#

# Most used when single calculation to be done
# Returns both stacks
  defp calculate_once(operator, operand) do
    #IO.inspect operand
    {opr_val,operator} = pop(operator)
    {op1_val,operand} = pop(operand)
    {op2_val,operand} = pop(operand)
    operand =
    cond do
      opr_val == "+" -> push(operand, Integer.to_string( String.to_integer(op1_val) + String.to_integer(op2_val)))
      opr_val == "-" -> push(operand, Integer.to_string( String.to_integer(op2_val) - String.to_integer(op1_val)))
      opr_val == "*" -> push(operand, Integer.to_string( String.to_integer(op1_val) * String.to_integer(op2_val)))
      opr_val == "/" -> push(operand, Integer.to_string( div(String.to_integer(op2_val),String.to_integer(op1_val))))
      true -> exit("incorrect operator")
      end
      {operator, operand}
    end

#____________________________________________________________________________#

# Used only when within bracket calculation to be done.
# COMPUTE EVERYTHING WITHIN THE BRACKET UNTIL OPEN BRACKET ENCOUNTERED IN STACK
# Returns operator and operand stack
  defp calculate(operator, operand) do
    #IO.inspect operator
    if hd(operator) == "(" do
      {_, operator} = pop(operator)
      {operator, operand}
      else

    {operator, operand} = calculate_once(operator, operand)
    {operator, _operand} = calculate(operator, operand)
  end
  end
#____________________________________________________________________________#

# Return updated operator and operand to work on
defp calc_preference(element, operator, operand) do
  #IO.inspect operator
  #IO.inspect operand
  #IO.inspect element
  {_operator, _operand} =
  cond do
    check_precedence(element, operator) == 1
    -> precedence_1(element, operator, operand)
    check_precedence(element, operator) == 2
    -> precedence_2(element, operator, operand)
    check_precedence(element, operator) == 3
    -> precedence_3(element, operator, operand)
  end
end

#____________________________________________________________________________#
defp precedence_1(element, operator, operand) do
  operator = push(operator, element)
  {operator, operand}
end

#____________________________________________________________________________#
defp precedence_2(element, operator, operand) do
  hold_val = element

  {operator, operand} = calculate_once(operator, operand)
  operator = push(operator, hold_val)

  {operator, operand}
end

#____________________________________________________________________________#
defp precedence_3(element, operator, operand) do

  {operator, operand} = calculate_once(operator, operand)
  if(length(operator) == 0) do
  operator = push(operator, element)
  {operator, operand}
  else
  {operator, _operand} = calc_preference(element, operator, operand) #doing this, then 10-5*2+1 works
  end
end

#____________________________________________________________________________#
# Check_precedence should return a number
# Returns true or false
defp check_precedence(element,operator)  do
  precedence = %{"+" => 1, "-" => 1, "*" => 2, "/" => 2, "(" => 0, ")" => 3}
  cond do
    Map.get(precedence, element) > Map.get(precedence, hd(operator))
    -> 1
    Map.get(precedence, element) == Map.get(precedence, hd(operator))
    -> 2
    true -> 3
  end
end

end
