import pueblo.*
import musicaFondo.*
import casa.*
import elementosVisibles.*
object titulo {
  const property image = "portada.png"
  var property position = game.origin()
  method iniciar() {
    visibles.listaDeVisualesEnEscena([self])
    visibles.cargarListaconVisuales()
    musicaFondo.iniciar(0)
    keyboard.e().onPressDo({ self.iniciarJuego() })
  }
  
  method iniciarJuego() {
    
    game.schedule(2000, {casa.iniciar() })
  }
}
