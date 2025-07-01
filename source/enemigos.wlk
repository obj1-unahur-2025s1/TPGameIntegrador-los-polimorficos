import cachito.*
import objetos.*
import escenario.*
import ubicaciones.*
import escenas.*
import textos.*

object pomberito {
  var posicion = game.center()
  var vida = 4  
  method vida() = vida 
  method image() = "pomberito.png"
  method position() = posicion
  method derrotado() = vida == 0
  method interaccion() {
    game.sound("grito.mp3").play()
  }
  method iniciar() {
    game.addVisual(self)
    posicion = game.at(5, 10)
    vida = 4
  }
  method duracionAtaque() = 4000
  method recibirDaño() {
      vida -= 1
    }
  method atacar() { 
        const ataques = [1,2,3,4]
    if(ataques.anyOne() == 1){
      self.ataque1()
    }
    else if(ataques.anyOne() == 2){
      self.ataque2()
    }
    else if(ataques.anyOne() == 3){
      self.ataque3()
    }
    else
      self.ataque4()
  }
  method ataque1(){
        self.paredCentral()
        game.schedule(5000, { 
          const roca = new RocaAbajo(vel = 100,x=cachito.position().x(),y=9) 
          roca.position(self.position())
          roca.disparar()
          })

  }
  method ataque2(){
        self.paredConHuecosYDesface(0, 7)
        self.paredConHuecosYDesface(1, 9)
        self.paredConHuecosYDesface(0, 11)
  }
  method ataque3(){
    game.onTick(200, "ataque3Pomberito", {
      const roca = new RocaAbajo(vel = 100,x=[0,1,2,3,4,5,6,7,8,9,10].anyOne(),y=9) 
          roca.position(self.position())
          roca.disparar() })
    game.schedule(5500, {game.removeTickEvent("ataque3Pomberito")})
  }
  method ataque4(){
    game.onTick(750, "ataque4Pomberito", {
      const roca = new RocaAbajo(vel = 100,x=cachito.position().x(),y=9) 
          roca.position(self.position())
          roca.disparar()
      const roca1 = new RocaIzq(vel = 250,x=1,y=7) 
          roca1.position(self.position())
          roca1.disparar()
      const roca2 = new RocaDer(vel = 250,x=10,y=7) 
          roca2.position(self.position())
          roca2.disparar() })
          
    game.schedule(5500, {game.removeTickEvent("ataque4Pomberito")})
  }

  method paredCentral(){
        const roca1 = new RocaAbajo(vel = 150,x=2,y=9)
    roca1.position(self.position())
    roca1.disparar()
        const roca4 = new RocaAbajo(vel = 150,x=3,y=9)
    roca4.position(self.position())
    roca4.disparar()
        const roca = new RocaAbajo(vel = 150,x=4,y=9)
    roca.position(self.position())
    roca.disparar()
        const roca2 = new RocaAbajo(vel = 150,x=5,y=9)
    roca2.position(self.position())
    roca2.disparar()
        const roca3 = new RocaAbajo(vel = 150,x=6,y=9)
    roca3.position(self.position())
    roca3.disparar()
        const roca5 = new RocaAbajo(vel = 150,x=7,y=9)
    roca5.position(self.position())
    roca5.disparar()

  }
  
  method paredConHuecosYDesface(x,y){
        const roca = new RocaAbajo(x=0+x,y=y)
    roca.position(self.position())
    roca.disparar()
        const roca2 = new RocaAbajo(x=2+x,y=y)
    roca2.position(self.position())
    roca2.disparar()
        const roca3 = new RocaAbajo(x=4+x,y=y)
    roca3.position(self.position())
    roca3.disparar()
        const roca4 = new RocaAbajo(x=6+x,y=y)
    roca4.position(self.position())
    roca4.disparar()
        const roca5 = new RocaAbajo(x=8+x,y=y)
    roca5.position(self.position())
    roca5.disparar()
        const roca6 = new RocaAbajo(x=10+x,y=y)
    roca6.position(self.position())
    roca6.disparar()
        const roca7 = new RocaAbajo(x=12+x,y=y)
    roca7.position(self.position())
    roca7.disparar()
        const roca8 = new RocaAbajo(x=14+x,y=y)
    roca8.position(self.position())
    roca8.disparar()
  }

}

object luzMala {
  var property image = "luzMala.png"
  var property position = game.at(5, 8)
  var contador = 0
  method totem() = totemL
  method interaccion(){}
  method posicionesTotem() = [
    game.at(2, 3),
    game.at(9, 5),
    game.at(2, 14),
    game.at(9, 14)
  ]
  
  method ataque() {
    self.flash()
    self.moverTotem()
    game.schedule(1500, { game.removeVisual(flash) })
  }
  
  method moverTotem() {
    contador += 1
    totemL.position(self.posicionesTotem().anyOne())
  }
  
  method iniciar() {
    game.addVisual(self)
    game.addVisual(totemL)
    game.onTick(3000, "atacar", { self.ataque() })
  }
  
  method flash() {
    game.addVisual(flash)
    const sonido = game.sound("flash.mp3")
    sonido.volume(0.05)
    sonido.play()
  }

  method texto() = zonaLuzMala

  method habilitarSalidaDeLaSala(){
    escenario.ubicarEnEscena(puertaSalidaLuzMala, 10,1) 
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
  method habilitarSalidaDeLaSala(){
    escenario.ubicarEnEscena(puertaSalidaAlien, 0,1)
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
        game.onTick(700, "atacar", { self.atacar() })
        game.onTick(3500, "atacar", { self.ataqueEspecial() })
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
  method reiniciar(){
    image = "animacionN1.png"
    position = game.origin()
  }

  method habilitarSalidaDeLaSala(){
    escenario.ubicarEnEscena(puertaSalidaNahuelito, 5,14) 
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
    if (pomberito.derrotado()) finalJuego.iniciar()
    else game.schedule(500, { self.etapaDefensa() })
  }
  
  method etapaDefensa() {
    cachito.posicionDeDefensa()
    pomberito.atacar()
    game.schedule(duracionTurnoPomberito + 50, { self.habilitarAtaque() })
  }
}