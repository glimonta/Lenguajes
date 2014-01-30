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

  def initialize(cantidadMax, estado, desecho, ciclosProcesamiento,siguiente)
    @cantidadMaxima = cantidadMax
    @estado = estado
    @desecho = desecho
    @ciclosProcesamiento = ciclosProcesamiento
    @siguiente = siguiente
    @cicloActual = 0
    @cantidadProducida
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

  def tengoInsumos?
    true
  end

  def enviar(siguiente)
    if !siguiente.nil? then
      if @siguiente.cantidadPAMax <= @cantidadProducida then
        @siguiente.cantidadPAActual = @siguiente.cantidadPAMax
        @cantidadProducida = @cantidadProducida - @siguiente.cantidadPAMax
      else
        @siguiente.cantidadPAActual = @cantidadProducida
        @cantidadProducida = 0
        @estado = 'inactiva'
      end
    else
      puts (@cantidadProducida / 4).to_s
      @estado = 'inactiva'
    end
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

  def initialize(cantidadMax, estado, desecho, ciclosProcesamiento, siguiente, cantidadPA)
    super(cantidadMax, estado, desecho, ciclosProcesamiento, siguiente)
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

  def tengoInsumos?
    super && @cantidadPAActual == @cantidadPAMax
  end

  def eliminarInsumos
    @cantidadPAActual = 0
  end

end

def generaMaquina(superclase, nombre, siguiente, mixins)
  clase = Class::new(superclase) do
   include mixins.first unless mixins.first.nil?

    def initialize(cantidadMaxima, estado, desecho, ciclosProcesamiento, siguiente, cantidadInsumo=nil, cantidadPA=nil)
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
       super(cantidadMaxima, estado, desecho, ciclosProcesamiento, siguiente)
     else
       super(cantidadMaxima, estado, desecho, ciclosProcesamiento, siguiente, cantidadPA)
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

    def tengoInsumos?
      insumos = super
      insumos = insumos && @cantidadCActual == @cantidadCMax if self.class.included_modules.include?(RecibeCebada)
      insumos = insumos && @cantidadMActual == @cantidadMMax if self.class.included_modules.include?(RecibeMezcla)
      insumos = insumos && @cantidadLActual == @cantidadLMax if self.class.included_modules.include?(RecibeLupulo)
      insumos = insumos && @cantidadVActual == @cantidadVMax if self.class.included_modules.include?(RecibeLevadura)
      insumos
    end

    def eliminarInsumos
      super
      @cantidadCActual = 0 if self.class.included_modules.include?(RecibeCebada)
      @cantidadMActual = 0 if self.class.included_modules.include?(RecibeMezcla)
      @cantidadLActual = 0 if self.class.included_modules.include?(RecibeLupulo)
      @cantidadVActual = 0 if self.class.included_modules.include?(RecibeLevadura)
    end

    def procesar
      if inactiva? then
        if tengoInsumos? then
          @estado = 'llena'
        end
      elsif llena? then
        @estado = 'procesando'
      elsif procesando? then
        if @cicloActual < @ciclosProcesamiento then
          @cicloActual = @cicloActual.succ
        else
          @cicloActual = 0
          @cantidadProducida = @capacidadMaxima * (1 - @desecho)
          eliminarInsumos
          @estado = 'en espera'
        end
      elsif en_espera? then
        if @siguiente.inactiva? then
          enviar(@siguiente)
        end
      end
    end

  end

  Object::const_set nombre, clase
end


generaMaquina(Maquina, 'Silos_de_Cebada', 'Molino', [RecibeCebada])
  generaMaquina(Maquina2, 'Molino'                        , 'Paila_de_Mezcla'               ,[])
  generaMaquina(Maquina2, 'Paila_de_Mezcla'               , 'Cuba_de_Filtracion'            ,[RecibeMezcla])
  generaMaquina(Maquina2, 'Cuba_de_Filtracion'            , 'Paila_de_Coccion'              ,[])
  generaMaquina(Maquina2, 'Paila_de_Coccion'              , 'Tanque_preclarificador'        ,[RecibeLupulo])
  generaMaquina(Maquina2, 'Tanque_preclarificador'        , 'Enfriador'                     ,[])
  generaMaquina(Maquina2, 'Enfriador'                     , 'TCC'                           ,[])
  generaMaquina(Maquina2, 'TCC'                           , 'Filtro_de_Cerveza'             ,[RecibeLevadura])
  generaMaquina(Maquina2, 'Filtro_de_Cerveza'             , 'Tanques_para_Cerveza_Filtrada' ,[])
  generaMaquina(Maquina2, 'Tanques_para_Cerveza_Filtrada' , 'Llenadora_y_Tapadora'          ,[])
  generaMaquina(Maquina2, 'Llenadora_y_Tapadora'          ,  nil                            ,[])


def main
  maquina = Silos_de_Cebada::new(400,"inactiva",0,10,80)
  maquina2 = Molino::new(400,"llena",0,50,90,30)
  maquina3 = Enfriador::new(400,"en espera",60,60,80,60)
  puts maquina
  puts maquina2
  puts maquina3
end
