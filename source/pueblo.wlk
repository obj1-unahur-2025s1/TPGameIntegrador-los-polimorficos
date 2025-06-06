import musicaFondo.*
import cachito.*
import enemigos.*
import casa.*
import elementosVisibles.*
object pueblo {
  const property image = "fondoC.png"
  var property position = game.origin()
  method iniciar() {
    musicaFondo.detener()
    visibles.borrarTodaLaListaDeVisuales()
    visibles.listaDeVisualesEnEscena(
      [self,puertaLM, puertaIglesia,puertaAL,pombe, puertaNH])
    visibles.cargarListaconVisuales()
    game.removeVisual(cachito)
    cachito.imagen("cachito.png")
    visibles.colocarJugadorEn(7,11)
    game.onCollideDo(cachito, {objeto => objeto.interaccion()})
  }
}


object puertaLM {
  method image() = if (cachito.derrotoA(luzMala)) "blockL.png" else "permL.png"
  method position() = game.at(0, 7)
  method interaccion(){
    if (self.image() == "blockL.png")
      game.say(self, "No podes pasar, ya apagaste la Loz")
    else
      game.say(self, "en desarrollo")
  }
}

object puertaNH {
  method image() = if (cachito.derrotoA(nahuelito)) "blockR.png" else "permR.png"
  
  method position() = game.at(8, 7)
  
    method interaccion(){
    if (self.image() == "blockR.png")
      game.say(self, "No podes pasar, el nahuelito ya volvió a bariloco")
    else
      game.say(self, "en desarrollo")
  } 
}

object puertaIglesia{
  const necesarios = 3
  method image() = if (cachito.enemigosDerrotados() == necesarios) "permD.png" else "blockD.png"
  
  method position() = game.at(4, 10)
  
    method interaccion(){
    if (self.image() == "blockD.png")
      game.say(self, "Necesitas derrotar a: " + 
      (3 - cachito.enemigosDerrotados()) + " enemigos más para poder pasar")
    else
      game.say(self, "en desarrollo")
  } 
}

object puertaAL{
  method image() = if (cachito.derrotoA(alien)) "blockD.png" else "permD.png"
  
  method position() = game.at(4, 0)
  
  method interaccion(){
    if (self.image() == "blockD.png")
      game.say(self, "No podes pasar, el alien se marchó en su ovni libertad")
    else
      game.say(self, "en desarrollo")
      musicaFondo.iniciar(2)
  } 
}

