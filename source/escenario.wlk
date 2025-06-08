import wollok.game.*
import cachito.*
import enemigos.*
import musicaFondo.*
import textos.*

object escenario {
  var property elementosEnEscena = []
  
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
}