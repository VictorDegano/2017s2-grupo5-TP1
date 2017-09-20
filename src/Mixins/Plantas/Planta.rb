module Planta
  attr_accessor :empleados

  def cantidadDeEmpleados
    @empleados
  end

  def generarEnergia(unaCondicion)
    @kwProducidos = producirEnergia(unaCondicion).round(1) * verificarPropiedad(unaCondicion)
  end

  def setEmpleados(unaCantidad)
    @empleados = unaCantidad
    self
  end

  def energiaGenerada
    @kwProducidos
  end

end
