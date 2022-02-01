defmodule Out do

  def new() do
   []
  end

  def put(list, add) do
    [add | list]
  end
  def close(list) do
         IO.inspect(list)
  end

end
