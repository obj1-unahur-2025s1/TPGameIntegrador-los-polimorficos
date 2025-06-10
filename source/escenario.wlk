import wollok.game.*
import cachito.*
import enemigos.*
import musicaFondo.*
import textos.*
import objetos.*

object escenario {
  var property elementosEnEscena = []
  var property animar = false
  const property puertas = [puertaAlPueblo1, puertaIglesia, puertaNahuelito, puertaAlien, puertaLuzMala]
  method cargarListaconElementos() {
    elementosEnEscena = game.allVisuals()
  }
  
  method borrarTodaLaListaDeelementos() {
    elementosEnEscena.forEach({ a => game.removeVisual(a) })
    elementosEnEscena.clear()
  }
  
  method borrarEscena() {
    self.cargarListaconElementos()
    self.borrarTodaLaListaDeelementos()
  }
  
  method iniciarEscena(unaUbicacion, textoUbicacion) {
    self.borrarEscena()
    game.addVisual(unaUbicacion)
    game.addVisual(textoUbicacion)
  }
  
  method ubicarEnEscena(elementoA, x, y) {
    game.addVisual(elementoA)
    elementoA.ubicarEn(x, y)
  }
  
  method colocarJugadorEn(x, y) {
    game.addVisual(cachito)
    cachito.poscionarEn(game.at(x, y))
  }
  method actualizarPuertas() {
    puertas.forEach({ puerta => puerta.actualizarImagen() })
  }

  method animarCartel(c1, c2){
    if (game.hasVisual(c1) && animar) {
      game.removeVisual(c1)
      game.addVisual(c2)
      game.schedule(600,{ self.animarCartel(c1,c2) })
    } else if (game.hasVisual(c2) && animar) {
      game.removeVisual(c2)
      game.addVisual(c1)
      game.schedule(600, { self.animarCartel(c1,c2) })
    }
  }

  method detenerAnimacion(c1,c2) {
    animar = false
    if (game.hasVisual(c1)) game.removeVisual(c1)
    if (game.hasVisual(c2)) game.removeVisual(c2)
  }

}