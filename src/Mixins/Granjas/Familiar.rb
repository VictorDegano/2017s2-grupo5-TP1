
module Familiar

  attr_accessor :produccionBase

#Produccion de Alimentos
  def producirAlimentos(unaCondicion)
    unaCondicion.produccionFijaDeTemporada * @produccionBase
  end

#Consumo de Energia
  def consumoBase
    1 - Math.log(1.0/@produccionBase)
  end

#Getters & Setters
  def setProduccionBase(unaProduccionBase)
    @produccionBase  = unaProduccionBase
    self
  end
end