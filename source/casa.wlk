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
    game.onCollideDo(cachito, {objeto => objeto.interaccion()})
  }
}

object puertaCasa1 {
  method image() = "permD.png"
  method position() = game.at(4, 0)
  method interaccion(){
    game.schedule(1000, {pueblo.iniciar() })
  }
}


