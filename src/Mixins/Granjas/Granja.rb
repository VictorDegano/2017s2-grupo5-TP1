module Granja

  attr_accessor :productoBruto, :gradoAutomatizacion

  def generarAlimentos(unaCondicion)
    @productoBruto  = producirAlimentos(unaCondicion)
  end

  def setGradoDeAutomatizacion(unGradoDeAutomatizacion)
    @gradoAutomatizacion = unGradoDeAutomatizacion
    self
  end

  def factorDeAutomatizacion()
    (100 - @gradoAutomatizacion) / 100.0
  end

  def productoBrutoProducido()
    @productoBruto
  end

  def generarEnergia(unaCondicion)
    @kwProducidos = producirEnergia (unaCondicion)
  end

  def producirEnergia(unaCondicion)
    0
  end

  def aplicarConsumoDePerfil(unConsumoBase)
    self.consumoBase
  end

  def consumoTotalDeEnergia
    @kwConsumidos = (aplicarConsumoDePerfil(consumoBase) * factorDeAutomatizacion).round(1)
  end

end