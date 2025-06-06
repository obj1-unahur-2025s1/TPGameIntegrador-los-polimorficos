import wollok.game.*
import musicaFondo.*
import cachito.*
import enemigos.*
import pueblo.*
import elementosVisibles.*
object casa {
  const property image = "casa.png"
  var property position = game.origin()
  method iniciar() {
    musicaFondo.detener()
    musicaFondo.iniciar(1)
    visibles.borrarTodaLaListaDeVisuales()
    cachito.imagen("cachitoInt.png")
    visibles.listaDeVisualesEnEscena([self, puertaCasa1])
    visibles.cargarListaconVisuales()
    visibles.colocarJugadorEn(7,11)
    //game.addVisualCharacter(cachito)
    game.onCollideDo(cachito, {objeto => objeto.interaccion()})
    //game.addVisual(self)
    //game.addVisual(puertaCasa1)
    //keyboard.enter().onPressDo({ cachito.saludar() })
    //keyboard.num(4).onPressDo({ musicaFondo.detener() })
  }
}

object puertaCasa1 { //buscar alguna manera de hacerla como una colisión invisible y que sea visible si se hablo con el inimputable
  method image() = "permD.png"
  method position() = game.at(4, 0)
  method interaccion(){
    game.schedule(1000, {pueblo.iniciar() })
  }
}


