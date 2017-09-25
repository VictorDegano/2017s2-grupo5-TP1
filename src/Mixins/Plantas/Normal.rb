
module Normal

  attr_accessor :kwHoraEmpleado

  def producirEnergia(unaCondicion)
    kwPorHora * 24
  end

  def kwPorHora
    @empleados * @kwHoraEmpleado
  end

 #Setter
  def setKwHoraEmpleado(unaCantidadGenerada)
    @kwHoraEmpleado = unaCantidadGenerada
    self
  end

end