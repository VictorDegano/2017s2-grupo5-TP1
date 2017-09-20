module Residencia
  attr_accessor :miembros, :consumoPorDefecto

  def setCantidadDeMiembrosDeResidencia(unaCantidad)
    @miembros = unaCantidad
    self
  end

  def cantidadMiembros
    @miembros
  end

  def setConsumoPorDefecto(condicionClima)
    @consumoPorDefecto = self.cantidadMiembros * condicionClima.factorConsumoPorEstacion
    self
  end

  def consumoTotalDeEnergia
    @kwConsumidos = aplicarConsumoDePerfil(@consumoPorDefecto)
  end

end