import wollok.game.*
import musicaFondo.*
import cachito.*
import enemigos.*
import pueblo.*
import elementosVisibles.*
object iglesia {
  const property image = "iglesia.png"
  var property position = game.origin()
  method iniciar() {
    visibles.borrarTodaLaListaDeVisuales()
    cachito.imagen("cachitoInt.png")
    visibles.listaDeVisualesEnEscena([self, puertaRec, pombe])
    visibles.cargarListaconVisuales()
    visibles.colocarJugadorEn(7,11)
    game.onTick(1000, "perseguir", {pombe.perseguirPersonaje()})
    game.onCollideDo(cachito, {objeto => objeto.interaccion()})
  }
}

object puertaRec { //buscar alguna manera de hacerla como una colisión invisible y que sea visible si se hablo con el inimputable
  method image() = "inv.png"
  method position() = game.at(7, 6)
  method interaccion(){
      game.say(self, "en desarrollo")
  }
}


