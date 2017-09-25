module Publica

  def produccionSegunTipoDePropiedad(unaCondicion)
    unaCondicion.esDiaLaboral() ? 1 : 0.5
  end

end