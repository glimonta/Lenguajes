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

  def initialize(cantidadMax, desecho, ciclosProcesamiento,siguiente)
    @cantidadMaxima = cantidadMax
    @estado = 'inactiva'
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
    super(cantidadMax, desecho, ciclosProcesamiento, siguiente)
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

  def puedoTomarInsumos? 
    @cantidadPAActual == cantidadPAMax
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
       super(cantidadMaxima, desecho, ciclosProcesamiento, siguiente)
     else
       super(cantidadMaxima, desecho, ciclosProcesamiento, siguiente, cantidadPA)
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

    def eliminarInsumos
      super
      @cantidadCActual = 0 if self.class.included_modules.include?(RecibeCebada)
      @cantidadMActual = 0 if self.class.included_modules.include?(RecibeMezcla)
      @cantidadLActual = 0 if self.class.included_modules.include?(RecibeLupulo)
      @cantidadVActual = 0 if self.class.included_modules.include?(RecibeLevadura)
    end

    def asignarSiguiente(siguiente)
      @siguiente = siguiente
    end

    def puedoTomarInsumos? 
      puedo = super
      puedo = puedo && ($cebada  > @cantidadCMax) if self.class.included_modules.include?(RecibeCebada)
      puedo = puedo && ($mezcla  > @cantidadMMax) if self.class.included_modules.include?(RecibeMezcla)
      puedo = puedo && ($lupulo  > @cantidadLMax) if self.class.included_modules.include?(RecibeLupulo)
      puedo = puedo && ($levadura > @cantidadVMax) if self.class.included_modules.include?(RecibeLevadura)
      puedo
    end

    def tomarInsumos
      if puedoTomarInsumos? then
        $cebada = $cebada - @cantidadCMax if self.class.included_modules.include?(RecibeCebada)
        $mezcla = $mezcla - @cantidadMMax if self.class.included_modules.include?(RecibeMezcla)
        $lupulo = $lupulo - @cantidadLMax if self.class.included_modules.include?(RecibeLupulo)
        $levadura = $levadura - @cantidadVMax if self.class.included_modules.include?(RecibeLevadura)
        @estado = 'llena'
      end
    end

    def procesar
      if inactiva? then
        if puedoTomarInsumos? then
          tomarInsumos
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


generaMaquina(Maquina, 'Silos_de_Cebada', nil, [RecibeCebada])
  generaMaquina(Maquina2, 'Molino'                        , nil ,[])
  generaMaquina(Maquina2, 'Paila_de_Mezcla'               , nil ,[RecibeMezcla])
  generaMaquina(Maquina2, 'Cuba_de_Filtracion'            , nil ,[])
  generaMaquina(Maquina2, 'Paila_de_Coccion'              , nil ,[RecibeLupulo])
  generaMaquina(Maquina2, 'Tanque_Preclarificador'        , nil ,[])
  generaMaquina(Maquina2, 'Enfriador'                     , nil ,[])
  generaMaquina(Maquina2, 'TCC'                           , nil ,[RecibeLevadura])
  generaMaquina(Maquina2, 'Filtro_de_Cerveza'             , nil ,[])
  generaMaquina(Maquina2, 'Tanques_para_Cerveza_Filtrada' , nil ,[])
  generaMaquina(Maquina2, 'Llenadora_y_Tapadora'          , nil ,[])

def main
  $numeroCiclos = ARG[0]
  $cebada = ARG[1]
  $mezcla = ARG[2]
  $levadura = ARG[3]
  $lupulo = ARG[4]

  llenadora = Llenadora_y_Tapadora::new(50, 0, 2, nil, nil, 50)
  tanque = Tanques_para_Cerveza_Filtrada::new(100, 0, 0, llenadora, nil, 100)
  filtro = Filtro_de_Cerveza::new(100, 0, 1, tanque, nil, 100)
  tcc = TCC::new(200, 10, 10, filtro, 2, 198)
  enfriador = Enfriador::new(60, 10, 2, tcc, nil, 60)
  preclarificador = Tanque_Preclarificador::new(35, 1, 1, enfriador, nil, 35)
  coccion = Paila_de_Coccion::new(70, 10, 3, preclarificador, 1.75, 68.25)
  cuba = Cuba_de_Filtracion::new(135, 35, 2, coccion, nil, 135)
  mezcla = Paila_de_Mezcla::new(150, 0, 2, cuba, 60, 90)
  molino = Molino::new(100, 2, 1, mezcla, nil, 100)
  silos = Silos_de_Cebada::new(400, 0, 0, molino, 400)
end
