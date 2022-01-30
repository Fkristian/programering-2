defmodule Register do


  def new() do [{0, 88},{1, 6},{2, 7},{3, 8},{4, 9},{5, 10}] end



  def readR([], rs) do 0 end
  def readR([{rs, v} | _], rs) do v end
  def readR([head | tail], rs) do readR(tail, rs) end


  def write(reg, rd, rv) do
    #IO.write("in1")
    writeR(reg, rd, rv, []) end
  def writeR([{registerAddress, registerValue} | tail], registerAddress, newValue, newList) do
    #IO.write("in2 \n")
    newList = [{registerAddress, newValue} | newList]

    combineList(newList, tail)


  end
  def writeR([head | tail], registerAddress, newValue, newList) do


  writeR(tail, registerAddress, newValue, [head | newList])
  end



  def combineList(e, []) do

    e
  end
  def combineList(e, [head | tail]) do combineList([head | e], tail) end

  def write(reg, rd, rv) do
    #IO.write("in1")
    writeR(reg, rd, rv, []) end
  def writeR([{registerAddress, registerValue} | tail], registerAddress, newValue, newList) do
    #IO.write("in2 \n")
    newList = [{registerAddress, newValue} | newList]

    combineList(newList, tail)


  end
  def writeR([head | tail], registerAddress, newValue, newList) do


    writeR(tail, registerAddress, newValue, [head | newList])
  end

end
