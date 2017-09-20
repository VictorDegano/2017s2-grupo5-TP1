module Laboral
  attr_accessor :diaLaboral

  def setDiaLaboral
    @diaLaboral = true
    self
  end

  def setFeriado
    @diaLaboral = false
    self
  end

  def esDiaLaboral
    @diaLaboral
  end

end