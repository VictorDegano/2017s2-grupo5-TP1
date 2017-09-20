require_relative 'Parcela'

class Construccion

  attr_accessor :simiento, :antiguedad, :kwProducidos, :kwConsumidos , :alimentosProducido

  def initialize(unaParcela, unaAntiguedad)
    @simiento         = unaParcela
    @antiguedad       = unaAntiguedad
    @kwProducidos     = 0
    @kwConsumidos     = 0
    @alimentosProducido= 0
  end

  def posisionDeConstruccion
    @simiento.coordenadasDePosicion
  end

end