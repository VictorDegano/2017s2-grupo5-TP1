class CondicionDeSimulacion

  attr_accessor :precioCommodities, :precioKWMundial

  def initialize(unPrecioCommodities)
    @precioCommodities = unPrecioCommodities
  end

  def setPrecioKWMundial(unPrecio)
    @precioKWMundial = unPrecio
    self
  end

  def precioKWMundial
    @precioKWMundial
  end

end