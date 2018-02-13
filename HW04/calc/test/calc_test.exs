defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  test "Easy test" do
    assert Calc.eval("2+3") == 5
    assert Calc.eval("10-5") == 5
    assert Calc.eval("2*10") == 20
  end

  test "Intermediate test" do
    assert Calc.eval("2+2/2") == 3
    assert Calc.eval("10-5*2+1") == 1
    assert Calc.eval("2+2*2-1") == 5
  end

  test "Advanced test" do
    assert Calc.eval("(5 * 2) + (4 + (6 / 2)) - (55 * ((4 * (22 - 3)) -(30 / 2)))") == -3338
    assert Calc.eval("(2+3)-(5*2)+11") == 6
  end

  test "Complicated tests" do
    assert Calc.eval("(10-5)*10/10+(2*4)+(2/2)") == 14
    assert Calc.eval("7234+(123*10)-100+(199/10)/10*(5+2)") == 8371
  end

  test "Division first" do
    assert Calc.eval("10/2*(10/2)+(10-2)/10") == 25
    assert Calc.eval("2/2+2*2") == 5
  end

  test "Addition division" do
    assert Calc.eval("10/2+5*2+(10*2)+(10-2)") == 43
    assert Calc.eval("2*2+(2/2)*((10-2)*5/10+2)") == 10
  end

  test "Complex tests" do
    assert Calc.eval("1910/2010*20-(10+(20*3))") == -70
    assert Calc.eval("5+8*(78-2*(55+11-33)+(40/(10*4)))") == 109
  end

end
