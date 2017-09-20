module Consciente
  attr_accessor :cota

  def setCotaDeConsumo(unaCota)
    @cota = unaCota
    self
  end

  def aplicarConsumoDePerfil(unConsumoBase)
    (@cota > unConsumoBase) ? unConsumoBase : @cota
  end

end