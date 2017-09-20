module Solar

  attr_accessor :kwPorHoraIdeal

  def producirEnergia(unaCondicion)
    (efectividadDeProduccionPorNubosidad(unaCondicion) * kwPorHoraIdeal * unaCondicion.horasDeSol * factorDeAltura).round(1)
  end

  def setKwPorHoraIdeal(unKwPorHoraIdeal)
    @kwPorHoraIdeal = unKwPorHoraIdeal
    self
  end

  def kwPorHoraIdeal
    @kwPorHoraIdeal
  end

  def factorDeAltura
    resultado = @simiento.altura * 3.0 / 5000
    (resultado==0.0) ? 0.1 : resultado
  end

  def efectividadDeProduccionPorNubosidad(unaCondicion)
    1.0 - unaCondicion.ratioDeNubosidad()
  end

end