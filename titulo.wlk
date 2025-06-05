import pueblo.*
import musicaFondo.*
import casa.*
object titulo {
  const property image = "portada.png"
  var property position = game.origin()
  var property activarMenu = true
  method iniciar() {
    game.boardGround("portada.png")
    activarMenu = true
    keyboard.e().onPressDo({ self.iniciarJuego() })
  }
  
  method iniciarJuego() {
    musicaFondo.iniciar(1)
    game.schedule(4000, {casa.iniciar() })
  }
}
