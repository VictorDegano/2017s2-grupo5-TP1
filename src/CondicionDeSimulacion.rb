class CondicionDeSimulacion

  attr_accessor :precioCommodities, :precioMundialKW

  def initialize(unPrecioCommodities)
    @precioCommodities = unPrecioCommodities
  end

  def setPrecioMundialKW(unPrecio)
    @precioMundialKW = unPrecio
    self
  end

  def precioKWMundial
    @precioMundialKW
  end

end