#require './metodos.rb'

class Fraccion
	include Comparable
	
	# * +n+ - numerador
	attr_reader :n
	# * +d+ - denominador
	attr_reader :d

	# === Descripcion
	#  Constructor de la clase, en caso de no existir denomidador se pone la unidad
	# ==== Atributos
	#
	# * +n+ - filas
	# * +d+ - columnas
	#
	# ==== Examples
	#	Fraccion.new(2, 2) 
	#	Fraccion.new(4, 5)
	def initialize(a,b)
		if b==0
			raise "Error de ejecucion. Division entre 0"
		else
			@n,@d = a,b
		end
		#Se simplifica al crear la fraccion		
		@n, @d = @n/mcd(@n, @d), @d/mcd(@n, @d)	
	end
	# === Descripcion
	#  Devuelve un string con la fraccion
	# ==== Examples
	#	matriz.to_s()
	def to_s
		if (@d != 1)
			return "#{@n}/#{@d}" 
		else 
			return "#{@n}"
		end
	end
	
	# === Descripcion
	#  Devuelve el double correspondiente a la fraccion
	# ==== Examples
	#	matriz.to_d()
	def to_d
		return (@n*1.0)/@d
	end

	# === Descripcion
	#  Suma de dos racionales
	# ==== Atributos
	#
	# * +other+ - otra fraccion
	#
	# ==== Examples
	#	fraccion1 + fraccion2	
	def +(other)
		if other.respond_to?("d")
			return Fraccion.new(((mcm(@d, other.d) / @d)*@n) + ((mcm(@d, other.d) / other.d)*other.n),mcm(@d, other.d))
		else
			return Fraccion.new( ((other*@d) + @n), @d)
		end	
	end

	# === Descripcion
	#  Multiplicacion de dos racionales
	# ==== Atributos
	#
	# * +other+ - otra fraccion
	#
	# ==== Examples
	#	fraccion1 * fraccion2	
	def *(other)
		if other.respond_to?("d")
                        return Fraccion.new(@n*other.n, @d*other.d)
                else
                        return Fraccion.new(other*@n,@d)
                end
	end
	
	# === Descripcion
	#  Opuesta de una fraccion
	def -@
		return Fraccion.new(@n*(-1), @d)
	end

	
	def coerce(other)
		v=[self, other]
	end

	# === Descripcion
	#  Modulo comparable para fracciones
	# ==== Atributos
	#
	# * +other+ - otra fraccion
	#
	# ==== Examples
	#	fraccion1 >= fraccion2	
	def <=>(other)
		if other.respond_to?("d")
			self.to_d<=>other.to_d
		else
			self.to_d<=>other
		end
	end
end
