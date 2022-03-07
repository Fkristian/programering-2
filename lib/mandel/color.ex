defmodule Color do
  def convert(depth, max)do
  f = depth/max
  a= f*4
  x = trunc(a)
  y = trunc(255 *(a - x))

  {:rgb, 0, 255 - y, 255}
  end
end



