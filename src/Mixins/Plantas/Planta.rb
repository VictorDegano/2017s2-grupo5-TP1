module Planta
  attr_accessor :empleados

  def cantidadDeEmpleados
    @empleados
  end

  def generarEnergia(unaCondicion)
    @kwProducidos = producirEnergia(unaCondicion).round(1) * produccionSegunTipoDePropiedad(unaCondicion)
  end

  def energiaGenerada
    @kwProducidos
  end

#Simulacion
  def simularDia(unaCondicion)
    self.generarEnergia(unaCondicion)
  end

#Getters & Setters
  def setEmpleados(unaCantidad)
    @empleados = unaCantidad
    self
  end
end

