import escenas.*
import wollok.game.*
import cachito.*
import enemigos.*
import musicaFondo.*
import textos.*
import objetos.*
import escenario.*
import limitadores.*
import cinematicas.*
import salasEnemigos.*
object casa {
  const property image = "casa.png"
  var property position = game.origin()
  
  method iniciar() {
    accionesTeclas.pantallaValida(false)
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
  method esExterior() = false
  method esSalaConAgua() = false

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
  method esExterior() = true
  method esSalaConAgua() = false  
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
      game.schedule(200, {escenaPomberito1.iniciar() musicaFondo.iniciar(4)})
      cachito.ubicacion(self)
    }
  }
  method esExterior() = false
  method esSalaConAgua() = false
}

const salaLuzMala = new SalaEnemigo(
  enemigo = luzMala,
  pista = null,
  jugadorX = 10,
  jugadorY = 1,
  lSup = 15,
  lInf = 0,
  lDer = 11,
  lIzq = -1
)

const salaNahuelito = new SalaEnemigo(
  enemigo = nahuelito,
  pista = null,
  tieneAgua = true,
  jugadorX = 5,
  jugadorY = 14,
  lSup = 15,
  lInf = 0,
  lDer = 11,
  lIzq = -1
)

object salaAlien {
  const property image = "fondoSala-alien.png" //Hacer el fondo
  var property position = game.origin()
  method imagenPuerta() = "puerta-alien.png"
  method iniciar() {
    musicaFondo.cambiarAPista(2)
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
