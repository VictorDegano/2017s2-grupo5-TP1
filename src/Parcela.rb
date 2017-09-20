require_relative '../src/Ciudad'

class Parcela

  attr_accessor :coordX, :coordY,:altura, :ciudad

  def initialize x, y, altura
    @coordX = x
    @coordY = y
    @altura = altura
  end

  def setCiudad(unaCiudad)
    @ciudad = unaCiudad
  end

  def coordenadasDePosicion
    [@coordX,@coordY]
  end

  def altura
    [0, @altura].max
  end

  def maximaDiferenciaDeAlturaConParcelasVecinas
    @ciudad.celdasVecinasA(@coordX,@coordY).collect{|n| (n.altura - self.altura).abs}.max
  end


end