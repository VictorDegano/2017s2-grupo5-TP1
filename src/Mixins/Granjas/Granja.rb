module Granja

  attr_accessor :gradoAutomatizacion

#Produccion de Alimentos
  def generarAlimentos(unaCondicion)
    @alimentosProducido  = producirAlimentos(unaCondicion)
  end

  def factorDeAutomatizacion()
    (100 - @gradoAutomatizacion) / 100.0
  end

#Generacion de Energia
  def generarEnergia(unaCondicion)
    @kwProducidos = producirEnergia (unaCondicion)
  end

  def producirEnergia(unaCondicion)
    0
  end

#Consumo de Energia
  def consumoSegunPerfilDeConsumo(unConsumoBase)
    self.consumoBase
  end

  def consumoTotalDeEnergia(unaCondicion)
    @kwConsumidos = (consumoSegunPerfilDeConsumo(consumoBase) * factorDeAutomatizacion).round(1)
  end

#Simulacion
  def simularDia(unaCondicion)
    self.generarAlimentos(unaCondicion)
    self.generarEnergia(unaCondicion)
    self.consumoTotalDeEnergia(unaCondicion)
  end

#Setters & Getters
  def setGradoDeAutomatizacion(unGradoDeAutomatizacion)
    @gradoAutomatizacion = unGradoDeAutomatizacion
    self
  end

end