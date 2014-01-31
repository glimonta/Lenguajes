# Marcos Campos    10-10108
# John Delgado     10-10196
# Gabriela Limonta 10-10385
# Andrea Salcedo   10-10666

# Clase para modelar a las maquinas del sistema de creacion de cervezas.
# Hereda de la clase Maquina y tiene dos atributos nuevos cantidad de producto anterior
# actual y cantidad de producto anterior maximo. Las maquinas de esta clase son las maquinas que
# reciben como insumo el producto de una maquina anterior.
class MaquinaReprocesadora < Maquina
  attr_accessor :cantidadPAActual, :cantidadPAMax

  # Inicializa un objeto de la clase MaquinaReprocesadora, toma como argumentos su cantidad maxima, el porcentaje
  # de desecho, los ciclos de procesamiento, la maquina siguiente y la cantidad de producto anterior.
  # Llama al constructor de la superclase e inicializa la cantidad de producto anterior actual en cero.
  def initialize(cantidadMax, desecho, ciclosProcesamiento, siguiente, cantidadPA)
    super(cantidadMax, desecho, ciclosProcesamiento, siguiente)
    @cantidadPAActual = 0
    @cantidadPAMax    = cantidadPA
  end

  # Construye la representacion en String de la maquina. Llama al metodo de la superclase
  # y en caso de estar inactiva o llena agrega la cantidad de insumo correspondiente al
  # producto de una maquina anterior.
  def to_s
    str = ''
    if self.inactiva? || self.llena? then
      str = "Cantidad de Producto de Maquina Anterior: #{@cantidadPAActual.to_s}\n"
    end

    super + str
  end

  # Permite saber si la maquina puede tomar insumos, utiliza el metodo de la
  # superclase y luego verifica que la cantidad actual de producto anterior
  # es la que necesita.
  def puedoTomarInsumos?
    super && @cantidadPAActual == cantidadPAMax
  end

  # Llama al metodo de la superclase y resetea los valores actuales del insumo correspondiente
  # al producto de la maquina anterior.
  def eliminarInsumos
    super
    @cantidadPAActual = 0
  end

end

# Se encarga de generar una clase para una maquina llamada nombre, que herede de superclase
# y que incluya los mixins en la lista pasada como parametro mixins.
def generaMaquina(superclase, nombre, mixins)
  clase = Class::new(superclase) do
    mixins.each { |x| include x}

    # Inicializa un objeto de la clase Maquina, toma como argumentos su cantidad maxima,
    # el porcentaje de desecho, los ciclos de procesamiento, la maquina siguiente y la
    # cantidad de insumo y de producto anterior. Si no se pasan valores para la cantidad de
    # insumos o la cantidad de producto anterior entonces por defecto son nil.
    # Se chequea si incluye a alguno de los modulos que indican que recibe de algun insumo,
    # en caso de que si se incializan esos atributos con la cantidad de insumo la cantidad maxima
    # y con cero la cantidad actual. Si cantidadPA es nil entonces no toma producto anterior y se
    # llama al inicializador de maquina, si en cambio tiene cantidadPA se llama al constructor de
    # MaquinaReprocesadora que lleva mas argumentos.
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

  end

  Object::const_set nombre, clase
end

# Generamos las clases necesarias para modelar el proceso de creado de cerveza
# indicando el nombre de la clase de la que heredan, el nombre de la nueva clase,
# y la lista de modulos que incluyen
generaMaquina(Maquina, 'Silos_de_Cebada', [RecibeCebada])
  generaMaquina(MaquinaReprocesadora, 'Molino'                        , [])
  generaMaquina(MaquinaReprocesadora, 'Paila_de_Mezcla'               , [RecibeMezcla])
  generaMaquina(MaquinaReprocesadora, 'Cuba_de_Filtracion'            , [])
  generaMaquina(MaquinaReprocesadora, 'Paila_de_Coccion'              , [RecibeLupulo])
  generaMaquina(MaquinaReprocesadora, 'Tanque_Preclarificador'        , [])
  generaMaquina(MaquinaReprocesadora, 'Enfriador'                     , [])
  generaMaquina(MaquinaReprocesadora, 'TCC'                           , [RecibeLevadura])
  generaMaquina(MaquinaReprocesadora, 'Filtro_de_Cerveza'             , [])
  generaMaquina(MaquinaReprocesadora, 'Tanques_para_Cerveza_Filtrada' , [])
  generaMaquina(MaquinaReprocesadora, 'Llenadora_y_Tapadora'          , [])
