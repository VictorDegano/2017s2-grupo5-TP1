module Derrochador

  attr_accessor :consumoExtra

  def consumoSegunPerfilDeConsumo(unConsumoBase)
    @consumoExtra * unConsumoBase
  end

#Getters & Setters
  def setConsumoExtra(unaCantidad)
    @consumoExtra = unaCantidad
    self
  end
end