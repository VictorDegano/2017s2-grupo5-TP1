module Privada
  attr_accessor :precioKwMundial

  def verificarPropiedad(unaCondicion)
    unaCondicion.precioKWMundial > 10 ? 1 : 0
  end

end