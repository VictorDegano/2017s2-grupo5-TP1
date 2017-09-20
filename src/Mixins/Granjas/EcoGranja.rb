
module EcoGranja

  attr_accessor :produccionBaseFija

  def producirAlimentos(unaCondicion)
    @alimentosProducido = (!unaCondicion.esInvierno && (unaCondicion.ratioDeNubosidad < 0.3)) ? @produccionBaseFija : 0
  end

  def setProduccionBaseFija(unaProduccionBaseFija)
    @produccionBaseFija = unaProduccionBaseFija
    self
  end

  def consumoTotalDeEnergia
    0
  end

end