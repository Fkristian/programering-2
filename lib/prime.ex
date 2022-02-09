defmodule Prime do

  def pri1(n) do
    list = Enum.to_list(2..n)
    pickOutPrime(list)
  end
  def pickOutPrime([])do [] end
  def pickOutPrime([prime | tail])do
    tail = removeNonePrime(prime, tail)
    [prime | pickOutPrime(tail)]
  end
  def removeNonePrime(prime, [])do [] end
  def removeNonePrime(prime, [head | tail])do
    case rem head, prime do
      0 -> removeNonePrime(prime, tail)
      _ -> [head | removeNonePrime(prime, tail)]
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
    reverse(checkPrimeWithListPutFirst(list, []))
  end

  def checkPrimeWithListPutFirst([head | tail], [])do checkPrimeWithListPutFirst(tail, [head]) end

  def checkPrimeWithListPutFirst([], primes) do primes end
  def checkPrimeWithListPutFirst([head | tail], prims)do checkPrimeWithListPutFirst(tail, ifNotDivWithPrimsPutFirst(head, prims, prims)) end

  def ifNotDivWithPrimsPutFirst(check, [], prims)do [check | prims] end
  def ifNotDivWithPrimsPutFirst(check, [head | tail], prims)do
    case rem check, head do
      0 -> prims
      _ -> ifNotDivWithPrimsPutFirst(check , tail, prims)
    end
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
