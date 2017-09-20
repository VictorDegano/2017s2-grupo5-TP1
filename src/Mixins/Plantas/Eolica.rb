module Eolica

  def producirEnergia(unaCondicion)
    (unaCondicion.velocidadViento * 3 * factorViento).round(1)
  end

  def factorViento
    resultado = @simiento.maximaDiferenciaDeAlturaConParcelasVecinas / 1000.0
    resultado == 0.0 ? 0.1 : resultado
  end

end