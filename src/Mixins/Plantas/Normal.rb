
module Normal

  attr_accessor :kwHoraEmpleado

  def producirEnergia(unaCondicion)
    kwPorHora * 24
  end

  def setKwHoraEmpleado(unaCantidadGenerada)
    @kwHoraEmpleado = unaCantidadGenerada
    self
  end

  def kwPorHora
    @empleados * @kwHoraEmpleado
  end

end