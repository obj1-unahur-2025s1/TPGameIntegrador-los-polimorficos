import wollok.game.*
import musicaFondo.*
import cachito.*
import enemigos.*
import pueblo.*
import elementosVisibles.*
object iglesia {
  const property image = "iglesia2C.png"
  var property position = game.origin()
  method iniciar() {
    visibles.borrarTodaLaListaDeVisuales()
    game.addVisual(puertaRec)
    game.addVisualCharacter(cachito)
    game.addVisual(pombe)
    keyboard.enter().onPressDo({ cachito.saludar() })
    keyboard.num(4).onPressDo({ musicaFondo.detener() })
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


