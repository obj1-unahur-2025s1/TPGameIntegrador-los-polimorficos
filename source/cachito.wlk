import items.*

object cachito {
    var property vida = 4
    const totems = #{}
	var skin = a1
    var lugar = game.at(7, 11)
	const sonido = game.sound("juira.mp3")
	var property imagen = skin.aspecto()
    method image() = imagen
    method agregarTotem(totem) {
      totems.add(totem)
    }
    method position() = lugar
    method position(nueva) {
      lugar = nueva
    }
    method saludar() {
		sonido.volume(0.05)
		sonido.play()
		game.say(self,"JUIRA BICHO")
    }
    method derrotoA(enemigo) = totems.contains(enemigo.totem())
    method enemigosDerrotados() = totems.size()
	method aspecto(nuevo){
		skin = nuevo
	}
}

object a1{
	method aspecto() =  "cachitoInt.png"
}
object a2{
	method aspecto() =  "cachito.png"
}
//POR ALGUN MOTIVO NO SE MUESTRA LA BARRA DE VIDA, NO SE PORQUE
object barraDeVida {
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