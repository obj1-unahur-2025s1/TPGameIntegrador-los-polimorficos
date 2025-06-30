import escenario.*
import musicaFondo.*
import escenas.*
import ubicaciones.*
import objetos.*

class PantallaCinematica{
  const nombreImagen 
  const inicio = 1 
  const fin
  const siguiente 
  const pistaMusical = null
  var property image = null
  var property position = game.origin()
  const delay = 500
  const delaySiguiente = 0
  method iniciar(){
    image = nombreImagen + inicio + ".png"
    escenario.borrarEscena()
    game.addVisual(self)
    game.schedule(delay, { self.realizarCinematica(inicio) })
    musicaFondo.iniciar(pistaMusical)
  }
  method realizarCinematica(escena) {
    if (escena < fin){
      image = nombreImagen + escena + ".png"
      game.removeVisual(self)
      game.addVisual(self)
      game.schedule(delay, { self.realizarCinematica(escena + 1) })
    }else{
      game.schedule(delaySiguiente, {
        siguiente.iniciar()
        image = inicio
      })
    }
  } 
}


class PantallaCinematicaEspecial{
  const tecla = keyboard.space()
  var property image 
  var property position = game.origin()
  const siguiente
  method accionTecla() {siguiente.iniciar()}
  method iniciar() {
    escenario.borrarEscena() 
    game.addVisual(self)
    game.addVisual(spaceParaContinuar1)
    accionesTeclas.pantallaValida(true)
    accionesTeclas.asignarTecla(tecla)
    accionesTeclas.actualizarPantalla(self)
    accionesTeclas.accion()
  }
}