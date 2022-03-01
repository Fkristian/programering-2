defmodule Tree do
  def tree_new() do :nil  end



  def tree_insert(e, :nil) do {:node, e, 1, :nil, :nil} end
  def tree_insert(e, {:node, e, amount, l, r})do
    {:node, e, amount + 1, l, r}
  end
  def tree_insert(e, {:node, x, amount, l, r}) do
    cond do
      e < x -> cond do
                 l == :nil -> {:node, x, amount,{:node, e, 1, :nil, :nil}, r}
                 true -> {:node, x, amount,tree_insert(e, l), r}
               end
      true -> cond do
                r == :nil -> {:node, x, amount, l, {:node, e, 1, :nil, :nil}}
                true -> {:node, x, amount,l, tree_insert(e, r)}
              end
    end
  end


  def tree_insert_amount_sorted({e, amount}, :nil) do {:node, e, amount, :nil, :nil} end
  def tree_insert_amount_sorted({e, eAmount}, {:node, x, xAmount, l, r}) do
    cond do
      eAmount < xAmount -> cond do
                             l == :nil -> {:node, x, xAmount,{:node, e, eAmount, :nil, :nil}, r}
                             true -> {:node, x, xAmount,tree_insert_amount_sorted({e, eAmount}, l), r}
                           end
      true -> cond do
                r == :nil -> {:node, x, xAmount, l, {:node, e, eAmount, :nil, :nil}}
                true -> {:node, x, xAmount,l, tree_insert_amount_sorted({e, eAmount}, r)}
              end
    end
  end

  def tree_find_amount(e, {:node, x, xAmount, l, r}) do
    cond do
      e < xAmount -> tree_find_amount(e, l)
      e > xAmount -> tree_find_amount(e, r)
      true -> x
    end
  end

end
