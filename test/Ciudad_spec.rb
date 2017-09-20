require 'rspec'
require_relative '../src/Ciudad'
require_relative '../src/Board'
require_relative '../src/Parcela'
require_relative '../src/Construccion'
require_relative '../src/CondicionDeSimulacion'
require_relative '../src/Mixins/CondicionDeSimulacion/Estaciones/Verano'
require_relative '../src/Mixins/CondicionDeSimulacion/Estaciones/OtoñoPrimavera.rb'
require_relative '../src/Mixins/CondicionDeSimulacion/Estaciones/Invierno'
require_relative '../src/Mixins/CondicionDeSimulacion/Climatica'
require_relative '../src/Mixins/Granjas/Granja'
require_relative '../src/Mixins/Granjas/Familiar'
require_relative '../src/Mixins/Granjas/Holding'
require_relative '../src/Mixins/Granjas/EcoGranja'
require_relative '../src/Mixins/PerfilResidencia/Derrochador'
require_relative '../src/Mixins/PerfilResidencia/Consciente'
require_relative '../src/Mixins/Plantas/Planta'
require_relative '../src/Mixins/Plantas/Eolica'
require_relative '../src/Mixins/Plantas/Solar'
require_relative '../src/Mixins/Plantas/Normal'
require_relative '../src/Mixins/Propiedad/Publica'
require_relative '../src/Mixins/Propiedad/Privada'
require_relative '../src/Mixins/Residencia'

describe 'Ciudad' do

  let(:unaCiudad){Ciudad.new 2, 3}
  let(:parcela00){Parcela.new 0, 0, 200}
  let(:parcela01){Parcela.new 0, 1, 1500}
  let(:parcela10){Parcela.new 1, 0, 900}
  let(:parcela11){Parcela.new 1, 1, 0}
  let(:parcela12){Parcela.new 2, 0, 10}
  let(:parcela13){Parcela.new 2, 1, 50}
  it 'should Da las parcelas vecinas de la parcela [0,0]' do
    unaCiudad .agregarParcela(parcela00)
              .agregarParcela(parcela01)
              .agregarParcela(parcela10)
              .agregarParcela(parcela11)
              .agregarParcela(parcela12)
              .agregarParcela(parcela13)

    expect(unaCiudad.celdasVecinasA(0, 0)).to eq([parcela01,parcela10,parcela11])
  end

  let (:condicionDeSimulacion2){CondicionDeSimulacion .new(10)
                                                      .setPrecioMundialKW(11)
                                                      .extend(Climatica)
                                                      .extend(Verano)
                                                      .setNubosidad(0.8)
                                                      .setViento(15)
                                                      .setTemperatura(10)}
  let(:parcela0)    {Parcela.new( 0, 0, 1400)}
  let(:parcela1)    {Parcela.new( 0, 1, 1500)}
  let(:parcela2)    {Parcela.new( 1, 0, 900)}
  let(:parcela3)    {Parcela.new( 1, 1, 0)}
  let(:unaCiudad1)  {Ciudad.new 2, 2}
  let(:planta_Eolica_Privada) {Construccion .new(parcela0,1)
                                            .extend(Planta)
                                            .extend(Eolica)
                                            .setEmpleados(20)
                                            .extend(Privada)}
  let (:residencia_derrochadora) {Construccion.new(parcela1, 0)
                                              .extend(Residencia)
                                              .setCantidadDeMiembrosDeResidencia(4)
                                              .setConsumoPorDefecto(condicionDeSimulacion2)
                                              .extend(Derrochador)
                                              .setConsumoExtra(6)}
  let (:granja_Tipo_Familiar_Consciente_Solar) {Construccion.new(parcela2, 2)
                                                            .extend(Granja)
                                                            .extend(Familiar)
                                                            .extend(Solar)
                                                            .extend(Consciente)
                                                            .setProduccionBase(10)
                                                            .setGradoDeAutomatizacion(30)
                                                            .setKwPorHoraIdeal(4)
                                                            .setCotaDeConsumo(5)}
  let (:granja_Tipo_Holding_Solar_Consciente) {Construccion .new(parcela3, 2)
                                                            .extend(Granja)
                                                            .extend(Holding)
                                                            .extend(Solar)
                                                            .extend(Consciente)
                                                            .setConsumoFijo(8)
                                                            .setGradoDeAutomatizacion(30)
                                                            .setKwPorHoraIdeal(3)
                                                            .setCotaDeConsumo(9)}

  it ' ' do
    unaCiudad1.agregarParcela(parcela0).agregarParcela(parcela1)
              .agregarParcela(parcela2).agregarParcela(parcela3)
    unaCiudad1.agregarConstruccion(planta_Eolica_Privada)
              .agregarConstruccion(residencia_derrochadora)
              .agregarConstruccion(granja_Tipo_Familiar_Consciente_Solar)
              .agregarConstruccion(granja_Tipo_Holding_Solar_Consciente)

    expect(planta_Eolica_Privada.generarEnergia(condicionDeSimulacion2)).to eq(63)
    expect(residencia_derrochadora.consumoTotalDeEnergia).to eq(48)
    expect(granja_Tipo_Familiar_Consciente_Solar.generarAlimentos(condicionDeSimulacion2)).to eq(50)
    expect(granja_Tipo_Familiar_Consciente_Solar.generarEnergia(condicionDeSimulacion2)).to eq(5.6)
    expect(granja_Tipo_Familiar_Consciente_Solar.consumoTotalDeEnergia).to eq(2.3)
    expect(granja_Tipo_Holding_Solar_Consciente.generarAlimentos(condicionDeSimulacion2)).to eq(18)
    expect(granja_Tipo_Holding_Solar_Consciente.generarEnergia(condicionDeSimulacion2)).to eq(0.8)
    expect(granja_Tipo_Holding_Solar_Consciente.consumoTotalDeEnergia).to eq(5.6)

    expect(unaCiudad1.kwProducidos).to eq(69.4)
    expect(unaCiudad1.kwConsumidos).to eq(55.9)
    expect(unaCiudad1.balanceEnergetico).to eq(13.5)
  end


end