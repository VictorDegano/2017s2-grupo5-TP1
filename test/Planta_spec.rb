require 'rspec'
require_relative '../src/Parcela'
require_relative '../src/Mixins/Plantas/Planta'
require_relative '../src/Mixins/Plantas/Normal'
require_relative '../src/Mixins/Plantas/Solar'
require_relative '../src/Mixins/Plantas/Eolica'
require_relative '../src/Construccion'
require_relative '../src/CondicionDeSimulacion'
require_relative '../src/Mixins/CondicionDeSimulacion/Climatica'
require_relative '../src/Mixins/CondicionDeSimulacion/Estaciones/Verano'
require_relative '../src/Ciudad'
require_relative '../src/Mixins/Laboral'
require_relative '../src/Mixins/Propiedad/Publica'
require_relative '../src/Mixins/Propiedad/Privada'


describe 'Planta' do

  describe 'tipo Normal Publica' do

    let (:condicionDeSimulacionDiaLaboral1) {CondicionDeSimulacion.new(10).extend(Climatica)
                                                                                 .extend(Verano)
                                                                                 .setNubosidad(0)
                                                                                 .setViento(0)
                                                                                 .setTemperatura(0)
                                                                                 .extend(Laboral)
                                                                                 .setDiaLaboral}
    let (:unaParcela) {Parcela.new 0, 0, 1500}
    let (:unaConstruccion_Planta_Normal_Publica)  {Construccion .new(unaParcela,0)
                                                        .extend(Planta)
                                                        .extend(Normal)
                                                       .extend(Publica)
                                                       .setEmpleados(20)
                                                        .setKwHoraEmpleado(2)}

    it 'con 20 empleados y 2kws/h por empleado, en un dia genera 960Kw/Dia' do

      unaConstruccion_Planta_Normal_Publica.generarEnergia(condicionDeSimulacionDiaLaboral1)
      expect(unaConstruccion_Planta_Normal_Publica.energiaGenerada()).to eq(960)
    end

    let (:condicionDeSimulacionDiaFeriado1) {CondicionDeSimulacion.new(10).extend(Climatica)
                                                                 .extend(Verano)
                                                                 .setNubosidad(0)
                                                                 .setViento(0)
                                                                 .setTemperatura(0)
                                                                 .extend(Laboral)
                                                                 .setFeriado}
    it 'con 20 empleaos y 2kws/h por empleado, una planta normal publica en dia feriado genera el 480Kw/Dia' do
      unaConstruccion_Planta_Normal_Publica.generarEnergia(condicionDeSimulacionDiaFeriado1)
      expect(unaConstruccion_Planta_Normal_Publica.energiaGenerada()).to eq(480)
    end

  end

  describe 'tipo Solar Publica' do

    let (:condicionDeSimulacionDiaLaboral2){CondicionDeSimulacion .new(10)
                                                        .extend(Climatica)
                                                        .extend(Verano)
                                                        .setNubosidad(0.8)
                                                        .setViento(0)
                                                        .setTemperatura(10)
                                                        .extend(Laboral)
                                                        .setDiaLaboral}
    let (:unaParcela1) {Parcela.new 0, 0, 1000}
    let (:unaConstruccion_Planta_Solar_Publica_Con_Altura_1000) {Construccion.new(unaParcela1,1)
                                                                     .extend(Publica)
                                                                     .extend(Planta)
                                                                     .extend(Solar)
                                                                     .setEmpleados(20)
                                                                     .setKwPorHoraIdeal(10)}
    it 'con 20 empleados, 10kws/h ideal, 20% de nubosidad, altura de parcela 1000 y en verano, genera 15.6kw' do


      unaConstruccion_Planta_Solar_Publica_Con_Altura_1000.generarEnergia(condicionDeSimulacionDiaLaboral2)
      expect(unaConstruccion_Planta_Solar_Publica_Con_Altura_1000.energiaGenerada()).to eq(15.6)
    end
    let (:unaParcela2) {Parcela.new 0, 0, 0}
    let (:unaConstruccion_Planta_Solar_Publica_Con_Altura_0)  {Construccion.new(unaParcela2,1)
                                                                    .extend(Publica)
                                                                    .extend(Planta)
                                                                    .setEmpleados(20)
                                                                    .extend(Solar)
                                                                    .setKwPorHoraIdeal(10)}
    it 'con 20 empleados, 10kws/h ideal, 20% de nubosidad, altura de parcela 0 y en verano, genera 2.6kw' do

      unaConstruccion_Planta_Solar_Publica_Con_Altura_0.generarEnergia(condicionDeSimulacionDiaLaboral2)
      expect(unaConstruccion_Planta_Solar_Publica_Con_Altura_0.energiaGenerada()).to eq(2.6)
    end

    let (:condicionDeSimulacionDiaFeriado2){CondicionDeSimulacion .new(10)
                                               .extend(Climatica)
                                               .extend(Verano)
                                               .setNubosidad(0.8)
                                               .setViento(0)
                                               .setTemperatura(10)
                                               .extend(Laboral)
                                               .setFeriado}
    it 'con 20 empleados, 10kws/h ideal, 20% de nubosidad, altura de parcela 1000, en verano y en un dia feriado,
        uan planta solar publica genera genera 7.8kw' do
      unaConstruccion_Planta_Solar_Publica_Con_Altura_1000.generarEnergia(condicionDeSimulacionDiaFeriado2)
      expect(unaConstruccion_Planta_Solar_Publica_Con_Altura_1000.energiaGenerada).to eq(7.8)
    end

    it 'con 20 empleados, 10kws/h ideal, 20% de nubosidad, altura de parcela 0, en verano y en un dia feriado, una planta
        solar publica genera 1.3kw' do
      unaConstruccion_Planta_Solar_Publica_Con_Altura_0.generarEnergia(condicionDeSimulacionDiaFeriado2)
      expect(unaConstruccion_Planta_Solar_Publica_Con_Altura_0.energiaGenerada).to eq(1.3)
    end
  end

  describe 'tipo Eolica Publica' do
    let (:condicionDeSimulacionDiaLaboral3){CondicionDeSimulacion .new(10)
                                                        .extend(Climatica)
                                                        .extend(Verano)
                                                        .setNubosidad(0.8)
                                                        .setViento(15)
                                                        .setTemperatura(10)
                                                        .extend(Laboral)
                                                        .setDiaLaboral}
    let (:unaParcela3)  {Parcela.new(0, 0, 1500)}
    let (:unaParcela4)  {Parcela.new(0, 1, 1000)}
    let (:unaParcela5)  {Parcela.new(1, 0, 1200)}
    let (:unaParcela6)  {Parcela.new(1, 1, 100)}
    let (:unaParcela7)  {Parcela.new(2, 0, 340)}
    let (:unaParcela8)  {Parcela.new(2, 1, 401)}
    let (:unaCiudad) {Ciudad.new(3,2)}
    let (:unaConstruccion_Planta_Eolica_Publica) {Construccion .new(unaParcela3,1)
                                                                    .extend(Publica)
                                                                    .extend(Planta)
                                                                    .setEmpleados(20)
                                                                    .extend(Eolica)}

    it 'con 20 empleados, viento de 15km/h y diferencia maxiam de altura de 1400, genera 63kw' do
      unaCiudad .agregarParcela(unaParcela3).agregarParcela(unaParcela4)
                .agregarParcela(unaParcela5).agregarParcela(unaParcela6)
                .agregarParcela(unaParcela7).agregarParcela(unaParcela8)

      unaConstruccion_Planta_Eolica_Publica.generarEnergia(condicionDeSimulacionDiaLaboral3)
      expect(unaConstruccion_Planta_Eolica_Publica.energiaGenerada()).to eq(63)
    end

    let (:condicionDeSimulacionDiaFeriado3){CondicionDeSimulacion .new(10)
                                                .extend(Climatica)
                                                .extend(Verano)
                                                .setNubosidad(0.8)
                                                .setViento(15)
                                                .setTemperatura(10)
                                                .extend(Laboral)
                                                .setFeriado}
    it 'con 20 empleados, viento de 15km/h y diferencia maxima de altura de 1400 y en dia feriado, una planta solar publica genera 31.5kw' do
      unaCiudad .agregarParcela(unaParcela3).agregarParcela(unaParcela4)
                .agregarParcela(unaParcela5).agregarParcela(unaParcela6)
                .agregarParcela(unaParcela7).agregarParcela(unaParcela8)

      unaConstruccion_Planta_Eolica_Publica.generarEnergia(condicionDeSimulacionDiaFeriado3)
      expect(unaConstruccion_Planta_Eolica_Publica.energiaGenerada).to eq(31.5)
    end
  end

  describe 'tipo Normal privada' do
    let (:condicionDeSimulacion) {CondicionDeSimulacion.new(10)
                                                 .setPrecioKWMundial(12.5)
                                                 .extend(Climatica)
                                                 .extend(Verano)
                                                 .setNubosidad(0)
                                                 .setViento(0)
                                                 .setTemperatura(0)}
    let (:unaParcela) {Parcela.new 0, 0, 1500}
    let (:unaConstruccion_Planta_Normal_Privada)  {Construccion .new(unaParcela,0)
                                                                .extend(Privada)
                                                                .extend(Planta)
                                                                .extend(Normal)
                                                                .setEmpleados(20)
                                                                .setKwHoraEmpleado(2)}

    it 'con 20 empleados y 2kws/h por empleado y con un precio KW mundial mayor a 10, una Planta Normal Privada genera 960Kw/Dia' do

      unaConstruccion_Planta_Normal_Privada.generarEnergia(condicionDeSimulacion)
      expect(unaConstruccion_Planta_Normal_Privada.energiaGenerada()).to eq(960)
    end

    let (:condicionDeSimulacionDiaFeriado1) {CondicionDeSimulacion.new(10)
                                                 .setPrecioKWMundial(7)
                                                 .extend(Climatica)
                                                 .extend(Verano)
                                                 .setNubosidad(0)
                                                 .setViento(0)
                                                 .setTemperatura(0)
    }
    it 'con un precio mundial de KW que no supera los $10, la planta no genera energia' do
      unaConstruccion_Planta_Normal_Privada.generarEnergia(condicionDeSimulacionDiaFeriado1)
      expect(unaConstruccion_Planta_Normal_Privada.energiaGenerada()).to eq(0)
    end
  end


  describe 'tipo Solar Privada' do
    let (:condicionDeSimulacion1){CondicionDeSimulacion .new(10)
                                                .setPrecioKWMundial(14)
                                                .extend(Climatica)
                                                .extend(Verano)
                                                .setNubosidad(0.8)
                                                .setViento(0)
                                                .setTemperatura(10)}
    let (:unaParcela1) {Parcela.new 0, 0, 1000}
    let (:unaConstruccion_Planta_Solar_Privada_Con_Altura_1000) {Construccion.new(unaParcela1,1)
                                                                     .extend(Privada)
                                                                     .extend(Planta)
                                                                     .extend(Solar)
                                                                     .setEmpleados(20)
                                                                     .setKwPorHoraIdeal(10)}
    it 'con 20 empleados, 10kws/h ideal, 20% de nubosidad, altura de parcela 1000 y en verano y un precio mundial de KW mayor a 10,
        una planta Solar Privada genera 15.6kw' do


      unaConstruccion_Planta_Solar_Privada_Con_Altura_1000.generarEnergia(condicionDeSimulacion1)
      expect(unaConstruccion_Planta_Solar_Privada_Con_Altura_1000.energiaGenerada()).to eq(15.6)
    end
    let (:unaParcela2) {Parcela.new 0, 0, 0}
    let (:unaConstruccion_Planta_Solar_Privada_Con_Altura_0)  {Construccion.new(unaParcela2,1)
                                                                   .extend(Privada)
                                                                   .extend(Planta)
                                                                   .setEmpleados(20)
                                                                   .extend(Solar)
                                                                   .setKwPorHoraIdeal(10)}
    it 'con 20 empleados, 10kws/h ideal, 20% de nubosidad, altura de parcela 0 y en verano y con un precio mundial de KW mayor a 10,
        una planta Solar Privada genera 2.6kw' do

      unaConstruccion_Planta_Solar_Privada_Con_Altura_0.generarEnergia(condicionDeSimulacion1)
      expect(unaConstruccion_Planta_Solar_Privada_Con_Altura_0.energiaGenerada()).to eq(2.6)
    end

    let (:condicionDeSimulacion2){CondicionDeSimulacion .new(10)
                                                .setPrecioKWMundial(6.3)
                                                .extend(Climatica)
                                                .extend(Verano)
                                                .setNubosidad(0.8)
                                                .setViento(0)
                                                .setTemperatura(10)}
    it 'con un precio mundial de KW que no supera los $10, la planta no genera energia' do
      unaConstruccion_Planta_Solar_Privada_Con_Altura_1000.generarEnergia(condicionDeSimulacion2)
      expect(unaConstruccion_Planta_Solar_Privada_Con_Altura_1000.energiaGenerada).to eq(0)
    end

    it 'con un precio mundial de KW que no supera los $10, la planta no genera energia' do
      unaConstruccion_Planta_Solar_Privada_Con_Altura_0.generarEnergia(condicionDeSimulacion2)
      expect(unaConstruccion_Planta_Solar_Privada_Con_Altura_0.energiaGenerada).to eq(0)
    end
  end

  describe 'tipo Eolica Privada' do
    let (:condicionDeSimulacion1){CondicionDeSimulacion .new(10)
                                                .setPrecioKWMundial(23)
                                                .extend(Climatica)
                                                .extend(Verano)
                                                .setNubosidad(0.8)
                                                .setViento(15)
                                                .setTemperatura(10)}
    let (:unaParcela3)  {Parcela.new(0, 0, 1500)}
    let (:unaParcela4)  {Parcela.new(0, 1, 1000)}
    let (:unaParcela5)  {Parcela.new(1, 0, 1200)}
    let (:unaParcela6)  {Parcela.new(1, 1, 100)}
    let (:unaParcela7)  {Parcela.new(2, 0, 340)}
    let (:unaParcela8)  {Parcela.new(2, 1, 401)}
    let (:unaCiudad) {Ciudad.new(3,2)}
    let (:unaConstruccion_Planta_Eolica_Privada) {Construccion .new(unaParcela3,1)
                                                      .extend(Privada)
                                                      .extend(Planta)
                                                      .setEmpleados(20)
                                                      .extend(Eolica)}

    it 'con 20 empleados, viento de 15km/h y diferencia maxiam de altura de 1400, y un precio mundial de KW, una planta Eolica Privada genera 63kw' do
      unaCiudad .agregarParcela(unaParcela3).agregarParcela(unaParcela4)
          .agregarParcela(unaParcela5).agregarParcela(unaParcela6)
          .agregarParcela(unaParcela7).agregarParcela(unaParcela8)

      unaConstruccion_Planta_Eolica_Privada.generarEnergia(condicionDeSimulacion1)
      expect(unaConstruccion_Planta_Eolica_Privada.energiaGenerada()).to eq(63)
    end

    let (:condicionDeSimulacion2){CondicionDeSimulacion .new(10)
                                                .setPrecioKWMundial(10)
                                                .extend(Climatica)
                                                .extend(Verano)
                                                .setNubosidad(0.8)
                                                .setViento(15)
                                                .setTemperatura(10)}
    it 'con un precio mundial de KW que no supera los $10, la planta no genera energia' do
      unaCiudad .agregarParcela(unaParcela3).agregarParcela(unaParcela4)
          .agregarParcela(unaParcela5).agregarParcela(unaParcela6)
          .agregarParcela(unaParcela7).agregarParcela(unaParcela8)

      unaConstruccion_Planta_Eolica_Privada.generarEnergia(condicionDeSimulacion2)
      expect(unaConstruccion_Planta_Eolica_Privada.energiaGenerada).to eq(0)
    end
  end
end