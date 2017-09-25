module Laboral
  attr_accessor :diaLaboral

  def esDiaLaboral
    @diaLaboral
  end

#Getters & Setters
  def setDiaLaboral
    @diaLaboral = true
    self
  end

  def setFeriado
    @diaLaboral = false
    self
  end
end