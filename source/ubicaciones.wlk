import escenas.*
import wollok.game.*
import cachito.*
import enemigos.*
import musicaFondo.*
import textos.*
import objetos.*
import escenario.*
import limitadores.*

object casa {
  const property image = "casa.png"
  var property position = game.origin()
  
  method iniciar() {
    game.removeVisual(spaceParaContinuar1)
    musicaFondo.cambiarAPista(1)
    escenario.iniciarEscena(self, casaCachito)
    escenario.ubicarEnEscena(puertaSalidaCasa, 5, 1)
    escenario.colocarJugadorEn(7, 8)
    escenario.ubicarEnEscena(limiteSuperior, 0, 15)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, 0, 0)
    barraDeVida.mostrarVidas()
    limitadores.agregarLimitadoresEnCasa()
  }

}
object pueblo {
  const property image = "pueblo3.png"
  var property position = game.origin()
  var property x = 5
  var property y = 8
  method iniciar() {
    musicaFondo.detener()
    escenario.iniciarEscena(self, teroViolado)
    cachito.ubicacion(self)
    cachito.actualizarImagen()
    escenario.colocarJugadorEn(x,y)
    escenario.ubicarEnEscena(puertaIglesia, 5, 11)
    if(not cachito.derrotoA(alien)) escenario.ubicarEnEscena(puertaAlien, 10,8)
    if(not cachito.derrotoA(luzMala))escenario.ubicarEnEscena(puertaLuzMala, 0,8)
    if(not cachito.derrotoA(nahuelito))escenario.ubicarEnEscena(puertaNahuelito, 5,0)
    escenario.ubicarEnEscena(limiteSuperior, 0, 13)
    escenario.ubicarEnEscena(limiteInferior, 0, -1)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, -1, 0)
    barraDeVida.mostrarVidas()
    self.agregarPersonajeAleatorio()
    limitadores.agregarLimitadoresEnPueblo()
  }
  method imagenPuerta() = "puertaAlPueblo.png"
  method interaccion(){
    game.schedule(2000, {
      self.iniciar() 
    })
  }

  method agregarPersonajeAleatorio() {
    if(cachito.enemigosDerrotados() === 3) {
      escenario.elegirPersonaje()
    }
    
  }  
}

object iglesia {
  const property image = "iglesia.png"
  method imagenPuerta() = if (cachito.enemigosDerrotados() == 3) "pIglesia.png" else "pIglesiaB.png"
  var property position = game.origin()
  method iniciar() {
    escenario.iniciarEscena(self, iglesiaTeroViolado)
    cachito.ubicacion(self)
    batallaFinal.iniciarPelea()
    pomberito.iniciar()
    escenario.colocarJugadorEn(5,1)
    cachito.actualizarImagen()
    escenario.ubicarEnEscena(limiteSuperior, 0, 2)
    escenario.ubicarEnEscena(limiteInferior, 0, -1)
    escenario.ubicarEnEscena(limiteLatDer, 10, 0)
    escenario.ubicarEnEscena(limiteLatIzq, 0, 0) 
    barraDeVida.mostrarVidas()
  }
  method interaccion(){
    if (cachito.enemigosDerrotados() < 3) 
      game.say(puertaIglesia, "Necesitas derrotar a: " + 
      (3 - cachito.enemigosDerrotados()) + " enemigos más para poder pasar")
    else{
      game.schedule(1000, {escenaPomberito.iniciar() })
      cachito.ubicacion(self)
    }
  }
}

object salaAlien {
  const property image = "fondoAlien.png" //Hacer el fondo
  var property position = game.origin()
  method imagenPuerta() = "palien.png"
  method iniciar() {
    musicaFondo.cambiarAPista(2)
    //cachito.ubicacion(self)
    escenario.iniciarEscena(self, ovniAlien)
    escenario.colocarJugadorEn(0, 1)
    cachito.actualizarImagen()
    escenario.ubicarEnEscena(limiteSuperior, 0, 12)
    escenario.ubicarEnEscena(limiteInferior, 0, 0)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, -1, 0)
    barraDeVida.mostrarVidas()
    escenario.animar(true)
    game.addVisual(ovni1)
    cachito.bloquearMovimiento()
    self.iniciarAnimacion()
    game.schedule(3000, {alien.iniciar()})
    game.schedule(3000, {ovniAnimado.animar()})
    game.schedule(3000, {cachito.activarMovimiento()})
  }
  
  method interaccion() {
    cachito.ubicacion(self)
    game.schedule(1000, {
      self.iniciar() })
  }
    method salidaDeLaSala(){
    if (cachito.ubicacion() == self) {
        escenario.ubicarEnEscena(puertaSalidaAlien, 0,1)
    }
  }
  method iniciarAnimacion() {
    game.schedule(1000, {ovni1.image("animacionO2.png")})
    game.schedule(2000, {ovni1.image("animacionO3.png")})
    game.schedule(3000, {ovni1.image("ov1.png")})
  }
}

object salaNahuelito {
  const property image = "fondoNahuelito.png"
  var property position = game.origin()
  method imagenPuerta() =  "pNahue.png"
  method iniciar() {
    escenario.iniciarEscena(self, costaNahuelito)
    escenario.colocarJugadorEn(5, 14)
    cachito.actualizarImagen()
    escenario.ubicarEnEscena(limiteInferior, 0, 0)
    escenario.ubicarEnEscena(limiteSuperior, 0, 15)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, -1, 0)
    cachito.bloquearMovimiento()
    game.schedule(3000, {cachito.activarMovimiento()})
    nahuelito.iniciar()
    barraDeVida.mostrarVidas()
  }
  method interaccion() {
    cachito.ubicacion(self)
      game.schedule(1000, {
        self.iniciar() })
  }
  method salidaDeLaSala(){
    if (cachito.ubicacion() == self) {
        escenario.ubicarEnEscena(puertaSalidaNahuelito, 5,14)
    }
  }
}

object salaLuzMala {
  const property image = "fondoLuzMala.png" 
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(luzMala)) "pluzMalaB.png" else "pluzMala.png"
  
  method iniciar() {
    escenario.iniciarEscena(self, zonaLuzMala)
    escenario.colocarJugadorEn(10, 1)
    cachito.actualizarImagen()
    escenario.ubicarEnEscena(limiteSuperior, 0, 15)
    escenario.ubicarEnEscena(limiteInferior, 0, 0)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, -1, 0)
    barraDeVida.mostrarVidas()
    cachito.bloquearMovimiento()
    game.schedule(3000, {cachito.activarMovimiento()})
    luzMala.iniciar()
  }
  
  method interaccion() {
    if (self.imagenPuerta() == "pluzMalaB.png") {
      game.say(puertaLuzMala, "No podes pasar, ya derrotaste a la Luz Mala")
    } else {
    cachito.ubicacion(self)
     game.schedule(1000, {
        self.iniciar() })
    }
  }
  method salidaDeLaSala(){
    if (cachito.ubicacion() == self) {
      escenario.ubicarEnEscena(puertaSalidaLuzMala, 10,1) 
    }
  }
}