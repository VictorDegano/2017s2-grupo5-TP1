
module Holding

  attr_accessor :consumoPorDefecto

  def producirAlimentos(unaCondicion)
    @alimentosProducido = 6.0 * unaCondicion.precioCommodities / 100 * @gradoAutomatizacion
  end

  def setConsumoFijo(unConsumoFijo)
    @consumoPorDefecto  = unConsumoFijo
    self
  end

  def consumoBase
    @consumoPorDefecto
  end

end