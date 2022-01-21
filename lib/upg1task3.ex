defmodule Upg1task3 do
  @moduledoc false


  def product(m, n) do
    if m == 0 do
      0
    else
      n + product(m-1,n)
    end
  end

  def product_case(m, n) do
    case m do
      0 ->
        0
      x ->
        n + product_case(m-1,n)
    end
  end

  def product_clauses(0,n) do 0 end
  def product_clauses(m,n) do n+product_case(m-1,n) end


  def exp(x,n) do
    case n do
      0 ->
        1
      y ->
        product_case(exp(x,n-1),x)

      end
    end

  def expf(x,n) do

    cond do
      n == 0 -> 1
      n == 1 -> x
      rem(n,2) == 0  -> product_case(exp(x,div(n,2)),exp(x,div(n,2)))
      rem(n,2) == 1-> product_case(exp(x,n-1),x)

    end



  end

  def nth(n,l) do

    [head | tail] = l

    cond do
      n == 0 -> head
      true ->
        nth(n - 1, tail)
    end

  end

  def len(l) do
    [head | tail] = l
    cond do
      tail == [] -> 1
      true -> len(tail)+1
    end
  end



  def sum(l) do
    [head | tail] = l
    cond do
      tail == [] -> head
      true -> sum(tail) + head
    end
  end

  def duplicate(l) do
    [head | tail] = l
    dupli(tail,head*2)

  end

  def dupli(l,e) do
    [head | tail] = l
    cond do
      tail ==[] -> flipArray([head*2 | e ],[])
      true -> dupli(tail,[head*2 | e])
    end

  end


  def flipArray(l,e) do
    [head | tail] = l
    cond do
      tail == [] -> [head | e]
      true -> [head | e]
    end

  end

  def add(x,l) do
    cond do
      isItInArray(x,l) -> 0
      true -> [x|l]
    end


  end

   def isItInArray(x,l) do

    [head | tail] = l
    cond do
      x == head -> true
      tail == [] -> false
      true -> isItInArray(x,tail)
    end
  end


   def remove(x,l) do
      s = len(l)
      removeAndCreate(x,l,[],s,1)

  end

    def removeAndCreate(x,l,e,s,n) do

    k = nth(s - n,l)
      cond do
        (x == k && s == n) -> e
         x == k -> removeAndCreate(x,l,e,s,n+1)
         n == s -> [k | e]
         true -> removeAndCreate(x,l,[k | e],s,n+1)
      end

    end


  def unique (l) do

    [head | tail] = l
      buildNewUniq(l,[],len(l),0)


  end

  def buildNewUniq(l,e,s,n)  do

    cond do
      n == s -> e
      e == [] -> buildNewUniq(l,[nth(s-n-1,l)],s,n+1)
      isItInArray(nth(s-n-1,l),e) -> buildNewUniq(l,e,s,n+1)
      true -> buildNewUniq(l,[nth(s-n-1,l)|e],s,n+1)

    end

  end

  def pack(l) do


    [head | tail] = l

    recPack(l, [])

  end

  def recPack(l,e) do

    [head | tail] = l
    e = copyAndPasteElementXFromLIntoE(head,l,e)
    l = remove(head,l)
    cond do
      l == [] -> e
      true -> recPack(l,e)
    end

  end

  def copyAndPasteElementXFromLIntoE(x,l,e) do

    s = len(l)
    [head | tail] = l
    n = ammountOfOcursesnses(head,l,[],s,1,0)
    putHeadIntoTNAmountOfTimes(head,e,n,[])

  end

  def ammountOfOcursesnses(x,l,e,s,n,q) do

    k = nth(s - n,l)
    cond do
      (x == k && s == n) -> q + 1
      x == k -> ammountOfOcursesnses(x,l,e,s,n+1, q+1)
      n == s -> q
      true -> ammountOfOcursesnses(x,l,[k | e],s,n+1,q)
    end

  end


  def putHeadIntoTNAmountOfTimes(head,e,n,t) do
    cond do
      n == 0 -> [t|e]
      true -> putHeadIntoTNAmountOfTimes(head,e,n - 1,[head | t])
    end

  end


end


