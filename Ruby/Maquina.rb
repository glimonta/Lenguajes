# Marcos Campos    10-10108
# John Delgado     10-10196
# Gabriela Limonta 10-10385
# Andrea Salcedo   10-10666

# Modulo que sera incluido en las clases que reciban cebada como insumo.
module RecibeCebada
  attr_accessor :cantidadCActual, :cantidadCMax
end

# Modulo que sera incluido en las clases que reciban mezcla de arroz y maiz como insumo.
module RecibeMezcla
  attr_accessor :cantidadMActual, :cantidadMMax
end

# Modulo que sera incluido en las clases que reciban lupulo como insumo.
module RecibeLupulo
  attr_accessor :cantidadLActual, :cantidadLMax
end

# Modulo que sera incluido en las clases que reciban levadura como insumo.
module RecibeLevadura
  attr_accessor :cantidadVActual, :cantidadVMax
end

# Clase para modelar a las maquinas del sistema de creacion de cervezas.
# poseen como atributos su cantidad maxima (Kg), el estado de la misma, el porcentaje
# de desecho, la cantidad de ciclos de procesamiento, la maquina que le sigue en la linea
# de produccion, el ciclo actual en el que se encuentra y la cantidad de producto que hace.
class Maquina
  attr_accessor :cantidadMaxima, :estado, :desecho, :ciclosProcesamiento, :siguiente, :cicloActual, :cantidadProducida

  # Inicializa un objeto de la clase Maquina, toma como argumentos su cantidad maxima, el porcentaje
  # de desecho, los ciclos de procesamiento y la maquina siguiente. Se incializan por defecto en el
  # ciclo actual cero, con cantidad producida cero y en estado inactiva.
  def initialize(cantidadMax, desecho, ciclosProcesamiento,siguiente)
    @cantidadMaxima = cantidadMax
    @estado = 'inactiva'
    @desecho = desecho
    @ciclosProcesamiento = ciclosProcesamiento
    @siguiente = siguiente
    @cicloActual = 0
    @cantidadProducida = 0
  end

  # Permite saber si una maquina esta en estado inactiva
  def inactiva?
    @estado == 'inactiva'
  end

  # Permite saber si una maquina esta en estado procesando
  def procesando?
    @estado == 'procesando'
  end

  # Permite saber si una maquina esta en estado en espera
  def en_espera?
    @estado == 'en espera'
  end

  # Permite saber si una maquina esta en estado llena
  def llena?
    @estado == 'llena'
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

  # Permite saber si la maquina puede tomar insumos, revisa que la cantidad de
  # insumo en la variable global sea mayor a la cantidad que necesita la maquina
  # del mismo si esta maquina recibe este insumo.
  def puedoTomarInsumos?
    puedo = true
    puedo = ($cebada   >= @cantidadCMax) if self.class.included_modules.include?(RecibeCebada)
    puedo = ($mezcla   >= @cantidadMMax) if self.class.included_modules.include?(RecibeMezcla)
    puedo = ($lupulo   >= @cantidadLMax) if self.class.included_modules.include?(RecibeLupulo)
    puedo = ($levadura >= @cantidadVMax) if self.class.included_modules.include?(RecibeLevadura)
    puedo
  end

  def tomarInsumos
    if puedoTomarInsumos? then
      if self.class.included_modules.include?(RecibeCebada)
        $cebada   = $cebada   - @cantidadCMax
        @cantidadCActual = @cantidadCMax
      elsif self.class.included_modules.include?(RecibeMezcla)
        $mezcla   = $mezcla   - @cantidadMMax
        @cantidadMActual = @cantidadMMax
      elsif self.class.included_modules.include?(RecibeLupulo)
        $lupulo   = $lupulo   - @cantidadLMax
        @cantidadLActual = @cantidadLMax
      elsif self.class.included_modules.include?(RecibeLevadura)
        $levadura = $levadura - @cantidadVMax
        @cantidadVActual = @cantidadVMax
      end

      @estado   = 'llena'
    end
  end

  def eliminarInsumos
    @cantidadCActual = 0 if self.class.included_modules.include?(RecibeCebada)
    @cantidadMActual = 0 if self.class.included_modules.include?(RecibeMezcla)
    @cantidadLActual = 0 if self.class.included_modules.include?(RecibeLupulo)
    @cantidadVActual = 0 if self.class.included_modules.include?(RecibeLevadura)
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

  def to_s
    str = ''

    if self.inactiva? || self.llena? then
      str = "Insumos: \n"
      str = str + "Cantidad de Cebada: #{@cantidadCActual.to_s} \n" if self.class.included_modules.include?(RecibeCebada)
      str = str + "Cantidad de Mezcla de Arroz/Maiz: #{@cantidadMActual.to_s} \n" if self.class.included_modules.include?(RecibeMezcla)
      str = str + "Cantidad de Lupulo: #{@cantidadLActual.to_s} \n" if self.class.included_modules.include?(RecibeLupulo)
      str = str + "Cantidad de Levadura: #{@cantidadVActual.to_s} \n" if self.class.included_modules.include?(RecibeLevadura)
    else
      str = "\n"
    end

    "Maquina #{self.class.name.gsub(/_/," ")} \nEstado: #{@estado} \n" + str
  end
end
