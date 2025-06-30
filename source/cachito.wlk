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
	var puedeRecibirDaño = true
	var property puedeAtacar = false
	var property tiempoDeInmunidad = 1000
	var property ubicacion = casa
	var property position = game.origin()
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
				self.actualizarImagen()
			}
		)
		//right
		keyboard.d().onPressDo(
			{ 
				if (((limiteLatDer.position().x() - 1) > self.position().x()) && puedeMoverse)
					self.position(self.position().right(1))
				mirandoAl = "E"
				self.actualizarImagen()
			}
		)
		//down
		keyboard.s().onPressDo(
			{ 
				if (((limiteInferior.position().y() + 1) < self.position().y()) && puedeMoverse)
					self.position(self.position().down(1))
				mirandoAl = "S"
				self.actualizarImagen()
			}
		)
		//up
		keyboard.w().onPressDo(
			{ 
				if (((limiteSuperior.position().y() - 1) > self.position().y()) && puedeMoverse)
					self.position(self.position().up(1))
				mirandoAl = "N"
				self.actualizarImagen()
			}
		)
		keyboard.num(1).onPressDo({vida +=1})
	}
	
	method reiniciar() {
		mirandoAl = "S"
		totems.clear()
		tieneInmunidad = false
		estaEnCombate = false
		puedeAtacar = false
		puedeMoverse = true
		puedeRecibirDaño = true
		tiempoDeInmunidad = 1000
		self.vida(4)
		self.ubicacion(casa)
		self.actualizarImagen()
		self.position(game.origin())
	}
	
	method actualizarImagen() {
		if (ubicacion.esExterior()) {
			self.image(("cachito" + mirandoAl) + ".png")
		} else {
			if (self.estaEnElAgua()) self.image(("cachitoB" + mirandoAl) + ".png")
			else self.image(("cachitoInt" + mirandoAl) + ".png")
		}
	}
	
	method estaEnUnExterior() = ubicacion.esExterior()
	
	method estaEnElAgua() = ubicacion.esSalaConAgua() && (self.position().y() < 11)
	
	//COMBATE 
	method atacar() {
		animacionAtaque.iniciar()
		position = game.at(5, 1)
		pomberito.recibirDaño()
	}
	
	method otorgarInmunidad() {
		tieneInmunidad = true
		game.schedule(tiempoDeInmunidad, { tieneInmunidad = false })
	}
	
	method recibirDaño() {
		if ((self.vida() > 0) && (!tieneInmunidad) && puedeRecibirDaño) {
			vida = 0.max(vida - 1)
			barraDeVida.sacarVidas()
			self.otorgarInmunidad()
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
		puedeRecibirDaño = true
	}
	
	method posicionDeAtaque() {
		self.position(game.at(5, 1))
		mirandoAl = "S"
		self.actualizarImagen()
		self.bloquearMovimiento()
		puedeRecibirDaño = false
	}
}

object barraDeVida {
	method mostrarVidas() {
		if (cachito.vida() == 6) {
			game.addVisual(corazon1)
			game.addVisual(corazon2)
			game.addVisual(corazon3)
			game.addVisual(corazon4)
			game.addVisual(corazon5)
			game.addVisual(corazon6)
		} else {
			if (cachito.vida() == 5) {
				game.addVisual(corazon1)
				game.addVisual(corazon2)
				game.addVisual(corazon3)
				game.addVisual(corazon4)
				game.addVisual(corazon5)
				game.addVisual(corazon6)
			} else {
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
		}
	}
	
	method sacarVidas() {
		if (cachito.vida() == 5) {
			game.removeVisual(corazon6)
		} else {
			if (cachito.vida() == 4) {
				game.removeVisual(corazon5)
			} else {
				if (cachito.vida() == 3) {
					game.removeVisual(corazon4)
				} else {
					if (cachito.vida() == 2) game.removeVisual(corazon3)
					else game.removeVisual(corazon2)
				}
			}
		}
	}
}