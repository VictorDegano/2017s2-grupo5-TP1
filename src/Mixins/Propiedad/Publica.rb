module Publica
  attr_accessor :feriado

  def verificarPropiedad(unaCondicion)
    self.verificarDiaLaboral(unaCondicion)
    @condicionDia ? 1 : 0.5
  end

  def verificarDiaLaboral(unaCondicion)
    @condicionDia = unaCondicion.esDiaLaboral()
  end

end