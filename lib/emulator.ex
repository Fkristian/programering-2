defmodule Emulator do
  def run(prgm) do
    {code, data, labels} = Program.load(prgm)
    reg = Register.new()
    out = Out.new()
    run(0, code, reg, data,labels, out)
  end

  def run(pc, code, reg, mem, labels, out) do
    next = Program.read_instruction(code, pc)
    case next do
      :halt ->

        IO.write("\n Program done \n")
        Out.close(out)
        :ok
      {:add, rd, rs, rt} ->
        s = Register.readR(reg, rs)
        t = Register.readR(reg, rt)
        reg = Register.write(reg, rd, s + t)

        pc = pc + 4
        run(pc, code, reg, mem, labels, out)
      {:addi, rd, rs, t} ->
        s = Register.readR(reg, rs)
        reg = Register.write(reg, rd, s + t)

        pc = pc + 4
        run(pc, code, reg, mem, labels, out)
      {:sub, rd, rt, rs} ->
        s = Register.readR(reg, rs)
        t = Register.readR(reg, rt)
        reg = Register.write(reg, rd, t - s)

        pc = pc + 4
        run(pc, code, reg, mem, labels, out)
      {:lw, saveAdress, offset, adress} ->
        value = Program.readM(mem, adress, offset)

        reg = Register.write(reg, saveAdress, value)


        pc = pc + 4
        run(pc, code, reg, mem, labels, out)
      {:sw, registerAdress, offset, saveAdress} ->
        value = Register.readR(reg, registerAdress)
        mem = Program.write(mem, offset ,saveAdress, value)
        pc = pc + 4
        run(pc, code, reg, mem, labels, out)
      {:out, registerAdress} ->
        value = Register.readR(reg, registerAdress)
        out = Out.put(out, value)
        pc = pc + 4
        run(pc, code, reg, mem, labels, out)
      {:bne, rs, rt, label} ->
        s = Register.readR(reg, rs)
        t = Register.readR(reg, rt)
        case s == t do
          false ->
            pc = Program.findLablePc(labels, label)
            run(pc, code, reg, mem, labels, out)
          true ->
            pc = pc + 4
            run(pc, code, reg, mem, labels, out)
        end
    end
  end



end