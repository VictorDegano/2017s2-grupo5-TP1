module Residencia
  attr_accessor :miembros

  def consumoTotalDeEnergia(condicionClima)
    consumoPorDefecto = self.cantidadMiembros * condicionClima.consumoPorPersonaPorEstacion
    @kwConsumidos = consumoSegunPerfilDeConsumo(consumoPorDefecto)
  end

  def consumoSegunPerfilDeConsumo(unConsumoBase)
    unConsumoBase
  end

#Simulacion
  def simularDia(unaCondicion)
    self.consumoTotalDeEnergia(unaCondicion)
  end

#Getters & Satters
  def setCantidadDeMiembrosDeResidencia(unaCantidad)
    @miembros = unaCantidad
    self
  end

  def cantidadMiembros
    @miembros
  end
end
