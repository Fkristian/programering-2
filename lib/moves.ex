defmodule Moves do
  # {xs,[],[]} into {ys,[],[]}.
  #list [:a, :b, :c, :d, :e] =xs
  # [:a, :b, :c, :d, :e] ->
  #
  #
  # [one: 3, two: 2,  one: -3,  two: -2,  one: 4,  two: 0,  one: -4, two: 0,  one: 1, two: 2,  one: -1,  two: -2]
  #mlist[:c, :d, :b, :e, :a] =ys


  def move(moves, trains) do
    [trains | moveR(moves, trains)]
  end
  def moveR([], _) do [] end
  def moveR(moves, trains) do
    [head | tail] = moves
    trains = single(head, trains)
    [trains | moveR(tail, trains)]
  end


  def single({:one,move},{main,one,two})do
    cond do
      move < 0 -> #move from one to main
        transfer = Lists.take(one,-1 * move) #takes the "move" first items from one
        one = Lists.drop(one, -1 * move) #removes the items from one
        main = Lists.append(main, transfer) # puts the items into main
        {main,one,two}
      move > 0 ->
        transfer = Lists.drop(main, length(main) - move)
        one = Lists.append(transfer, one)
        main = Lists.take(main, length(main) - move)
        {main,one,two}
      move == 0 -> {main,one,two}
    end
  end



  def single({:two,move},{main,one,two})do
    cond do
      move < 0 -> #move from one to main
        transfer = Lists.take(two,-1 * move) #takes the "move" first items from two
        two = Lists.drop(two, -1 * move) #removes the items from two
        main = Lists.append(main, transfer) # puts the items into main
        {main,one,two}
      move > 0 ->
        transfer = Lists.drop(main, length(main) - move)
        two = Lists.append(transfer, two)
        main = Lists.take(main, length(main) - move)
        {main,one,two}
      move == 0 -> {main,one,two}
    end
  end



end