# Marcos Campos    10-10108
# John Delgado     10-10196
# Gabriela Limonta 10-10385
# Andrea Salcedo   10-10666

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
    super && @cantidadPAActual == cantidadPAMax
  end

  def eliminarInsumos
    super
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
