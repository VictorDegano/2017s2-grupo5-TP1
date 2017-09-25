
module Holding

  attr_accessor :consumoPorDefecto

#Produccion de Alimentos
  def producirAlimentos(unaCondicion)
    6.0 * unaCondicion.precioCommodities / 100 * @gradoAutomatizacion
  end

#Consumo de energia
  def consumoBase
    @consumoPorDefecto
  end

#Getters & Setters
  def setConsumoFijo(unConsumoFijo)
    @consumoPorDefecto  = unConsumoFijo
    self
  end

end