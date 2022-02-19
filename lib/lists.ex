defmodule Lists do


  def take(_, 0)do [] end
  def take([head | tail], n)do [head | take(tail, n-1)] end



  def drop(xs, 0)do xs end
  def drop([_ | tail], n)do drop(tail, n-1) end

  def append([], n) do n end
  def append([head | tail],n)do [head | append(tail, n)] end

  def member([], _)do :no end
  def member([head | _], head)do :yes end
  def member([_ | tail], n)do member(tail, n) end

  def position(xs, y)do positionR(xs, y, 1) end
  def positionR([], _, _) do :error end
  def positionR([head | _], head, n) do n end
  def positionR([_ | tail], y, n) do positionR(tail, y, n+1) end

end





