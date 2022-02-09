defmodule Prime do

  def pri1(n) do
    list = Enum.to_list(2..n)
    pickOutPrime(list)
  end
  def pickOutPrime([prime | tail])do
    tail = removeNonePrime(prime, tail)
  end
  def pickOutPrime(prime, [head | tail])do
    case rem prime, head do
      0 -> pickOutPrime(prime, [head | tail])
    end
  end


  def pri1(n) do
    [head | tail] = Enum.to_list(2..n)
    pickOutPrime([head], tail, [])
  end
  def pickOutPrime(e, [], [])do e end
  def pickOutPrime(e, [], n)do
    [nextPrime | tail] = reverse(n)
    pickOutPrime([nextPrime | e], tail, [])
  end
  def pickOutPrime([div | primes], [head | tail], n)do
   case rem head, div do
     0 -> pickOutPrime([div | primes], tail, n)
     _ -> pickOutPrime([div | primes], tail, [head | n])
   end
  end








  def pri2(n) do
    list = Enum.to_list(2..n)
    checkPrimeWithList(list, [])
  end

  def checkPrimeWithList([head | tail], [])do checkPrimeWithList(tail, [head]) end
  def checkPrimeWithList([], primes) do primes end
  def checkPrimeWithList([head | tail], prims)do checkPrimeWithList(tail, ifNotDivWithPrimsPutLast(head, prims)) end


  def ifNotDivWithPrimsPutLast(check,[]) do [check] end
  def ifNotDivWithPrimsPutLast(check,[head | tail]) do
    case rem check, head do
      0 -> [head | tail]
      _ -> [head | ifNotDivWithPrimsPutLast(check,tail)]
    end
  end


  def pri3(n) do
    list = Enum.to_list(2..n)
    stuff(list, [])
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
