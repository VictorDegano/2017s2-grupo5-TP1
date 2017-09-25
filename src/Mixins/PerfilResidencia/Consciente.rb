module Consciente
  attr_accessor :cota

  def consumoSegunPerfilDeConsumo(unConsumoBase)
    (@cota > unConsumoBase) ? unConsumoBase : @cota
  end

#Getters & Setters
  def setCotaDeConsumo(unaCota)
    @cota = unaCota
    self
  end
end