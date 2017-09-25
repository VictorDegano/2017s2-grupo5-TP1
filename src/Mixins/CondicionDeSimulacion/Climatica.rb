module Climatica
  attr_accessor :nubosidad, :viento, :temperatura

  def vientoBajo
    @viento < 15
  end

  def vientoModerado
    !self.vientoBajo && @viento <= 35
  end

  def vientoFuerte
    @viento > 35
  end

  def velocidadViento
    [0,@viento].max
  end

  def ratioDeNubosidad
    [0.0, [1.0, @nubosidad].min].max
  end

#Getters & Setters
  def setNubosidad unRatioNubosidad
    @nubosidad = unRatioNubosidad
    self
  end

  def setViento unaVelocidadViento
    @viento = unaVelocidadViento
    self
  end

  def setTemperatura unaTemperaturaEnGrados
    @temperatura = unaTemperaturaEnGrados
    self
  end
end
