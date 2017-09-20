module Derrochador

  attr_accessor :consumoExtra

  def setConsumoExtra(unaCantidad)
    @consumoExtra = unaCantidad
    self
  end

  def aplicarConsumoDePerfil(unConsumoBase)
    @consumoExtra * unConsumoBase
  end

end