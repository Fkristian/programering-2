defmodule Program do
  def load(prgm) do
    {type, code, data} = prgm
    #data = [{:arg, 0, 0},{:arg, 1, 0},{:arg, 2, 0},{:arg, 3, 0}]
    data = []
    {code,labels} = labelSeparator(code)
    {code, data, labels}

  end


  def labelSeparator(code) do labelSeparatorR([], code, [], 0) end
  def labelSeparatorR(e, [], labels, pc) do {reverse(e), labels} end
  def labelSeparatorR(e, [head | tail], labels, pc) do
    case head do
    {:label, x} ->
      head = {:lable, x, pc}
      labelSeparatorR(e, tail, [head | labels], pc)
      head ->
        pc = pc + 4
        labelSeparatorR([head | e], tail, labels, pc)
    end
  end

  def findLablePc([], rs) do :null  end
  def findLablePc([{_, label, pc} | _], label) do pc end
  def findLablePc([head | tail], rs) do findLablePc(tail, rs) end


  def reverse(e) do
    reverseR([] ,e)
  end
  def reverseR(e, []) do
    e
  end
  def reverseR(e, [head | tail]) do

    reverseR([head | e], tail)

  end

  def read_instruction(code, pc) do
    pc = div(pc, 4)
    read_instruction_div4(code,pc)
  end

  def read_instruction_div4([], _) do "Program ran out" end
  def read_instruction_div4([head | _], 0) do head end
  def read_instruction_div4([head | tail], pc) do
    read_instruction_div4(tail, pc - 1)
  end

  #  data = [{:arg, 0, 1},{:arg, 1, 2},{:arg, 2, 3},{:arg, 2, 4}]
  def readM([], adress, offsett) do 0 end
  def readM([{adress, offsett, value} | _], address, offsett) do value end
  def readM([head | tail], address, offsett) do readM(tail, address, offsett) end

  def write(mem, offset, adress, value) do


    writeM(mem, offset, adress, value, []) end
  def writeM([{address, offset, registerValue} | tail], offset, adress ,newValue, newList) do
    newList = [{adress, offset, newValue} | newList]
    combineList(newList, tail)
  end

  def writeM([head | tail], offset, registerAddress, newValue, newList) do
    writeM(tail, offset ,registerAddress, newValue, [head | newList])
  end
  def writeM([], offset, registerAddress, newValue, newList) do
    [{registerAddress, offset, newValue} | newList]
  end


  def combineList(e, []) do e end
  def combineList(e, [head | tail]) do combineList([head | e], tail) end

end

# [{:addi, 1, 0, 5}, {:lw, 2, 0, :arg}, {:add, 4, 2, 1}, {:addi, 5, 0, 1},{:label, :loop}, {:sub, 4, 4, 5}, {:out, 4}, {:bne, 4, 0, :loop}, :halt]

# [{:addi, 1, 0, 5}, {:lw, 2, 0, :arg}, {:add, 4, 2, 1}, {:addi, 5, 0, 1}, {:sub, 4, 4, 5}, :halt]


#[{:addi, 1, 0, 5}, {:lw, 2, 0, :arg}, {:add, 4, 2, 1}, {:label, :loop}, {:addi, 5, 0, 1}, {:sub, 4, 4, 5}]

# Emulator.run({:prg, [{:addi, 1, 0, 5}, {:lw, 2, 0, :arg}, {:add, 4, 2, 1}, {:addi, 5, 0, 1}, {:label, :loop}, {:sub, 4, 4, 5}, {:out, 4}, {:bne, 4, 0, :loop}, :halt], []})



# c"emulator.ex"
# c"program.ex"
# c"register.ex"
# c"out.ex"
