import cachito.*
import objetos.*

object pomberito {
  var posicion = game.center()
  //const totemP = new Totem(image = "totemLuzMala.png", position = self.position().down(2))
 // var direccion = abajo
  method image() = "pomberito.png"
  method position() = posicion
  method interaccion() {
    game.sound("grito.mp3").play()
    
  }

  //method direccionTotem() = [arriba,abajo,izquierda,derecha]
  //method direccionActual() = totemP.position()
  method perseguirPersonaje() {
    const otraPosicion = cachito.position()
    const newX = posicion.x() + (if (otraPosicion.x() > posicion.x()) 1 
      else if (otraPosicion.x() < posicion.x()) -1
      else 0)
    const newY = posicion.y() + (if (otraPosicion.y() > posicion.y()) 1 
      else if (otraPosicion.y() < posicion.y()) -1 
      else 0)
    posicion = game.at(newX, newY)
    //direccion.reposicionar(totemP)
  }
 /* method rotarTotem(){
    direccion = self.direccionTotem().anyOne()
  }*/

  method iniciar(){
    game.addVisual(self)
    //game.addVisual(totemP)
    game.onTick(333, "atacar", {self.perseguirPersonaje()})
   // game.onTick(3000,"atacar",{self.rotarTotem()})

  }
}
object arriba{
  method reposicionar(totem){
    totem.position(pomberito.position().up(2))
  }
}

object abajo{
  method reposicionar(totem){
    totem.position(pomberito.position().down(2))
  }
}

object izquierda{
  method reposicionar(totem){
    totem.position(pomberito.position().left(2))
  }
}

object derecha{
  method reposicionar(totem){
    totem.position(pomberito.position().right(2))
  }
}



//Luz Mala
object luzMala { //Agregar flash en blanco

  var property image = "corazonFull.png"
  var property position = game.at(1,16)
  var contador = 0
  
  
  method totem() = totemL

  method posicionesTotem() = [game.at(1,1), game.at(9,1), game.at(1,14), game.at(9,14)]

  method moverTotem() {
    contador += 1
    totemL.position(self.posicionesTotem().anyOne()) //self.posicionesTotem().get(contador % 4) para que no sea al azar
  }

  method iniciar(){
    game.addVisual(self)
    game.addVisual(totemL)
    game.onTick(1000, "atacar", {self.moverTotem()})

  }

}
//Alien
object alien {
  var property image = "alien.png"
  var property position = game.at(9,9)
  
  method posicionesTotem() = [game.at(2,4), game.at(2,2), game.at(2,5), game.at(1,14)] //agregar posiciones
  method totem() = totemA

  method ataqueTelequinéctico(){
		if(totemA.position().x() > cachito.position().x() and cachito.position().x().between(1, 9)) 
        cachito.position(cachito.position().left(1))
      else if (totemA.position().x() < cachito.position().x() and cachito.position().x().between(1, 9)) 
        cachito.position(cachito.position().right(1))
      
		if(totemA.position().y() > cachito.position().y() and cachito.position().y().between(1, 14)) 
        cachito.position(cachito.position().down(1))
      else if (totemA.position().y() < cachito.position().y() and cachito.position().y().between(1, 14)) 
        cachito.position(cachito.position().up(1))
    
  }

  method iniciar() {
    game.addVisual(self)
    game.addVisual(totemA)
    game.onTick(500, "atacar", {self.ataqueTelequinéctico()})
  }
}
//Nahuelito
object nahuelito {
  var property image = "nahuelitoD.png"
  var property position = game.origin()
  method totem() = totemN

    method perseguirPersonaje() {
		const otraPosicion = cachito.position()
		const newX = position.x() + (if (otraPosicion.x() > position.x()) 1  
      else if (otraPosicion.x() < position.x()) -1
      else 0)
    self.actualizarImagen(newX - position.x())
		position = game.at(newX,0)
  }
  method atacar(){
    const ola = new Ola()
    ola.position(self.position())
		ola.disparar()
  }

  method ataqueEspecial(){
    const olaRapida = new OlaRapida()
    olaRapida.position(self.position())
		olaRapida.disparar()
  }

  method iniciar(){
    game.addVisual(self)
    game.addVisual(totemN)
    game.onTick(300, "moverse", {self.perseguirPersonaje()})
    game.onTick(700,"atacar",{self.atacar()})
    game.onTick(3500,"atacar",{self.ataqueEspecial()})
  }

  method actualizarImagen(posicion) {
    if (posicion == 1) {
      image = "nahuelitoD.png" 
    }
    else image = "nahuelitoI.png"
  }

}