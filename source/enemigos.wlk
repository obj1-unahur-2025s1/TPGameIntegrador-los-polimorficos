import cachito.*
import objetos.*
import escenario.*
import ubicaciones.*
import escenas.*
import textos.*
import limitadores.*


object pomberito {
  var posicion = game.center()
  var property vida = 4
  method image() = "pomberito.png"
  method position() = posicion
  method derrotado() = vida == 0
  method interaccion() {
    game.sound("grito.mp3").play()
  }
  method iniciar() {
    vida = 4
    game.addVisual(self)
    posicion = game.at(5, 10)
  }
  method duracionAtaque() = 4000
  method recibirDaño() {
      vida -= 1
    }
  method atacar() { 
    escenario.dificultad().ataquePomberito()
  }

}

object pomberitoPoseido {
  var posicion = game.center()
  var property vida = 4
  method image() = "pombePoseido.png"
  method position() = posicion
  method derrotado() = vida == 0
  method interaccion() {
    game.sound("grito.mp3").play()
  }
  method iniciar() {
    vida = 4
    game.addVisual(self)
    posicion = game.at(5, 9)
    self.atacar()
  }
  method duracionAtaque() = 4000
  method recibirDaño() {
      vida -= 1
    }
  method atacar() { 
    escenario.dificultad().ataquePomberitoPoseido()
  }
  method texto() = none
}

object luzMala {
  var property image = "luzMala.png"
  var property position = game.at(5, 8)
  var property contador = 0
  const property espina = new Espina(position = game.at(0,0))
  method totem() = totemL
  method interaccion(){}
  method posicionesTotem() = [
    game.at(2, 3),
    game.at(9, 5),
    game.at(2, 14),
    game.at(9, 14)
  ]
  method ubicarEspina() {
    if(game.hasVisual(espina)){
      game.removeVisual(espina)
    }
    espina.position(totemL.position())
    game.addVisual(espina)
  }
  method ataque() {
    self.flash()
    self.moverTotem()
    game.schedule(1500, { game.removeVisual(flash) })
  }
  
  method moverTotem() {
    escenario.dificultad().moverTotem()
  }
  
  method iniciar() {
    self.animacionEntrada()
    game.addVisual(totemL)
    game.onTick(3000, "atacar", { self.ataque() })
  }

  method animacionEntrada() {
    game.schedule(1000, {self.flashAnimacion()})
    game.schedule(2000, {self.flashAnimacion()})
    game.schedule(4500, {game.addVisual(self)})
  }

  method animacionSalida() {
    game.schedule(1000, {self.flashAnimacion()})
    game.schedule(2000, {self.flashAnimacion()})
    game.schedule(3000, {self.flashAnimacion()})
    game.schedule(3000, {game.removeVisual(self)})
  }
  
  method flash() {
    escenario.dificultad().flashLuzMala()
  }

  method flashAnimacion() {
    game.addVisual(flash)
    const sonido = game.sound("flash.mp3")
    sonido.volume(0.05)
    sonido.play()
    game.schedule(500, { game.removeVisual(flash) })
  }

  method texto() = zonaLuzMala

  method habilitarSalidaDeLaSala(){
    self.animacionSalida()
    game.schedule(3500, {escenario.ubicarEnEscena(puertaSalidaLuzMala, 10,1)}) 
  }

} 

object alien {
  method totem() = totemA
  method ataqueTelequinéctico() {
    if (self.totemEstaALaDerechaDeCachito() and self.cachitoEstaALaIzquierdaDeLaSala()) {
      cachito.position(cachito.position().left(1))
    } else {
      if (self.totemEstaALaIzquierdaDeCachito() and self.cachitoEstaALaIzquierdaDeLaSala()) 
      cachito.position(cachito.position().right(1))
    }
    if (self.totemEstaArribaDeCachito() and self.cachitoEstaAbajoDeLaSala()){
        cachito.position(cachito.position().down(1)) 
    } 
  }

  method totemEstaALaDerechaDeCachito() {
    return
      totemA.position().x() > cachito.position().x()
  }
  method totemEstaALaIzquierdaDeCachito() {
    return
      totemA.position().x() < cachito.position().x()
  }
   method totemEstaArribaDeCachito() {
    return
      totemA.position().y() > cachito.position().y()
   }


  method cachitoEstaALaIzquierdaDeLaSala() {
    return
      cachito.position().x().between(1,9)
  }
  method cachitoEstaAbajoDeLaSala() {
    return
      cachito.position().y().between(2,14)
  }
 
  method iniciar() {  
    self.iniciarAnimacion()
  }
  method texto() = ovniAlien

  method iniciarAnimacion(){
    escenario.animar(true)
    game.addVisual(ovni1)
    self.agregarEspinas()
    self.animacionEntrada()
    game.schedule(3000, {
      game.addVisual(totemA)
      ovniAnimado.animar()
      game.onTick(1000, "atacar", { self.ataqueTelequinéctico() })
    })
  }
  method animacionEntrada(){
    game.schedule(1000, {ovni1.image("animacionO2.png")})
    game.schedule(2000, {ovni1.image("animacionO3.png")})
    game.schedule(3000, {ovni1.image("ov1.png")})
  }

  method animacionSalida(){
    game.schedule(1000, {ovni1.image("animacionO3.png")})
    game.schedule(2000, {ovni1.image("animacionO2.png")})
    game.schedule(3000, {ovni1.image("animacionO1.png")})
    game.schedule(3500, {game.removeVisual(ovni1)})
    game.schedule(3500, {game.removeVisual(ovni2)})
  }
  method habilitarSalidaDeLaSala(){
    escenario.ubicarEnEscena(puertaSalidaAlien, 0,1)
    self.animacionSalida()
  }
  method agregarEspinas() {
    escenario.dificultad().agregarEspinasDelAlien()
  }
} 

object nahuelito {
  var property image = "animacionN1.png"
  var property position = game.origin()
  
  method totem() = totemN
  method texto() = zonaLuzMala
  method perseguirPersonaje() {
    const otraPosicion = cachito.position()
    const newX = position.x() + if (otraPosicion.x() > position.x()) {
      1
    } else {
      if (otraPosicion.x() < position.x()) -1 else 0
    }
    self.actualizarImagen(newX - position.x())
    position = game.at(newX, 0)
  }
  
  method atacar() {
    const ola = new Ola()
    ola.position(self.position())
    ola.disparar()
  }
  
  method ataqueEspecial() {
    const olaRapida = new OlaRapida()
    olaRapida.position(self.position())
    olaRapida.disparar()
  }
  
  method iniciar() {
    game.addVisual(self)
    self.animacionInicio()
    game.addVisual(totemN)
    game.schedule(
      3000,
      { 
        game.onTick(300, "moverse", { self.perseguirPersonaje() })
        escenario.dificultad().ataqueNahuelito()
      }
    )
  }
  
  method actualizarImagen(posicion) {
    if (posicion == 1) {
      image = "nahuelitoD.png"
    } else {
      image = "nahuelitoI.png"
    }
  }
  
  method animacionInicio() {
    game.schedule(1000, { self.image("animacionN2.png") })
    game.schedule(2000, { self.image("nahuelitoI.png") })
  }
  method animacionSalida() {
    game.schedule(1000, { self.image("animacionN2.png") })
    game.schedule(2000, { self.image("animacionN1.png") })
    game.schedule(3000, { game.removeVisual(self) })
  }
  method reiniciar(){
    image = "animacionN1.png"
    position = game.origin()
  }

  method habilitarSalidaDeLaSala(){
    escenario.ubicarEnEscena(puertaSalidaNahuelito, 5,14) 
    self.animacionSalida()
  }
}

object batallaFinal {
  const duracionTurnoPomberito = 6000
  var pomberitoEnBatalla = false
  var turnoCachito = true
  
  method iniciarPelea() {
    cachito.estaEnCombate(true)
    pomberitoEnBatalla = true
    self.habilitarAtaque() 
  
  }
  
  
  method habilitarAtaque() {
    keyboard.f().onPressDo({ self.gestionarAtaque() })
    if (!cachito.derrotado()) {
      cachito.posicionDeAtaque()
      game.addVisual(cartelAtaque)
      turnoCachito = true
    }
  }
  
  method gestionarAtaque() {
    if (self.cachitoPuedeAtacar()) {
      turnoCachito = false
      game.removeVisual(cartelAtaque)
      cachito.atacar()
      game.schedule(9000, { self.golpearPomberito() })
    }
  }

  method cachitoPuedeAtacar() {
    return
      (pomberitoEnBatalla && turnoCachito) && (!cachito.derrotado())
  }
  
  method golpearPomberito() {
    if (pomberito.derrotado()){
      if (escenario.enDificil()){
        cachito.posicionDeDefensa()
        preFinal.iniciar()
      }else{
        finalJuego.iniciar()
      }
    }
    else game.schedule(500, { self.etapaDefensa() })
  }
  
  method etapaDefensa() {
    cachito.posicionDeDefensa()
    pomberito.atacar()
    game.schedule(duracionTurnoPomberito + 50, { self.habilitarAtaque() })
  }
}
