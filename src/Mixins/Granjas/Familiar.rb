
module Familiar

  attr_accessor :produccionBase

  def producirAlimentos(unaCondicion)
    @alimentosProducido = unaCondicion.pBFijoDeTemporada * @produccionBase
  end

  def setProduccionBase(unaProduccionBase)
    @produccionBase  = unaProduccionBase
    self
  end

  def consumoBase
    1 - Math.log(1.0/@produccionBase)
  end


end