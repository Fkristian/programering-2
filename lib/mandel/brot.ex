defmodule Brot do
  def mandelbrot({r, i}, m) do
    z0 = Cmplx.new(r, i)
    i = 0
    test(i, {0,0}, z0 ,m)
  end
  def test(_, _ , _, 0) do
  0
  end

  def test(i, zn , c, m) do
  cond do
      Cmplx.abs(zn) > 2 -> i
      true -> test(i+1, Cmplx.add(Cmplx.sqr(zn), c), c, m-1)
    end
  end
end
