import objetos.*
import musicaFondo.*
import escenario.*
import enemigos.*
import escenas.*
object cachito {
    var property vida = 4
    const totems = #{}
	var mirandoAl = "S"
	var property ubicacion = casa
	var property position = game.origin()
	const sonido = game.sound("juira.mp3")
	var property image = "cachitoIntS.png"
    method agregarTotem(totem) {
      totems.add(totem)
    }
    method saludar() {
		sonido.volume(0.05)
		sonido.play()
		game.say(self,"JUIRA BICHO")
    }
    method derrotoA(enemigo) = totems.contains(enemigo.totem())
    method enemigosDerrotados() = totems.size()
	method poscionarEn(nuevaPosicion) {
		self.position(nuevaPosicion)
	}
	method configurarTeclas() {
		//Left
		keyboard.a().onPressDo({ 
			if(topeLatIzq.position().x()+1 < self.position().x() )
				self.position(self.position().left(1))
				mirandoAl = "O"
				self.actualizarImagen()
			})
		//right
		keyboard.d().onPressDo({
			if(topeLatDer.position().x()-1 > self.position().x())
			 	self.position(self.position().right(1))
				mirandoAl = "E"
				self.actualizarImagen()
			 })
		//down
		keyboard.s().onPressDo({ 
			if(topeInferior.position().y()+1 < self.position().y())
				self.position(self.position().down(1))
				mirandoAl = "S"
				self.actualizarImagen()
			})
		//up
		keyboard.w().onPressDo({
			if(topeSuperior.position().y()-1 > self.position().y())
			 	self.position(self.position().up(1))
				mirandoAl = "N"
				self.actualizarImagen()				
			 })
		keyboard.enter().onPressDo({self.saludar() })

		//TECLAS A ELIMINAR EN LA VERSION FINAL:
		keyboard.num(1).onPressDo({ self.agregarTotem(alien.totem()) })
    	keyboard.num(2).onPressDo({ self.agregarTotem(nahuelito.totem()) })
    	keyboard.num(3).onPressDo({ self.agregarTotem(luzMala.totem()) })
    	keyboard.num(4).onPressDo({musicaFondo.detener()})
		keyboard.num(5).onPressDo({game.say(self,"A" + escenario.elementosEnEscena())})
		keyboard.num(6).onPressDo({game.say(self,"A" + self.position())})
		keyboard.num(7).onPressDo({game.say(self,"Totems" + totems)})
		keyboard.num(8).onPressDo({game.say(self,"X" + position.x())})	 	 	 
	}
	method reiniciar(){
		self.vida(4)
		self.ubicacion(casa)
		mirandoAl = "S"
		self.actualizarImagen()
		self.position(game.origin())
		totems.clear()
	}

	method actualizarImagen(){
		if(self.estaEnUnExterior()){
			self.image("cachito" + mirandoAl + ".png")
		}
		else{
			self.image("cachitoInt" + mirandoAl + ".png")
		}
	}
	method estaEnUnExterior(){
		return [pueblo].contains(ubicacion)
	}

	method recibirDanio() {
		if(self.vida() > 0) {
			vida -=1
			if(self.vida() == 0) {
				pantallaGameOver.iniciar()
			}
		}
	}	
}


object vida {
  method mostrarVidas() {
	if(cachito.vida() ==4){
		game.addVisual(corazon1)
		game.addVisual(corazon2)
		game.addVisual(corazon3)
		game.addVisual(corazon4)
	}
	else if(cachito.vida() ==3){
		game.addVisual(corazon1)
		game.addVisual(corazon2)
		game.addVisual(corazon3)
	}
	else if(cachito.vida() ==2){
		game.addVisual(corazon1)
		game.addVisual(corazon2)
	}
	else
		game.addVisual(corazon1)
  }

  method sacarVidas() {
	if(cachito.vida() ==3){
		game.removeVisual(corazon4)
	}
	else if(cachito.vida() ==2){
		game.removeVisual(corazon3)
	}
	else{
		game.removeVisual(corazon2)
	}
  }
}