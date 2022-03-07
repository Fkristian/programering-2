defmodule Mandel do
  def mandelbrot(width, height,x,y,k,depth) do
    trans =fn(w,h) ->
        Cmplx.new(x + k * (w - 1), y - k *(h - 1))
    end
    rows(width, height, trans, depth, [])

  end
  def rows(_,0,_,_,l) do
  l
  end
  def rows(w,h,t,d,l) do
    l = [rowsWidth(w,h,t,d,[]) | l]
    rows(w,h-1,t,d,l)
  end




  def rowsWidth(1,_,_,_,l) do l end
  def rowsWidth(w,h,t,d,l) do

    complexNumber = t.(w, h)
    depth = Brot.mandelbrot(complexNumber, d)
    color = Color.convert(depth, d)
    l = [color | l]
    rowsWidth(w - 1, h, t, d, l)
  end


  def demo() do
    small(-2.6, 1.2, 1.2)
  end
  def small(x0, y0, xn) do
    width = 960
    height = 540
    depth = 64
    k = (xn - x0) / width
    image = mandelbrot(width, height, x0, y0, k, depth)

    PPM.write("small.ppm", image)
  end

end
