#!/usr/bin/ruby

module RecibeCebada
  attr_accessor :cantidadCActual, :cantidadCMax
end

module RecibeMezcla
  attr_accessor :cantidadMActual, :cantidadMMax
end

module RecibeLupulo
  attr_accessor :cantidadLActual, :cantidadLMax
end

module RecibeLevadura
  attr_accessor :cantidadVActual, :cantidadVMax
end

class Maquina
  attr_accessor :cantidadMaxima, :estado, :desecho, :ciclosProcesamiento, :cicloActual

  def initialize(cantidadMax, estado, desecho, ciclosProcesamiento)
    @cantidadMaxima = cantidadMax
    @estado = estado
    @desecho = desecho
    @ciclosProcesamiento = ciclosProcesamiento
    @cicloActual = 0
  end

  def inactiva?
    @estado == 'inactiva'
  end

  def procesando?
    @estado == 'procesando'
  end

  def en_espera?
    @estado == 'en espera'
  end

  def llena?
    @estado == 'llena'
  end

  def enviar
  end

  def procesar
  end

  def to_s
    str = ''

    if self.inactiva? || self.llena? then
      str = "Insumos: \n"
    end

    "Maquina #{self.class.name.gsub(/_/," ")} \nEstado: #{@estado} \n" + str
  end
end

class Maquina2 < Maquina
  attr_accessor :cantidadPAActual, :cantidadPAMax
    def initialize(cantidadMax, estado, desecho, ciclosProcesamiento, cantidadPA)
      super(cantidadMax, estado, desecho, ciclosProcesamiento)
      @cantidadPAActual = 0
      @cantidadPAMax    = cantidadPA
    end

    def to_s
      str = ''
      if self.inactiva? || self.llena? then
        str = "Cantidad de Producto de Maquina Anterior: #{@cantidadPAActual.to_s}\n"
      end

      super + str
    end
end

def generaMaquina(superclase, nombre, mixins)
  clase = Class::new(superclase) do
   include mixins.first unless mixins.first.nil?

    def initialize(cantidadMaxima, estado, desecho, ciclosProcesamiento, cantidadInsumo=nil, cantidadPA=nil)
      if self.class.included_modules.include?(RecibeCebada) then
          @cantidadCMax    = cantidadInsumo
          @cantidadCActual = 0
      elsif self.class.included_modules.include?(RecibeMezcla) then
          @cantidadMMax    = cantidadInsumo
          @cantidadMActual = 0
      elsif self.class.included_modules.include?(RecibeLupulo) then
          @cantidadLMax    = cantidadInsumo
          @cantidadLActual = 0
      elsif self.class.included_modules.include?(RecibeLevadura) then
          @cantidadVMax    = cantidadInsumo
          @cantidadVActual = 0
      end

     if cantidadPA.nil? then
       super(cantidadMaxima, estado, desecho, ciclosProcesamiento)
     else
       super(cantidadMaxima, estado, desecho, ciclosProcesamiento, cantidadPA)
     end
    end

    def to_s
      str = ''

      if self.inactiva? || self.llena? then
        str = str + "Cantidad de Cebada: #{@cantidadCActual.to_s} \n" if self.class.included_modules.include?(RecibeCebada)
        str = str + "Cantidad de Mezcla de Arroz/Maiz: #{@cantidadMActual.to_s} \n" if self.class.included_modules.include?(RecibeMezcla)
        str = str + "Cantidad de Lupulo: #{@cantidadLActual.to_s} \n" if self.class.included_modules.include?(RecibeLupulo)
        str = str + "Cantidad de Levadura: #{@cantidadVActual.to_s} \n" if self.class.included_modules.include?(RecibeLevadura)
      end

      super + str + "\n"
    end

  end

  Object::const_set nombre, clase
end


generaMaquina(Maquina, 'Silos_de_Cebada', [RecibeCebada])
  generaMaquina(Maquina2, 'Molino'                        , [])
  generaMaquina(Maquina2, 'Paila_de_Mezcla'               , [RecibeMezcla])
  generaMaquina(Maquina2, 'Cuba_de_Filtracion'            , [])
  generaMaquina(Maquina2, 'Paila_de_Coccion'              , [RecibeLupulo])
  generaMaquina(Maquina2, 'Tanque_preclarificador'        , [])
  generaMaquina(Maquina2, 'Enfriador'                     , [])
  generaMaquina(Maquina2, 'TCC'                           , [RecibeLevadura])
  generaMaquina(Maquina2, 'Filtro_de_Cerveza'             , [])
  generaMaquina(Maquina2, 'Tanques_para_Cerveza_Filtrada' , [])
  generaMaquina(Maquina2, 'Llenadora_y_Tapadora'          , [])


def main
  maquina = Silos_de_Cebada::new(400,"inactiva",0,10,80)
  maquina2 = Molino::new(400,"llena",0,50,90,30)
  maquina3 = Enfriador::new(400,"en espera",60,60,80,60)
  puts maquina
  puts maquina2
  puts maquina3
end
