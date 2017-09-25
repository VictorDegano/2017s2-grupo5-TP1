
module EcoGranja

  attr_accessor :produccionBase

#Produccion de Alimentos
  def producirAlimentos(unaCondicion)
    (!unaCondicion.esInvierno && (unaCondicion.ratioDeNubosidad < 0.3)) ? @produccionBase : 0
  end

#Consumo de energia
  def consumoBase
    0
  end

#Getters & Setters
  def setProduccionBase(unaProduccionBase)
    @produccionBase = unaProduccionBase
    self
  end

end