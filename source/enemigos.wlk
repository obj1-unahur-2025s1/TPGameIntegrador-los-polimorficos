import cachito.*
import objetos.*
import escenario.*
import ubicaciones.*
import escenas.*

object pomberito {
  var posicion = game.center()
  var vida = 4
  var escenarioPar = true
  var derrotado = false
  method image() = "pomberito.png"
  method position() = posicion
  method derrotado() = derrotado
  method interaccion() {
    game.sound("grito.mp3").play()
  }
  method perseguirPersonaje() {
    const otraPosicion = cachito.position()
    const newX = posicion.x() + if (otraPosicion.x() > posicion.x()) {
      1
    } else {
      if (otraPosicion.x() < posicion.x()) -1 else 0
    }
    const newY = posicion.y() + if (otraPosicion.y() > posicion.y()) {
      1
    } else {
      if (otraPosicion.y() < posicion.y()) -1 else 0
    }
    posicion = game.at(newX, newY)
  }
  
  method escenarioPar(estado) {
    escenarioPar = estado
  }
  
  method iniciar() {
    game.addVisual(self)
    if (cachito.habloConElViejo()) {
      game.onTick(333, "atacar", { self.perseguirPersonaje() })
    } else {
      posicion = game.at(5, 10)
    }
    // game.onTick(3000,"atacar",{self.rotarTotem()})
  }
  
  method cinematica() = escenaPomberito
  method duracionAtaque() = 4000
  method recibirDanio() {
    if (!derrotado) {
      vida = 1.max(vida - 1)
    }
    if (vida == 0) {
      derrotado = true
    }
  }
  
  method atacar() {
    const ola = new Ola()
    ola.position(self.position())
    ola.disparar()
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
object luzMala { 
  var property image = "luzMala2.png"
  var property position = game.at(5,8)
  var contador = 0
  method totem() = totemL
  method posicionesTotem() = [game.at(2,3), game.at(9,5), game.at(2,14), game.at(9,14)]
  method ataque(){
    self.flash()
    self.moverTotem()
    game.schedule(2500, {game.removeVisual(flash)})
  }
  method moverTotem() {
    contador += 1
    totemL.position(self.posicionesTotem().anyOne()) //self.posicionesTotem().get(contador % 4) para que no sea al azar
  }

  method iniciar(){
    game.addVisual(self)
    game.addVisual(totemL)
    game.onTick(2000, "atacar", {self.ataque()})
  }
  method flash(){
    game.addVisual(flash)
    const sonido = game.sound("flash.mp3")
    sonido.volume(0.25)
    sonido.play()
  }
}
//Alien
object alien {
  //method posicionesTotem() = [game.at(2,4), game.at(2,2), game.at(2,5), game.at(1,14)] //agregar posiciones
  method totem() = totemA
  method ataqueTelequinéctico(){
		if(totemA.position().x() > cachito.position().x() and cachito.position().x().between(1, 9)) 
        cachito.position(cachito.position().left(1))
      else if (totemA.position().x() < cachito.position().x() and cachito.position().x().between(1, 9)) 
        cachito.position(cachito.position().right(1))
      
		if(totemA.position().y() > cachito.position().y() and cachito.position().y().between(1, 14)){
        if (cachito.position().y() - 1 != 0) cachito.position(cachito.position().down(1))
    }else if (totemA.position().y() < cachito.position().y() and cachito.position().y().between(1, 14)) 
        cachito.position(cachito.position().up(1))
    
  }
  method iniciar() {
    game.addVisual(totemA)
    game.onTick(1000, "atacar", {self.ataqueTelequinéctico()})
  }
}
//Nahuelito
object nahuelito {
  var property image = "animacionN1.png"
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
    self.animacionInicio()
    game.addVisual(totemN)
    game.schedule(3000, {
      game.onTick(300, "moverse", {self.perseguirPersonaje()})
      game.onTick(700,"atacar",{self.atacar()})
      game.onTick(3500,"atacar",{self.ataqueEspecial()})
    })
  }

  method actualizarImagen(posicion) {
    if (posicion == 1) {
      image = "nahuelitoD.png" 
    }
    else image = "nahuelitoI.png"
  }

  method animacionInicio() {
    game.schedule(1000, {self.image("animacionN2.png")})
    game.schedule(2000, {self.image("nahuelitoI.png")})
  }

}