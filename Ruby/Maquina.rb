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

  def puedoTomarInsumos?
    puedo = true
    puedo = ($cebada  >= @cantidadCMax) if self.class.included_modules.include?(RecibeCebada)
    puedo = ($mezcla   >= @cantidadMMax) if self.class.included_modules.include?(RecibeMezcla)
    puedo = ($lupulo   >= @cantidadLMax) if self.class.included_modules.include?(RecibeLupulo)
    puedo = ($levadura >= @cantidadVMax) if self.class.included_modules.include?(RecibeLevadura)
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
    end

    "Maquina #{self.class.name.gsub(/_/," ")} \nEstado: #{@estado} \n" + str
  end
end
