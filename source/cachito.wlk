import objetos.*
import musicaFondo.*
import escenario.*
import enemigos.*
object cachito {
    var property vida = 4
    const totems = #{}
	var property position = game.origin()
	const sonido = game.sound("juira.mp3")
	var property image = "cachitoIntE.png"
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
			})
		//right
		keyboard.d().onPressDo({
			if(topeLatDer.position().x()-1 > self.position().x())
			 	self.position(self.position().right(1))

			 })
		//down
		keyboard.s().onPressDo({ 
			if(topeInferior.position().y()+1 < self.position().y())
				self.position(self.position().down(1))

			})
		//up
		keyboard.w().onPressDo({
			if(topeSuperior.position().y()-1 > self.position().y())
			 	self.position(self.position().up(1))
			 })
		keyboard.enter().onPressDo({self.saludar() })

		//TECLAS A ELIMINAR EN LA VERSION FINAL:
		keyboard.num(1).onPressDo({ self.agregarTotem("lm") })
    	keyboard.num(2).onPressDo({ self.agregarTotem("a") })
    	keyboard.num(3).onPressDo({ self.agregarTotem("nh") })
    	keyboard.num(4).onPressDo({musicaFondo.detener()})
		keyboard.num(5).onPressDo({game.say(self,"A" + escenario.elementosEnEscena())})
		keyboard.num(6).onPressDo({game.say(self,"A" + self.position())})
		keyboard.num(7).onPressDo({game.say(self,"Totems" + totems)})	 	 
	}
	method reiniciar(){
		self.vida(4)
		self.image("cachitoInt.png")
		self.position(game.origin())
		totems.clear()
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