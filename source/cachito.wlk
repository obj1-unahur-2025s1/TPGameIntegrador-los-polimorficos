import objetos.*
import musicaFondo.*
import escenario.*
import enemigos.*
import ubicaciones.*
import escenas.*

object cachito {
	var property vida = 4
	const totems = #{}
	var mirandoAl = "S"
	var tieneInmunidad = false
	var estaEnCombate = false
	var puedeMoverse = true
	var derrotado = false
	var property ubicacion = casa
	var property position = game.origin()
	var property habloConElViejo = false
	var property puedeAtacar = false
	var property image = "cachitoIntS.png"
	
	method derrotado() = derrotado

	method tieneInmunidad() = tieneInmunidad
	
	method estaEnCombate(estado) {
		estaEnCombate = estado
	}
	
	method agregarTotem(totem) {
		totems.add(totem)
	}
	
	method derrotoA(enemigo) = totems.contains(enemigo.totem())
	
	method enemigosDerrotados() = totems.size()
	
	method poscionarEn(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	
	method configurarTeclas() {
		//Left
		keyboard.a().onPressDo(
			{ 
				if (((limiteLatIzq.position().x() + 1) < self.position().x()) && puedeMoverse)
					self.position(self.position().left(1))
				mirandoAl = "O"
				return self.actualizarImagen()
			}
		)
		//right
		keyboard.d().onPressDo(
			{ 
				if (((limiteLatDer.position().x() - 1) > self.position().x()) && puedeMoverse)
					self.position(self.position().right(1))
				mirandoAl = "E"
				return self.actualizarImagen()
			}
		)
		//down
		keyboard.s().onPressDo(
			{ 
				if (((limiteInferior.position().y() + 1) < self.position().y()) && puedeMoverse)
					self.position(self.position().down(1))
				mirandoAl = "S"
				return self.actualizarImagen()
			}
		)
		//up
		keyboard.w().onPressDo(
			{ 
				if (((limiteSuperior.position().y() - 1) > self.position().y()) && puedeMoverse)
					self.position(self.position().up(1))
				mirandoAl = "N"
				return self.actualizarImagen()
			}
		)
		//ELIMINAR PARA LA VERSION FINAL
		keyboard.num(1).onPressDo({ self.agregarTotem(alien.totem()) })
		keyboard.num(2).onPressDo({ self.agregarTotem(nahuelito.totem()) })
		keyboard.num(3).onPressDo({ self.agregarTotem(luzMala.totem()) })
		keyboard.num(4).onPressDo({ musicaFondo.detener() })
		keyboard.num(5).onPressDo(
			{ game.say(self, "A" + escenario.elementosEnEscena()) }
		)
		keyboard.num(6).onPressDo({ game.say(self, "A" + self.position()) })
		keyboard.num(7).onPressDo({ game.say(self, "Totems" + totems) })
		keyboard.num(8).onPressDo({ game.say(self, "En Menu: " + escenario.enMenu() + "En controles: " + escenario.enControles()) })
	}
	
	method reiniciar() {
		mirandoAl = "S"
		totems.clear()
		tieneInmunidad = false
		estaEnCombate = false
		puedeAtacar = false
		puedeMoverse = true
		self.vida(4)
		self.ubicacion(casa)
		self.actualizarImagen()
		self.position(game.origin())
	}
	
	method actualizarImagen() {
		if (self.estaEnUnExterior()) {
			self.image(("cachito" + mirandoAl) + ".png")
		} else {
			if (self.estaEnElAgua()) self.image(("cachitoB" + mirandoAl) + ".png")
			else self.image(("cachitoInt" + mirandoAl) + ".png")
		}
	}
	
	method estaEnUnExterior() = [pueblo].contains(ubicacion)
	
	method estaEnElAgua() = [salaNahuelito].contains(
		ubicacion
	) && (self.position().y() < 11)
	
	//COMBATE 
	method atacar() {
		animacionAtaque.iniciar()
		position = game.at(5, 1)
		pomberito.recibirDaño()
	}
	
	method otorgarInmunidad(tiempo) {
		tieneInmunidad = true
		game.schedule(tiempo, { tieneInmunidad = false })
	}
	
	method recibirDaño() {
		if ((self.vida() > 0) && (!tieneInmunidad)) {
			vida = 0.max(vida - 1)
			barraDeVida.sacarVidas()
			self.otorgarInmunidad(1000)
		}
		if (self.vida() == 0) {
			derrotado = true
			pantallaGameOver.iniciar()
		}
	}
	
	method bloquearMovimiento() {
		puedeMoverse = false
	}
	
	method activarMovimiento() {
		puedeMoverse = true
	}
	
	method posicionDeDefensa() {
		mirandoAl = "N"
		self.actualizarImagen()
		self.activarMovimiento()
	}
	
	method posicionDeAtaque() {
		self.position(game.at(5, 1))
		mirandoAl = "S"
		self.actualizarImagen()
		self.bloquearMovimiento()
	}
}

object barraDeVida {
	method mostrarVidas() {
		if (cachito.vida() == 4) {
			game.addVisual(corazon1)
			game.addVisual(corazon2)
			game.addVisual(corazon3)
			game.addVisual(corazon4)
		} else {
			if (cachito.vida() == 3) {
				game.addVisual(corazon1)
				game.addVisual(corazon2)
				game.addVisual(corazon3)
			} else {
				if (cachito.vida() == 2) {
					game.addVisual(corazon1)
					game.addVisual(corazon2)
				} else {
					game.addVisual(corazon1)
				}
			}
		}
	}
	
	method sacarVidas() {
		if (cachito.vida() == 3) {
			game.removeVisual(corazon4)
		} else {
			if (cachito.vida() == 2) game.removeVisual(corazon3)
			else game.removeVisual(corazon2)
		}
	}
}