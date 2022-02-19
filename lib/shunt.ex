defmodule Shunt do

  def function({e,_,_},{n,_,_})do
    hold =function(e,n,[])
    reverse(hold)
  end
  def function(ys,ys, moves)do moves end
  def function(xs,ys, moves)do
    [y | _] = ys
    {hs, ts} = split(xs, y)
    {main, one, two} = Moves.single({:one,length(ts) + 1},{xs,[],[]})
    {main, one, two} = Moves.single({:two, length(hs)}, {main, one, two})
    {main, one, two} = Moves.single({:one, hold = -1 * length(one)}, {main, one, two})
    {main, _, _} = Moves.single({:two, test = -1 * length(two)}, {main, one, two})
    [_ | mtail] = main
    [_ | wtail] = ys
    moves = [{:two, test} ,{:one, hold},{:two, length(hs)},{:one,length(ts) + 1} | moves]
    function(mtail, wtail, moves)

  end

  def split([head | tail], head)do
    {[], splitRight(tail)}
  end

  def split([head| tail], y)do
    {left, rigth} = split(tail, y)
    {[head | left], rigth}
  end
  def splitRight([])do [] end
  def splitRight([head | []])do [head] end
  def splitRight([head | tail])do
    [head | splitRight(tail)]
  end


  def reverse(e) do
    reverseR([] ,e)
  end
  def reverseR(e, []) do
    e
  end
  def reverseR(e, [head | tail]) do

    reverseR([head | e], tail)

  end
end
