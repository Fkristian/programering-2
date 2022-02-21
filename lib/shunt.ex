defmodule Shunt do
 # Shunt.compress[{:two,-1},{:one,1},{:one,-1},{:two,1}]
  def fewer(main, track1, track2, goal)do fewer(main, track1, track2, goal, []) end
  def fewer(goal, track1, track2, goal, moves)do compress(reverse(moves)) end
  def fewer(main,track1, track2 ,[goalHead | gaolTail], moves)do

    cond do
      Lists.member(main, goalHead) == :yes -> {hs, ts} = split(main, goalHead)
                                              {main, one, two} = Moves.single({:one,length(ts) + 1},{main,track1,track2})
                                             {main, one, two} = Moves.single({:two, length(hs)}, {main, one, two})
                                              {main, one, two} = Moves.single({:one, -1}, {main, one, two})
                                              moves = [{:one, -1},{:two, length(hs)},{:one,length(ts) + 1} | moves]
                                              fewer([],one,two, gaolTail, moves)
      # {[],track1,track2} = Moves.single({:one,  -1},{main,track1,track2})



      Lists.member(track1, goalHead) == :yes -> position = Lists.position(track1, goalHead)
                                                {main,track1,track2} = Moves.single({:one, -1 * position + 1},{main,track1,track2})
                                                {main,track1,track2} = Moves.single({:two,  position - 1},{main,track1,track2})
                                                {main,track1,track2} = Moves.single({:one,  -1},{main,track1,track2})
                                                moves = [{:one,  -1},{:two,  position - 1},{:one, -1 * position + 1} | moves]

                                                fewer([],track1,track2, gaolTail, moves)


      Lists.member(track2, goalHead) == :yes -> position = Lists.position(track2, goalHead)
                                                {main,track1,track2} = Moves.single({:two, -1 * position + 1},{main,track1,track2})
                                                {main,track1,track2} = Moves.single({:one,  position - 1},{main,track1,track2})
                                                {main,track1,track2} = Moves.single({:two,  -1},{main,track1,track2})
                                                moves = [{:two,  -1},{:one,  position - 1},{:two, -1 * position + 1} | moves]

                                                fewer([],track1,track2, gaolTail, moves)

    end
  end


  def compress([])do [] end
  def compress(moves)do

    compressedMoves = rules(moves)

    case compressedMoves == moves do
      true -> moves
      false -> compress(compressedMoves)
    end
  end
  def rules([]) do [] end

  def rules([{_, 0} | []])do
    []
  end
  def rules([xs | []])do
    [xs]
  end
  def rules([{_, 0} | tail])do
    rules(tail)
  end
  def rules([{track1, order1},{_, 0} | tail])do
    rules([{track1, order1} | tail])
  end
  def rules([{track1, order1},{track1, order2}| tail])do

    rules([{track1, order1 + order2} | tail])
  end
  def rules([{track1, order1},{track2, order2}| tail])do
      [{track1, order1} | rules([{track2, order2} | tail])]
  end

  def few(e,n)do
    hold =few(e,n,[])
    reverse(hold)
  end
  #Shunt.few( [:c,:a,:b],[:c,:b,:a])

  def few(ys,ys, moves)do moves end
  def few([head | mTail], [head | wTail], moves) do  few(mTail, wTail, moves) end
  def few(xs,ys, moves)do
    [y | _] = ys
    {hs, ts} = split(xs, y)
    {main, one, two} = Moves.single({:one,length(ts) + 1},{xs,[],[]})
    {main, one, two} = Moves.single({:two, length(hs)}, {main, one, two})
    {main, one, two} = Moves.single({:one, hold = -1 * length(one)}, {main, one, two})
    {main, _, _} = Moves.single({:two, test = -1 * length(two)}, {main, one, two})
    [_ | mtail] = main
    [_ | wtail] = ys
    moves = [{:two, test} ,{:one, hold},{:two, length(hs)},{:one,length(ts) + 1} | moves]
    few(mtail, wtail, moves)

  end




  def find(e,n)do
    hold =find(e,n,[])
    reverse(hold)
  end
  def find(ys,ys, moves)do moves end
  def find(xs,ys, moves)do
    [y | _] = ys
    {hs, ts} = split(xs, y)
    {main, one, two} = Moves.single({:one,length(ts) + 1},{xs,[],[]})
    {main, one, two} = Moves.single({:two, length(hs)}, {main, one, two})
    {main, one, two} = Moves.single({:one, hold = -1 * length(one)}, {main, one, two})
    {main, _, _} = Moves.single({:two, test = -1 * length(two)}, {main, one, two})
    [_ | mtail] = main
    [_ | wtail] = ys
    moves = [{:two, test} ,{:one, hold},{:two, length(hs)},{:one,length(ts) + 1} | moves]
    find(mtail, wtail, moves)

  end

  def split([head | tail], head)do
    {[], splitRight(tail)}
  end

  def split([head| tail], y)do
    {left, right} = split(tail, y)
    {[head | left], right}
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
