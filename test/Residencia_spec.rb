require 'rspec'
require_relative '../src/Parcela'
require_relative '../src/Mixins/CondicionDeSimulacion/Climatica'
require_relative '../src/Construccion'
require_relative '../src/CondicionDeSimulacion'
require_relative '../src/Mixins/Residencia'
require_relative '../src/Mixins/CondicionDeSimulacion/Estaciones/Verano'
require_relative '../src/Mixins/CondicionDeSimulacion/Estaciones/Invierno'
require_relative '../src/Mixins/CondicionDeSimulacion/Estaciones/OtoñoPrimavera'
require_relative '../src/Mixins/PerfilResidencia/Consciente'
require_relative '../src/Mixins/PerfilResidencia/Derrochador'

describe 'Residencia' do
  describe 'hogar consciente en verano' do
    let (:condicionDeSimulacion) {CondicionDeSimulacion.new(10).extend(Climatica)
                                                 .extend(Verano)
                                                 .setNubosidad(0)
                                                 .setViento(0)
                                                 .setTemperatura(0)}
    let (:unaParcela) {Parcela.new(0, 0, 1000)}
    let (:hogar_consciente_con_cota_mayor_al_consumo_base) {Construccion.new(unaParcela, 0)
                                                                .extend(Residencia)
                                                                .setCantidadDeMiembrosDeResidencia(4)
                                                                .setConsumoPorDefecto(condicionDeSimulacion)
                                                                .extend(Consciente)
                                                                .setCotaDeConsumo(20)}
    it 'un hogar con 4 miembros con perfil consciente y una cota de 20kw/dia, en verano consumen 8kw por dia' do
      expect(hogar_consciente_con_cota_mayor_al_consumo_base.consumoTotalDeEnergia).to eq(8)
    end

    let (:hogar_consciente_con_cota_menor_al_consumo_base) {Construccion.new(unaParcela, 0)
                                                                .extend(Residencia)
                                                                .setCantidadDeMiembrosDeResidencia(4)
                                                                .setConsumoPorDefecto(condicionDeSimulacion)
                                                                .extend(Consciente)
                                                                .setCotaDeConsumo(6)}
    it 'un hogar con 4 miembros con perfil consciente y una cota de 6kw/dia, en verano consume 6kw/dia' do
      expect(hogar_consciente_con_cota_menor_al_consumo_base.consumoTotalDeEnergia).to eq(6)
    end
  end

  describe 'hogar consciente en primavera y otoño' do
    let (:condicionDeSimulacion) {CondicionDeSimulacion.new(10).extend(Climatica)
                                                        .extend(OtoñoPrimavera)
                                                        .setNubosidad(0.8)
                                                        .setViento(1)
                                                        .setTemperatura(12)}
    let (:unaParcela) {Parcela.new(0, 0, 1200)}
    let (:hogar_consciente_con_cota_mayor_al_consumo_base) {Construccion.new(unaParcela, 0)
                                                                        .extend(Residencia)
                                                                        .setCantidadDeMiembrosDeResidencia(4)
                                                                        .setConsumoPorDefecto(condicionDeSimulacion)
                                                                        .extend(Consciente)
                                                                        .setCotaDeConsumo(20)}

    it 'un hogar con 4 miembros con perfil consciente y una cota de 20kw/dia, en primavera y otoño consume 4kw/dia' do
      expect(hogar_consciente_con_cota_mayor_al_consumo_base.consumoTotalDeEnergia).to eq(4)
    end

    let (:hogar_consciente_con_cota_menor_al_consumo_base) {Construccion.new(unaParcela, 0)
                                                                .extend(Residencia)
                                                                .setCantidadDeMiembrosDeResidencia(4)
                                                                .setConsumoPorDefecto(condicionDeSimulacion)
                                                                .extend(Consciente)
                                                                .setCotaDeConsumo(3.5)}
    it 'un hogar con 4 miembros cn perfil consciente y una cota de 3.5kw/dia en primavera consume 3.5kw/dia' do
      expect(hogar_consciente_con_cota_menor_al_consumo_base.consumoTotalDeEnergia).to eq(3.5)
    end
  end

  describe 'hogar derrochador en verano' do
    let (:condicionDeSimulacion) {CondicionDeSimulacion.new(10).extend(Climatica)
                                      .extend(Verano)
                                      .setNubosidad(0.2)
                                      .setViento(0)
                                      .setTemperatura(20)}
    let (:unaParcela) {Parcela.new(0, 0, 1000)}
    let (:hogar_derrochador) {Construccion.new(unaParcela, 0)
                                  .extend(Residencia)
                                  .setCantidadDeMiembrosDeResidencia(4)
                                  .setConsumoPorDefecto(condicionDeSimulacion)
                                  .extend(Derrochador)
                                  .setConsumoExtra(6)}
    it 'un hogar con 4 miembros con perfil derrochador y un consumo extra de 6kw/dia, en verano consume 48kw/dia' do
      expect(hogar_derrochador.consumoTotalDeEnergia).to eq(48)
    end
  end

  describe 'hogar derrochador en primavera' do
    let (:condicionDeSimulacion) {CondicionDeSimulacion.new(10).extend(Climatica)
                                      .extend(OtoñoPrimavera)
                                      .setNubosidad(0.2)
                                      .setViento(0)
                                      .setTemperatura(20)}
    let (:unaParcela) {Parcela.new(0, 0, 1000)}
    let (:hogar_derrochador) {Construccion.new(unaParcela, 0)
                                  .extend(Residencia)
                                  .setCantidadDeMiembrosDeResidencia(4)
                                  .setConsumoPorDefecto(condicionDeSimulacion)
                                  .extend(Derrochador)
                                  .setConsumoExtra(6)}
    it 'un hogar c.on 4 miembros con perfil derrochador y un consumo extra de 6kw/dia, en primavera consume 24kw/dia' do
      expect(hogar_derrochador.consumoTotalDeEnergia).to eq(24)
    end

  end

end