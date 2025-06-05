import musicaFondo.*
import cachito.*
import enemigos.*
import pueblo.*

object casa {
  method iniciar() {
    game.addVisual(puertaCasa1)
    cachito.imagen("cachitoInt.png")
    game.addVisualCharacter(cachito)
    game.boardGround("casa.png")
    cachito.position(game.at(5, 8))
    keyboard.enter().onPressDo({ cachito.saludar() })
    keyboard.num(4).onPressDo({ musicaFondo.detener() })
    game.onCollideDo(cachito, {objeto => objeto.interaccion()})
  }
}

object puertaCasa1 { //buscar alguna manera de hacerla como una colisión invisible y que sea visible si se hablo con el inimputable
  method image() = "permD.png"
  method position() = game.at(4, 0)
  method interaccion(){
    musicaFondo.detener()
    game.boardGround("pueblo.png") // quitá la portada
    game.schedule(4000, {pueblo.iniciar() })
  }
}


