defmodule Bench do

  def bench() do bench(100) end

  def bench(l) do

    ls = [16,32,64,128,256,512,1024,2*1024,4*1024,8*1024]

    time = fn (i, f) ->
      seq = Enum.map(1..i, fn(_) -> :rand.uniform(100000) end)
      elem(:timer.tc(fn () -> loop(l, fn -> f.(seq) end) end),0)
    end

    bench = fn (i) ->

      prime = fn (seq) ->
        List.foldr(seq, [], fn (e, acc) -> list_insert(e, acc) end)
      end



      tl = time.(i, list)
      tt = time.(i, tree)

      IO.write("  #{tl}\t\t\t#{tt}\n")
    end

    IO.write("# benchmark of lists and tree (loop: #{l}) \n")
    Enum.map(ls, bench)

    :ok
  end

  def loop(0,_) do :ok end
  def loop(n, f) do
    f.()
    loop(n-1, f)
  end

  def list_new() do [] end

  def list_insert(e, []) do [e]end
  def list_insert(e, [head | tail]) do
    cond do
      e < head -> [e | [head | tail]]
      true -> [head | list_insert(e, tail)]
    end


  end





end