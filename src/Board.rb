
class Board

  def initialize width, height
    @width = width
    @height = height
  end

  def find_neighboring x, y
    xrange = neighboring_area(x, @width)
    yrange = neighboring_area(y, @height)

    xrange.product(yrange) - [[x, y]]
  end

  def neighboring_area coord, bound
    ([0, coord - 1].max .. [coord + 1, bound - 1].min).to_a
  end

end
