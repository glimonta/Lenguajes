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
  attr_accessor :cantidadMaxima, :estado, :desecho, :ciclosProcesamiento, :siguiente, :cicloActual, :cantidadProducida

  def initialize(cantidadMax, desecho, ciclosProcesamiento,siguiente)
    @cantidadMaxima = cantidadMax
    @estado = 'inactiva'
    @desecho = desecho
    @ciclosProcesamiento = ciclosProcesamiento
    @siguiente = siguiente
    @cicloActual = 0
    @cantidadProducida = 0
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

  def puedoTomarInsumos?
    ($cebada  >= @cantidadCMax) if self.class.included_modules.include?(RecibeCebada)
  end

  def estado
    @estado
  end

  def enviar
    if !@siguiente.nil? then
      if @siguiente.cantidadPAMax <= @cantidadProducida then
        @siguiente.cantidadPAActual = @siguiente.cantidadPAMax
        @cantidadProducida = @cantidadProducida - @siguiente.cantidadPAMax
      else
        faltaPorLlenar = @siguiente.cantidadPAMax - @siguiente.cantidadPAActual
        if faltaPorLlenar > @cantidadProducida
          @siguiente.cantidadPAActual = @siguiente.cantidadPAActual + @cantidadProducida
          @cantidadProducida = 0
          @estado = 'inactiva'
        else
          @cantidadProducida = @cantidadProducida - faltaPorLlenar
          @siguiente.cantidadPAActual = @siguiente.cantidadPAMax
        end
      end
    else
      puts (@cantidadProducida / 4).to_s
      $cerveza = $cerveza + (@cantidadProducida / 4)
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

  def initialize(cantidadMax, desecho, ciclosProcesamiento, siguiente, cantidadPA)
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

    def initialize(cantidadMaxima, desecho, ciclosProcesamiento, siguiente, cantidadInsumo=nil, cantidadPA=nil)
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
      puedo = puedo && ($mezcla   >= @cantidadMMax) if self.class.included_modules.include?(RecibeMezcla)
      puedo = puedo && ($lupulo   >= @cantidadLMax) if self.class.included_modules.include?(RecibeLupulo)
      puedo = puedo && ($levadura >= @cantidadVMax) if self.class.included_modules.include?(RecibeLevadura)
      puedo
    end

    def tomarInsumos
      if puedoTomarInsumos? then
        $cebada   = $cebada   - @cantidadCMax if self.class.included_modules.include?(RecibeCebada)
        $mezcla   = $mezcla   - @cantidadMMax if self.class.included_modules.include?(RecibeMezcla)
        $lupulo   = $lupulo   - @cantidadLMax if self.class.included_modules.include?(RecibeLupulo)
        $levadura = $levadura - @cantidadVMax if self.class.included_modules.include?(RecibeLevadura)
        @estado   = 'llena'
      end
    end

    def procesar
      if inactiva? then
          tomarInsumos
      elsif llena? then
        @estado = 'procesando'
      end

      if procesando? then
        if @cicloActual < @ciclosProcesamiento then
          @cicloActual = @cicloActual.succ
        else
          @cicloActual = 0
          @cantidadProducida = 0
          @cantidadProducida = @cantidadMaxima * (1 - @desecho)
          eliminarInsumos unless self.is_a? Silos_de_Cebada
          @estado = 'en espera'
          enviar
        end
      elsif en_espera? then
        if @siguiente.inactiva? then
          enviar
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


  $numeroCiclos = ARGV[0].to_i
  $cebada       = ARGV[1].to_i
  $mezcla       = ARGV[2].to_i
  $levadura     = ARGV[3].to_i
  $lupulo       = ARGV[4].to_i
  $cerveza      = 0

  llenadora = Llenadora_y_Tapadora::new(50, 0, 2, nil, nil, 50)
  tanque = Tanques_para_Cerveza_Filtrada::new(100, 0, 0, llenadora, nil, 100)
  filtro = Filtro_de_Cerveza::new(100, 0, 1, tanque, nil, 100)
  tcc = TCC::new(200, 0.10, 10, filtro, 2, 198)
  enfriador = Enfriador::new(60, 0, 2, tcc, nil, 60)
  preclarificador = Tanque_Preclarificador::new(35, 0.01, 1, enfriador, nil, 35)
  coccion = Paila_de_Coccion::new(70, 0.10, 3, preclarificador, 1.75, 68.25)
  cuba = Cuba_de_Filtracion::new(135, 0.35, 2, coccion, nil, 135)
  mezcla = Paila_de_Mezcla::new(150, 0, 2, cuba, 60, 90)
  molino = Molino::new(100, 0.02, 1, mezcla, nil, 100)
  silos = Silos_de_Cebada::new(400, 0, 0, molino, 400)

  $numeroCiclos.times do |iterando|
    estadosPasados  = []
    estadosActuales = []
    puts "Inicio ciclo " + iterando.to_s + " \n"
    puts "Cerveza total: #{$cerveza}\n"
    puts "Cebada sobrante: #{$cebada}\nLupulo sobrante: #{$lupulo}\n"
    puts "Levadura sobrante: #{$levadura}\nMezcla Arroz\\Maiz sobrante: #{$mezcla}\n\n"
    maquina = silos
    while (!maquina.nil?)
      estadosPasados.insert(0,maquina.estado)
      maquina.procesar
      puts maquina.to_s
      estadosActuales.insert(0,maquina.estado)
      maquina = maquina.siguiente
    end
      break if (estadosPasados == estadosActuales) && estadosPasados.find_index("procesando").nil?
   end

end

main
