defmodule Emulator do
  def run(prgm) do
    {code, data, labels} = Program.load(prgm)
    reg = Register.new()

    run(0, code, reg, data,labels)
  end

  def run(pc, code, reg, mem,labels) do

    next = Program.read_instruction(code, pc)
    case next do
    :halt ->
      IO.write("Program done \n")
      :ok
      {:add, rd, rs, rt} ->
        s = Register.readR(reg, rs)
        t = Register.readR(reg, rt)
        reg = Register.write(reg, rd, s + t)

        pc = pc + 4
        run(pc, code, reg, mem,labels)
      {:addi, rd, rs, t} ->
        s = Register.readR(reg, rs)
        reg = Register.write(reg, rd, s + t)

        pc = pc + 4
        run(pc, code, reg, mem, labels)
      {:sub, rd, rs, rt} ->
           s = Register.readR(reg, rs)
           t = Register.readR(reg, rt)
           reg = Register.write(reg, rd, t - s)

           pc = pc + 4
           run(pc, code, reg, mem, labels)
      {:lw, saveAdress, offset, adress} ->
          value = Program.readM(mem, adress, offset)

          reg = Register.write(reg, saveAdress, value)


          pc = pc + 4
          run(pc, code, reg, mem, labels)
      {:sw, registerAdress, offset, saveAdress} ->
         value = Register.readR(reg, registerAdress)
        mem = Program.write(mem, offset ,saveAdress, value)
        pc = pc + 4
        run(pc, code, reg, mem, labels)
      {:bne, label, rs, rt} ->
      case rs == rt do
           true ->
              pc = Program.findLablePc(labels, label)
                run(pc, code, reg, mem, labels)
            false ->
              pc = pc + 4
              run(pc, code, reg, mem, labels)
        end


      end

  end

end