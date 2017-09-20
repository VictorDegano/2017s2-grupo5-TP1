require 'rspec'
require_relative '../src/Ciudad'
require_relative '../src/Construccion'
require_relative '../src/Parcela'
require_relative '../src/Mixins/Plantas/Planta'
require_relative '../src/Mixins/Plantas/Normal'
require_relative '../src/Mixins/Plantas/Solar'
require_relative '../src/Mixins/Plantas/Eolica'
require_relative '../src/CondicionDeSimulacion'
require_relative '../src/Mixins/CondicionDeSimulacion/Climatica'
require_relative '../src/Mixins/CondicionDeSimulacion/Estaciones/OtoñoPrimavera'
require_relative '../src/Mixins/CondicionDeSimulacion/Estaciones/Invierno'
require_relative '../src/Mixins/CondicionDeSimulacion/Estaciones/Verano'
require_relative '../src/Mixins/Granjas/Granja'
require_relative '../src/Mixins/Granjas/Holding'
require_relative '../src/Mixins/Granjas/Familiar'
require_relative '../src/Mixins/Granjas/EcoGranja'
require_relative '../src/Mixins/Plantas/Eolica'
require_relative '../src/Mixins/Plantas/Solar'
require_relative '../src/Mixins/PerfilResidencia/Derrochador'
require_relative '../src/Mixins/PerfilResidencia/Consciente'
require_relative '../src/Mixins/Propiedad/Publica'
require_relative '../src/Mixins/Propiedad/Privada'
require_relative '../src/Mixins/Laboral'
require_relative '../src/Mixins/Residencia'

describe 'Simulacion Dia Laboral Verano' do
  let (:unaCondicionDeSimulacion) {CondicionDeSimulacion.new(10)
                                       .setPrecioMundialKW(14)
                                       .extend(Climatica)
                                       .extend(Verano)
                                       .setNubosidad(0.1)
                                       .setViento(6)
                                       .setTemperatura(10)
                                       .extend(Laboral)
                                       .setDiaLaboral}
  let (:parcela_1) {Parcela.new 0, 0, 1000}
  let (:unaConstruccion_Planta_Solar_Privada) {Construccion.new(parcela_1,1)
                                                                   .extend(Privada)
                                                                   .extend(Planta)
                                                                   .extend(Solar)
                                                                   .setEmpleados(20)
                                                                   .setKwPorHoraIdeal(10)}
  let (:parcela_2) {Parcela.new 1, 0, 1500}
  let (:parcela_3) {Parcela.new 2, 0, 1500}
  let (:parcela_4) {Parcela.new 3, 0, 1500}

  let (:parcela_5){Parcela.new 4, 0, 1500}
  let (:planta_Eolica_Privada_1) {Construccion .new(parcela_5,1)
                                      .extend(Privada)
                                      .extend(Planta)
                                      .setEmpleados(20)
                                      .extend(Eolica)}

  let (:parcela_6){Parcela.new 0, 1, 1500}

  let (:hogarConsciente_1) {Construccion.new(parcela_6, 0)
                                                              .extend(Residencia)
                                                              .setCantidadDeMiembrosDeResidencia(4)
                                                              .setConsumoPorDefecto(unaCondicionDeSimulacion)
                                                              .extend(Consciente)
                                                              .setCotaDeConsumo(9)}

  let (:parcela_7){Parcela.new 1, 1, 1500}
  let (:hogarConsciente_2) {Construccion.new(parcela_7, 0)
                                                .extend(Residencia)
                                                .setCantidadDeMiembrosDeResidencia(6)
                                                .setConsumoPorDefecto(unaCondicionDeSimulacion)
                                                .extend(Consciente)
                                                .setCotaDeConsumo(20)}

  let (:parcela_8){Parcela.new 2, 1, 1500}
  let (:hogarConsciente_3) {Construccion.new(parcela_8, 0)
                                .extend(Residencia)
                                .setCantidadDeMiembrosDeResidencia(2)
                                .setConsumoPorDefecto(unaCondicionDeSimulacion)
                                .extend(Consciente)
                                .setCotaDeConsumo(10)}

  let (:parcela_9) {Parcela.new 3, 1, 1200}
  let( :granja_Holding_Eolica) {Construccion .new(parcela_9, 2)
                                    .extend(Granja)
                                    .extend(Holding)
                                    .extend(Eolica)
                                    .setGradoDeAutomatizacion(30)}

  let (:parcela_10) {Parcela.new 4, 1, 1200}
  let (:planta_Normal_Privada_1) {Construccion .new(parcela_10,0)
                                      .extend(Privada)
                                      .extend(Planta)
                                      .extend(Normal)
                                      .setEmpleados(8)
                                      .setKwHoraEmpleado(2)}

  let (:parcela_11) {Parcela.new 0, 2, 1200}
  let (:hogarDerrochador_1) {Construccion.new(parcela_11, 0)
                                                      .extend(Residencia)
                                                      .setCantidadDeMiembrosDeResidencia(4)
                                                      .setConsumoPorDefecto(unaCondicionDeSimulacion)
                                                      .extend(Derrochador)
                                                      .setConsumoExtra(6)}

  let (:parcela_12) {Parcela.new 1, 2, 1200}
  let (:hogarDerrochador_2) {Construccion.new(parcela_12, 0)
                                 .extend(Residencia)
                                 .setCantidadDeMiembrosDeResidencia(8)
                                 .setConsumoPorDefecto(unaCondicionDeSimulacion)
                                 .extend(Derrochador)
                                 .setConsumoExtra(3)}

  let (:parcela_13){Parcela.new 2, 2, 1200}
  let (:hogarDerrochador_3) {Construccion.new(parcela_13, 0)
                                 .extend(Residencia)
                                 .setCantidadDeMiembrosDeResidencia(2)
                                 .setConsumoPorDefecto(unaCondicionDeSimulacion)
                                 .extend(Derrochador)
                                 .setConsumoExtra(16)}

  let (:parcela_14){Parcela.new 3, 2, 1200}

  let (:parcela_15){Parcela.new 4, 2, 1200}
  let (:hogarDerrochador_4) {Construccion.new(parcela_15, 0)
                                 .extend(Residencia)
                                 .setCantidadDeMiembrosDeResidencia(5)
                                 .setConsumoPorDefecto(unaCondicionDeSimulacion)
                                 .extend(Derrochador)
                                 .setConsumoExtra(6)}


  let (:parcela_16){Parcela.new 0, 3, 1200}
  let (:ecogranja_1) {Construccion .new(parcela_16, 1)
                                   .extend(Granja)
                                   .extend(EcoGranja).setProduccionBaseFija(5)}

  let (:parcela_17) {Parcela.new 1, 3, 1000}

  let (:parcela_18) {Parcela.new 2, 3, 1000}
  let (:planta_Eolica_Publica_1) {Construccion .new(parcela_18 ,1)
                                      .extend(Publica)
                                      .extend(Planta)
                                      .setEmpleados(20)
                                      .extend(Eolica)}

  let (:parcela_19) {Parcela.new 3, 3, 1000}
  let (:hogarConsciente_4) {Construccion.new(parcela_19, 0)
                                .extend(Residencia)
                                .setCantidadDeMiembrosDeResidencia(8)
                                .setConsumoPorDefecto(unaCondicionDeSimulacion)
                                .extend(Consciente)
                                .setCotaDeConsumo(15)}

  let (:parcela_20) {Parcela.new 4, 3, 1000}
  let (:planta_Solar_Publica_1) {Construccion.new(parcela_20, 1)
                                     .extend(Publica)
                                     .extend(Planta)
                                     .extend(Solar)
                                     .setEmpleados(20)
                                     .setKwPorHoraIdeal(10)}

  let (:parcela_21){Parcela.new 0, 4, 1000}
  let (:holding_Solar_1) {Construccion .new(parcela_21, 2)
                                       .extend(Granja)
                                       .extend(Holding)
                                       .extend(Solar)
                                       .setGradoDeAutomatizacion(30)
                                       .setKwPorHoraIdeal(3)}

  let (:parcela_22){Parcela.new 1, 4, 1000}

  let (:parcela_23){Parcela.new 2, 4, 1000}
  let(:granja_Familiar_Consciente_1) {Construccion.new(parcela_23, 1)
                                          .extend(Granja)
                                          .extend(Familiar)
                                          .extend(Consciente)
                                          .setProduccionBase(5)
                                          .setGradoDeAutomatizacion(30)
                                          .setCotaDeConsumo(5)}

  let (:parcela_24){Parcela.new 3, 4, 1000}

  let (:parcela_25) {Parcela.new 4, 4, 830}
  let (:hogarDerrochador_5) {Construccion.new(parcela_25, 0)
                                 .extend(Residencia)
                                 .setCantidadDeMiembrosDeResidencia(4)
                                 .setConsumoPorDefecto(unaCondicionDeSimulacion)
                                 .extend(Derrochador)
                                 .setConsumoExtra(2)}





  let(:ciudad) {Ciudad.new(5, 5)}
  it'Se verifica que cada construccion genere energia, consuma energia y/o produsca alimento segun la condicion'do
    ciudad.agregarParcela(parcela_1).agregarParcela(parcela_2).agregarParcela(parcela_3)
          .agregarParcela(parcela_4).agregarParcela(parcela_5).agregarParcela(parcela_6)
          .agregarParcela(parcela_7).agregarParcela(parcela_8).agregarParcela(parcela_9)
          .agregarParcela(parcela_10).agregarParcela(parcela_11).agregarParcela(parcela_12)
          .agregarParcela(parcela_13).agregarParcela(parcela_14).agregarParcela(parcela_15)
          .agregarParcela(parcela_16).agregarParcela(parcela_17).agregarParcela(parcela_18)
          .agregarParcela(parcela_19).agregarParcela(parcela_20).agregarParcela(parcela_21)
          .agregarParcela(parcela_22).agregarParcela(parcela_23).agregarParcela(parcela_24)
          .agregarParcela(parcela_25)

    unaConstruccion_Planta_Solar_Privada.generarEnergia(unaCondicionDeSimulacion)
    expect(unaConstruccion_Planta_Solar_Privada.energiaGenerada()).to eq(70.2)

    expect(hogarConsciente_1.consumoTotalDeEnergia()).to eq(8)
    expect(hogarConsciente_2.consumoTotalDeEnergia()).to eq(12)
    expect(hogarConsciente_3.consumoTotalDeEnergia()).to eq(4)
    expect(hogarConsciente_4.consumoTotalDeEnergia()).to eq(15)

    expect(hogarDerrochador_1.consumoTotalDeEnergia()).to eq(48)
    expect(hogarDerrochador_2.consumoTotalDeEnergia()).to eq(48)
    expect(hogarDerrochador_3.consumoTotalDeEnergia()).to eq(64)
    expect(hogarDerrochador_4.consumoTotalDeEnergia()).to eq(60)
    expect(hogarDerrochador_5.consumoTotalDeEnergia()).to eq(16)

    planta_Eolica_Privada_1.generarEnergia(unaCondicionDeSimulacion)
    expect(planta_Eolica_Privada_1.energiaGenerada()).to eq(5.4)

    planta_Normal_Privada_1.generarEnergia(unaCondicionDeSimulacion)
    expect(planta_Normal_Privada_1.energiaGenerada()).to eq(384)

    expect(granja_Holding_Eolica.producirEnergia(unaCondicionDeSimulacion)).to eq(5.4)

    planta_Solar_Publica_1.generarEnergia(unaCondicionDeSimulacion)
    expect(planta_Solar_Publica_1.energiaGenerada).to eq(70.2)

    planta_Eolica_Publica_1.generarEnergia(unaCondicionDeSimulacion)
    expect(planta_Eolica_Publica_1.energiaGenerada()).to eq(3.6)

    ecogranja_1.generarAlimentos(unaCondicionDeSimulacion)
    expect(ecogranja_1.productoBrutoProducido()).to eq(5)

    expect(holding_Solar_1.producirEnergia(unaCondicionDeSimulacion)).to eq(21.1)

    expect(granja_Familiar_Consciente_1.consumoTotalDeEnergia()).to eq(1.8)

    unaConstruccion_Planta_Solar_Privada.generarEnergia(unaCondicionDeSimulacion)
  end
end
