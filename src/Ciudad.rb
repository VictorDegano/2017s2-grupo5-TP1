require_relative 'Board'
require_relative 'parcela'

class Ciudad

  def initialize(largo, alto)
    @longuitud      = largo
    @altura         = alto
    @tablero        = Board.new largo, alto
    @parcelas       = []
    @construcciones = []
  end

  def posicionesCeldasVecinasDe(parcelaCoordX,parcelaCoordY)
    @tablero.find_neighboring parcelaCoordX, parcelaCoordY
  end

  def celdasVecinasA(parcelaCoordX, parcelaCoordY)
    celdas = self.posicionesCeldasVecinasDe(parcelaCoordX, parcelaCoordY)
    @parcelas.select{|n| celdas.include?(n.coordenadasDePosicion)}
  end

  def agregarParcela(unaParcela)
    unaParcela.setCiudad(self)
    @parcelas<<unaParcela
    self
  end

  def agregarConstruccion(unaConstruccion)
    @construcciones<<unaConstruccion
    self
  end

  def kwProducidos
    @construcciones.map{ |c| c.kwProducidos}.sum
  end

  def kwConsumidos
    @construcciones.map{ |c| c.kwConsumidos}.sum
  end

  def balanceEnergetico
    (self.kwProducidos - self.kwConsumidos).round(1)
  end

  def alimentosProducidos
    @construcciones.map{ |c| c.alimentosProducido}.sum
  end

  def simulacionDeUnDia(unaCondicion)
    @construcciones.each{ |c| c.simularDia(unaCondicion)}
  end

end
