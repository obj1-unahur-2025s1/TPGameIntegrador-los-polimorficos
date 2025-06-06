import wollok.game.*
import cachito.*
import enemigos.*
import musicaFondo.*
import pueblo.*
import iglesia.*
import casa.*

object visibles {
 var property listaDeVisualesEnEscena =[]

  method cargarListaconVisuales() {
    listaDeVisualesEnEscena.forEach({a=>game.addVisual(a)})
    listaDeVisualesEnEscena.add(cachito)
  }

  method borrarTodaLaListaDeVisuales() {

    listaDeVisualesEnEscena.forEach({a=>game.removeVisual(a)})
    listaDeVisualesEnEscena.clear()
  }
  method colocarJugadorEn(x, y) {
    cachito.position(game.at(x, y))
    game.addVisualCharacter(cachito)
  }

  method vis() = listaDeVisualesEnEscena
}