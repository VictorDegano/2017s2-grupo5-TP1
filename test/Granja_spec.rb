require 'rspec'
require_relative '../src/Ciudad'
require_relative '../src/Construccion'
require_relative '../src/Parcela'
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

describe 'Granjas' do

  describe 'tipo Holding' do

    let(:unaCondicionDeSimulacion){CondicionDeSimulacion.new(10)}
    let(:parcela){Parcela.new(0,0,1500)}
    let(:granja_Tipo_Holding) {Construccion .new(:parcela, 2)
                                            .extend(Granja)
                                            .extend(Holding)
                                            .setGradoDeAutomatizacion(30)
                                            .setConsumoFijo(15)}

    it 'Bajo un precio commodities de 10 y una automatizacion del 30% genera un PB de 18' do
      granja_Tipo_Holding.generarAlimentos(unaCondicionDeSimulacion)
      expect(granja_Tipo_Holding.productoBrutoProducido).to eq(18)
    end

    it 'No genera energia' do
      expect(granja_Tipo_Holding.producirEnergia(unaCondicionDeSimulacion)).to eq(0)
    end

    it 'Con una automatizacion del 30% y un consumo fijo de 15, Consume 10.5kw' do
      expect(granja_Tipo_Holding.consumoTotalDeEnergia).to eq(10.5)
    end

  end

  describe 'tipo Familiar' do

    let(:unaCondicionDeSimulacionVeraniega){CondicionDeSimulacion.new(10).extend(Climatica).extend(Verano)}
    let(:parcela){Parcela.new(0,0,1500)}
    let(:granja_Tipo_Familiar) {Construccion.new(:parcela, 1)
                                            .extend(Granja)
                                            .extend(Familiar)
                                            .setProduccionBase(5)
                                            .setGradoDeAutomatizacion(30)}

    it 'en verano y con una produccion base de 5, genera 25 PB' do
      granja_Tipo_Familiar.generarAlimentos(unaCondicionDeSimulacionVeraniega)
      expect(granja_Tipo_Familiar.productoBrutoProducido).to eq(25)
    end

    let(:unaCondicionDeSimulacionInvernal){CondicionDeSimulacion.new(10).extend(Climatica).extend(Invierno)}
    it 'en invierno genera 10 PB' do
      granja_Tipo_Familiar.generarAlimentos(unaCondicionDeSimulacionInvernal)
      expect(granja_Tipo_Familiar.productoBrutoProducido).to eq(10)
    end

    let(:unaCondicionDeSimulacionOtoPrimaveral){CondicionDeSimulacion.new(10).extend(Climatica).extend(OtoñoPrimavera)}
    it 'en invierno genera 10 PB' do
      granja_Tipo_Familiar.generarAlimentos(unaCondicionDeSimulacionOtoPrimaveral)
      expect(granja_Tipo_Familiar.productoBrutoProducido).to eq(20)
    end

    it 'Con una produccion Base de 2.6 y una automatizacion del 30%, consume 1.8Kw' do
      expect(granja_Tipo_Familiar.consumoTotalDeEnergia).to eq(1.8)
    end

  end

  describe 'tipo EcoGranja' do

    let(:unaCondicionDeSimulacionNubosaInvernal){CondicionDeSimulacion.new(10).extend(Climatica).extend(Invierno).setNubosidad(0.8)}
    let(:parcela){Parcela.new(0,0,1500)}
    let(:granja_Tipo_EcoGranja) {Construccion .new(:parcela, 1.3)
                                   .extend(Granja)
                                   .extend(EcoGranja).setProduccionBaseFija(5)}

    it 'en invierno y con nubosidad al 80% no produce nada' do
      granja_Tipo_EcoGranja.generarAlimentos(unaCondicionDeSimulacionNubosaInvernal)
      expect(granja_Tipo_EcoGranja.productoBrutoProducido).to eq(0)
    end

    let(:unaCondicionDeSimulacionInvernal){CondicionDeSimulacion.new(10).extend(Climatica).extend(Invierno).setNubosidad(0.2)}
    it 'en invierno y con nubosidad menor a 30% no produce nada' do
      granja_Tipo_EcoGranja.generarAlimentos(unaCondicionDeSimulacionInvernal)
      expect(granja_Tipo_EcoGranja.productoBrutoProducido).to eq(0)
    end

    let(:unaCondicionDeSimulacionNubosa){CondicionDeSimulacion.new(10).extend(Climatica).extend(Verano).setNubosidad(0.3)}
    it 'sin ser invierno y con nubosidad mayor o igual a 30% no produce nada' do
      granja_Tipo_EcoGranja.generarAlimentos(unaCondicionDeSimulacionNubosa)
      expect(granja_Tipo_EcoGranja.productoBrutoProducido).to eq(0)
    end

    let(:unaCondicionDeSimulacionPrometedora){CondicionDeSimulacion.new(10).extend(Climatica).extend(Verano).setNubosidad(0.2)}
    it 'Con una produccion fija de 5 y sin ser invierno y con nubosidad menor a 30% produce 5' do
      granja_Tipo_EcoGranja.generarAlimentos(unaCondicionDeSimulacionPrometedora)
      expect(granja_Tipo_EcoGranja.productoBrutoProducido).to eq(5)
    end

  end

  describe 'tipo Holding con Generacion De Energia Eolica' do

    let (:condicionDeSimulacion){CondicionDeSimulacion .new(10)
                                                .extend(Climatica)
                                                .extend(Verano)
                                                .setNubosidad(0.8)
                                                .setViento(15)
                                                .setTemperatura(10)}
    let (:parcela)      {Parcela.new(0,0,1500)}
    let (:unaParcela1)  {Parcela.new(0, 1, 1000)}
    let (:unaParcela2)  {Parcela.new(1, 0, 1200)}
    let (:unaParcela3)  {Parcela.new(1, 1, 100)}
    let (:unaCiudad)    {Ciudad.new(3,2)}
    let (:granja_Tipo_Holding_Eolica) {Construccion .new(parcela, 2)
                                                    .extend(Granja)
                                                    .extend(Holding)
                                                    .extend(Eolica)
                                                    .setGradoDeAutomatizacion(30)}

    it 'Con una Velocidad de Viento de 15km y diferencia maxima de altura de 1400' do
      unaCiudad.agregarParcela(parcela)
      unaCiudad.agregarParcela(unaParcela1)
      unaCiudad.agregarParcela(unaParcela2)
      unaCiudad.agregarParcela(unaParcela3)

      expect(granja_Tipo_Holding_Eolica.producirEnergia(condicionDeSimulacion)).to eq(63)
    end
  end

  describe 'tipo Holding con Generacion De Energia Solar' do

    let (:condicionDeSimulacion){CondicionDeSimulacion .new(10)
                                                       .extend(Climatica)
                                                       .extend(Verano)
                                                       .setNubosidad(0.2)
                                                       .setViento(15)
                                                       .setTemperatura(10)}

    let (:parcela)      {Parcela.new(0,0,1500)}
    let (:unaParcela1)  {Parcela.new(0, 1, 1000)}
    let (:unaParcela2)  {Parcela.new(1, 0, 1200)}
    let (:unaParcela3)  {Parcela.new(1, 1, 100)}
    let (:unaCiudad)    {Ciudad.new(3,2)}
    let (:granja_Tipo_Holding_Solar) {Construccion .new(parcela, 2)
                                                    .extend(Granja)
                                                    .extend(Holding)
                                                    .extend(Solar)
                                                    .setGradoDeAutomatizacion(30)
                                                    .setKwPorHoraIdeal(3)}

    it 'Con una Generacion de 3KwHora, nubosidad del 20% y en verano, genera 28,1kw ' do
      unaCiudad.agregarParcela(parcela)
      unaCiudad.agregarParcela(unaParcela1)
      unaCiudad.agregarParcela(unaParcela2)
      unaCiudad.agregarParcela(unaParcela3)

      expect(granja_Tipo_Holding_Solar.producirEnergia(condicionDeSimulacion)).to eq(28.1)
    end
  end

  describe 'tipo Familiar con Generacion De Energia Solar' do

    let (:condicionDeSimulacion){CondicionDeSimulacion .new(10)
                                     .extend(Climatica)
                                     .extend(Verano)
                                     .setNubosidad(0.3)
                                     .setViento(15)
                                     .setTemperatura(10)}

    let (:parcela)      {Parcela.new(0,0,1500)}
    let (:granja_Tipo_Familiar_Solar) {Construccion .new(parcela, 2)
                                          .extend(Granja)
                                          .extend(Familiar)
                                          .extend(Solar)
                                          .setGradoDeAutomatizacion(30)
                                          .setKwPorHoraIdeal(3)}

    it 'Con una Generacion de 3KwHora, nubosidad del 30% y en verano, genera 24,6kw ' do
      expect(granja_Tipo_Familiar_Solar.producirEnergia(condicionDeSimulacion)).to eq(24.6)
    end
  end

  describe 'tipo Familiar con Perfil Consumidor' do

    let(:unaCondicionDeSimulacionVeraniega){CondicionDeSimulacion.new(10).extend(Climatica).extend(Verano)}
    let(:parcela){Parcela.new(0,0,1500)}
    let(:granja_Tipo_Familiar_Derrochador) {Construccion.new(:parcela, 1)
                                            .extend(Granja)
                                            .extend(Familiar)
                                            .extend(Derrochador)
                                            .setProduccionBase(5)
                                            .setGradoDeAutomatizacion(30)
                                            .setConsumoExtra(3)}

     it 'Con una produccion Base de 2.6, una automatizacion del 30% y un perfil derrochador de 3 veces su consumo, consume 5.5Kw' do
      expect(granja_Tipo_Familiar_Derrochador.consumoTotalDeEnergia).to eq(5.5)
     end

    let(:granja_Tipo_Familiar_Consciente_Con_Automatizacion_30) {Construccion.new(:parcela, 1)
                                                .extend(Granja)
                                                .extend(Familiar)
                                                .extend(Consciente)
                                                .setProduccionBase(5)
                                                .setGradoDeAutomatizacion(30)
                                                .setCotaDeConsumo(5)}

    it 'Con una produccion Base de 5, una automatizacion del 30% y un perfil consciente con cota e 5kw, consume 1.8Kw' do
      expect(granja_Tipo_Familiar_Consciente_Con_Automatizacion_30.consumoTotalDeEnergia).to eq(1.8)
    end

    let(:granja_Tipo_Familiar_Consciente_Con_Automatizacion_40) {Construccion.new(:parcela, 1)
                                               .extend(Granja)
                                               .extend(Familiar)
                                               .extend(Consciente)
                                               .setProduccionBase(80)
                                               .setGradoDeAutomatizacion(40)
                                               .setCotaDeConsumo(5)}

    it 'Con una produccion Base de 80, una automatizacion del 40% y un perfil consciente con cota e 5kw, consume 3Kw' do
      expect(granja_Tipo_Familiar_Consciente_Con_Automatizacion_40.consumoTotalDeEnergia).to eq(3)
    end

  end

  describe 'tipo EcoGranja' do

    let(:parcela){Parcela.new(0,0,1500)}
    let(:granja_Tipo_EcoGranja_Derrochadora) {Construccion  .new(:parcela, 1.3)
                                                            .extend(Granja)
                                                            .extend(EcoGranja)
                                                            .extend(Derrochador)
                                                            .setProduccionBaseFija(5)
                                                            .setConsumoExtra(5)}

    it 'una eco granja derrochadora no consume energia' do
    expect(granja_Tipo_EcoGranja_Derrochadora.consumoTotalDeEnergia).to eq(0)
    end

    let(:granja_Tipo_EcoGranja_Consciente) {Construccion  .new(:parcela, 1.3)
                                                          .extend(Granja)
                                                          .extend(EcoGranja)
                                                          .extend(Consciente)
                                                          .setProduccionBaseFija(5)
                                                          .setCotaDeConsumo(5)}

    it 'una eco granja derrochadora no consume energia' do
      expect(granja_Tipo_EcoGranja_Consciente.consumoTotalDeEnergia).to eq(0)
    end

  end

  describe 'tipo Familiar Consciente Solar' do

    let (:condicionDeSimulacion){CondicionDeSimulacion .new(10)
                                     .extend(Climatica)
                                     .extend(Verano)
                                     .setNubosidad(0.3)
                                     .setViento(15)
                                     .setTemperatura(10)}

    let (:parcela)      {Parcela.new(0,0,1500)}
    let (:granja_Tipo_Familiar_Consciente_Solar) {Construccion  .new(parcela, 2)
                                                                .extend(Granja)
                                                                .extend(Familiar)
                                                                .extend(Solar)
                                                                .extend(Consciente)
                                                                .setProduccionBase(10)
                                                                .setGradoDeAutomatizacion(30)
                                                                .setKwPorHoraIdeal(4)
                                                                .setCotaDeConsumo(5)}

    it 'Con una Generacion de 4KwHora, nubosidad del 30% y en verano, genera 32,8kw ' do
      expect(granja_Tipo_Familiar_Consciente_Solar.producirEnergia(condicionDeSimulacion)).to eq(32.8)
    end

    it 'En verano y con una produccion base de 10, produce 50' do
      expect(granja_Tipo_Familiar_Consciente_Solar.producirAlimentos(condicionDeSimulacion)).to eq(50)
    end

    it 'Con un consumo de 3.3, un automatizacion del 30% y una cota de consumo de 5, consume 2.3kw ' do
      expect(granja_Tipo_Familiar_Consciente_Solar.consumoTotalDeEnergia).to eq(2.3)
    end
  end

end