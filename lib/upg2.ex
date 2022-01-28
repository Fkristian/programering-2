defmodule Upg2 do
  @moduledoc false

  @type literal() :: {:num, number()} | {:var, atom()}

  @type expr() :: literal()
                  | {:add, expr(), expr()}
                  | {:sub, expr(), expr()}
                  | {:mul, expr(), expr()}
                  | {:div, literal(), expr()}
                  | {:exp, expr(), literal()}
                  | {:ln, expr()}
                  | {:sin, expr()}
                  | {:cos, expr()}
                  | {:root, expr()}
                  | {:sin, expr()}



  def test1() do
    e = {:add, {:mul, {:num, 2}, {:var, :x}},{:num, 4}}
    d = deriv(e, :x)
    c = calc(d,:x, 5)
    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("simplified: #{pprint(simplify(d))}\n")
    IO.write("calculated: #{pprint(simplify(c))}\n")


  end

  def test2() do
    e = {:add, {:exp, {:var, :x},{:num, 3}}, {:num, 4}}
    d = deriv(e, :x)
    c = calc(d, :x, 4)
    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("simplified: #{pprint(simplify(d))}\n")
    IO.write("calculated: #{pprint(simplify(c))}\n")

  end


  #ln
  def test3() do
    e = {:ln, {:var, :x}}
    d = deriv(e, :x)
    c = calc(d,:x, 5)
    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("simplified: #{pprint(simplify(d))}\n")
    IO.write("calculated: #{pprint(simplify(c))}\n")

  end

  #div
  def test4() do
    e = {:div, {:num, 1}, {:num, 0}}
    d = deriv(e, :x)
  IO.write("expression: #{pprint(e)}\n")
  IO.write("derivative: #{pprint(d)}\n")
  IO.write("simplified: #{pprint(simplify(d))}\n")


  end

  #root
  def test5() do
    e = {:root, {:var, :x}}
    d = deriv(e, :x)
    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("simplified: #{pprint(simplify(d))}\n")


  end


  #sin
  def test6() do
    e = {:sin, {:var, :x}}
    d = deriv(e, :x)
    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")

    IO.write("simplified: #{pprint(simplify(d))}\n")


  end

  def test7() do
    e = {:div, {:sin, {:var, :x}}, {:var, :x}}
    d = deriv(e, :x)

    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("simplified: #{pprint(simplify(d))}\n")
d

#    IO.write("simplified: #{pprint(simplify(d))}\n")




  end

  def test8() do
    e = {:add, {:mul,{:num, 2},{:exp,{:var, :x},{:num, 2}}},{:add, {:mul, {:num, 3}, {:var, :x}}, {:num, 5}}}
    d = deriv(e, :x)




    IO.write("expresion: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("simplified: #{pprint(simplify(d))}\n")

  end


  def deriv({:num, _}, _) do {:num, 0} end
  def deriv({:div, _, {:num, 0}}, _) do {:error,"error, dont devide by 0"} end
  def deriv({:var, v}, v) do {:num, 1} end
  def deriv({:var, _}, _) do {:num, 0} end
  def deriv({:root, {:num, _}, _}) do {:num, 0} end
  def deriv({:root, {:var, v}, t}) do {:num, 0} end
  def deriv({:sin, {:num, _}, _}) do {:num, 0} end



  def deriv({:sin, {:var, v}}, v) do {:cos, {:var, v}} end
  def deriv({:sin, {:var, v}}, t) do {:num, 0} end



  def deriv({:add, e1, e2}, v) do
    {:add, deriv(e1, v), deriv(e2, v)}
  end

  def deriv({:sub, e1, e2}, v) do
    {:sub, deriv(e1, v), deriv(e2, v)}
  end

  def deriv({:mul, e1, e2}, v) do
    {:add, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}}
  end

  def deriv({:div, e1, e2}, v) do
    {:div, {:sub, {:mul, deriv(e1, v), e2}, {:mul, e1, deriv(e2, v)}}, {:exp, e2, {:num,2}}}
  end


  def deriv({:ln, {:var, v}}, v) do {:div, {:num, 1},{:var, v}} end
  def deriv({:ln, _},_) do {:num, 0} end

  def deriv({:root, e1}, v) do
    {:div, {:num, 1},{:mul, {:num, 2}, {:exp, e1, {:div, {:num, -1}, {:num, 2}}}}}
  end
  def deriv({:root, e1}, v) do
    {:div, {:num, 1},{:mul, {:num, 2}, {:exp, e1, {:div, {:num, -1}, {:num, 2}}}}}
  end



  def deriv({:exp, e, {:num, n}}, v) do
    {:mul,
      {:mul, {:num, n}, {:exp, e, {:num, n-1}}},
    deriv(e, v)}
  end


  def calc({:num, n}, _, _) do {:num, n} end

  def calc({:var, v}, v, n) do {:num, n} end
  def calc({:var, v}, _, _) do {:var, v} end
  def calc({:add, e1, e2}, v, n) do
    {:add, calc(e1, v, n), calc(e2, v, n)}
  end
  def calc({:sub, e1, e2}, v, n) do
    {:sub, calc(e1, v, n), calc(e2, v, n)}
  end
  def calc({:mul, e1, e2}, v, n) do
    {:mul, calc(e1, v, n), calc(e2, v, n)}
  end
    def calc({:div, e1, e2}, v, n) do
    {:div, calc(e1, v, n), calc(e2, v, n)}
  end
  def calc({:exp, e1, e2}, v, n) do
    {:exp,calc(e1, v, n), calc(e2, v, n)}
  end

  def pprint({:error, n}) do "#{n}" end
  def pprint({:num, n}) do "#{n}" end
  def pprint({:var, v}) do "#{v}" end
  def pprint({:add, e1, e2}) do "(#{pprint(e1)} + #{pprint(e2)})" end
  def pprint({:sub, e1, e2}) do "(#{pprint(e1)} - #{pprint(e2)})" end
  def pprint({:mul, e1, e2}) do "(#{pprint(e1)} * #{pprint(e2)})" end
  def pprint({:div, e1, e2}) do "(#{pprint(e1)} / #{pprint(e2)})" end
  def pprint({:exp, e1, e2}) do "#{pprint(e1)} ^ (#{pprint(e2)})" end
  def pprint({:root, e1}) do "sqrt(#{pprint(e1)})" end
  def pprint({:ln, v}) do "ln (#{pprint(v)})" end
  def pprint({:sin, v}) do "sin (#{pprint(v)})" end
  def pprint({:cos, v}) do "cos (#{pprint(v)})" end

  {:add, {:mul, {:num, 4}, {:var, :x}}, {:num, 3}}

  def simplify({:add, e1, e2}) do
   simplify_add(simplify(e1), simplify(e2))
   end

  def simplify({:sub, e1, e2}) do
    simplify_sub(simplify(e1), simplify(e2))
  end
  def simplify({:mul, e1, e2}) do
    simplify_mul(simplify(e1), simplify(e2))
  end
  def simplify({:exp, e1, e2}) do
    simplify_exp(simplify(e1), simplify(e2))
  end
  def simplify({:div, e1, e2}) do
    simplify_div(simplify(e1), simplify(e2))
    end

def simplify(e) do e end

  {:add, {:mul, {:num, 4}, {:var, :x}}, {:num, 3}}

  def simplify_add({:num, 0}, e2) do e2 end
  def simplify_add(e1, {:num, 0}) do e1 end
  def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end
  def simplify_add(n1,n2) do {:add, n1, n2} end


  def simplify_sub({:num, 0}, e2) do e2 end
  def simplify_sub(e1, {:num, 0}) do e1 end
  def simplify_sub({:num, n1}, {:num, n2}) do {:num, n1-n2} end
  def simplify_sub(n1,n2) do {n1,n2} end



  def simplify_mul({:num, 0}, _) do {:num, 0} end
  def simplify_mul(_, {:num, 0}) do {:num, 0} end
  def simplify_mul({:num, 1}, e2) do e2 end
  def simplify_mul(e1, {:num, 1}) do e1 end
  def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end
  def simplify_mul({:num, n1}, {:mul, {:num, n2}, {:var, e1}}) do {:mul, {:num, n1*n2 }, {:var, e1}} end
  def simplify_mul({:mul, {:num, n2}, {:var, e1}}, {:num, n1}) do {:mul, {:num, n1*n2 }, {:var, e1}} end
  def simplify_mul(e1, e2) do {:mul, e1, e2} end

  def simplify_exp(_, {:num, 0}) do {:num, 0} end
  def simplify_exp(e1, {:num, 1}) do e1 end
  def simplify_exp({:num, n1}, {:num, n2}) do {:num, :math.pow(n1,n2)} end
  def simplify_exp(e1, e2) do {:exp, e1, e2} end

  def simplify_div(v, {:num, 0}) do {:error} end
  def simplify_div(v, v) do {:num, 1} end
  def simplify_div(e1, {:num, 1}) do e1 end
  def simplify_div({:num, n1}, {:num, n2}) do {:num, n1/n2} end
  def simplify_div(e1, e2) do {:div, e1, e2} end


end