import escenario.*
import textos.*
import objetos.*
import musicaFondo.*
import cachito.*
import enemigos.*
import ubicaciones.*
import cinematicas.*


//======================PANTALLAS========================//
object controles{
  var property image = "controles.png"
  var property position = game.origin()
  method accionTecla() { inicio1.iniciar() musicaFondo.iniciar(0) }
  const tecla = keyboard.space()
  method iniciar() {
    accionesTeclas.pantallaValida(true)
    accionesTeclas.asignarTecla(tecla)
    accionesTeclas.actualizarPantalla(self)
    game.addVisual(self)
    accionesTeclas.accion()
  }
}

object portada {
  var property image = "portada.png"
  var property position = game.origin()
  const tecla = keyboard.e()
  method accionTecla() {lore1.iniciar() musicaFondo.iniciar(5) cartelIniciar.detenerAnimacion()}
  method iniciar() {
    escenario.borrarEscena()
    game.addVisual(self)
    game.onTick(500, "actualizarPuertas", { escenario.actualizarPuertas() })
    game.addVisual(iniciar1)
    cartelIniciar.animar()
    accionesTeclas.pantallaValida(true)
    accionesTeclas.asignarTecla(tecla)
    accionesTeclas.actualizarPantalla(self)
    accionesTeclas.accion()
  }
  method reiniciar() {
    musicaFondo.detener()
    musicaFondo.volumen(0.25)
    escenario.borrarEscena()
    cachito.reiniciar()
    nahuelito.reiniciar()
    game.removeTickEvent("moverse")
    game.removeTickEvent("atacar")
    game.removeTickEvent("actualizarPuertas")
    game.removeTickEvent("disparar roca")
    musicaFondo.reestablecerPista()
    self.iniciar()
    escenario.enGameOver(false)
  }
}

//=========================Pantallas Cinematica Inicial=========================//
const inicio1 = new PantallaCinematica(delay = 1000,image="p1.png", siguiente=inicio2)
const inicio2 = new PantallaCinematica(delay = 500,image="p2.png", siguiente=inicio3)
const inicio3 = new PantallaCinematica(delay = 500,image="p3.png", siguiente=inicio4)
const inicio4 = new PantallaCinematica(delay = 500,image="p4.png", siguiente=inicio5)
const inicio5 = new PantallaCinematica(delay = 500,image="p5.png", siguiente=inicio6)
const inicio6 = new PantallaCinematica(delay = 500,image="p6.png", siguiente=portada)
//=========================Pantallas Cinematica Lore=========================//
const lore1 = new PantallaCinematica(delay = 500,image="l1.png", siguiente=lore2)
const lore2 = new PantallaCinematica(delay = 500,image="l2.png", siguiente=lore3)
const lore3 = new PantallaCinematica(delay = 500,image="l3.png", siguiente=lore4)
const lore4 = new PantallaCinematica(delay = 500,image="l4.png", siguiente=lore5)
const lore5 = new PantallaCinematicaEspecial(image="l5.png", siguiente=lore6)
const lore6 = new PantallaCinematica(delay = 500,image="l6.png", siguiente=lore7)
const lore7 = new PantallaCinematica(delay = 500,image="l7.png", siguiente=lore8)
const lore8 = new PantallaCinematica(delay = 500,image="l8.png", siguiente=lore9)
const lore9 = new PantallaCinematica(delay = 500,image="l9.png", siguiente=lore10)
const lore10 = new PantallaCinematica(delay = 500,image="l10.png", siguiente=lore11)
const lore11 = new PantallaCinematica(delay = 500,image="l11.png", siguiente=lore12)
const lore12 = new PantallaCinematicaEspecial(image="l12.png", siguiente=lore13)
const lore13 = new PantallaCinematica(delay = 500,image="l13.png", siguiente=lore14)
const lore14 = new PantallaCinematica(delay = 500,image="l14.png", siguiente=lore15)
const lore15 = new PantallaCinematica(delay = 500,image="l15.png", siguiente=lore16)
const lore16 = new PantallaCinematica(delay = 500,image="l16.png", siguiente=lore17)
const lore17 = new PantallaCinematica(delay = 500,image="l17.png", siguiente=lore18)
const lore18 = new PantallaCinematicaEspecial(image="l18.png", siguiente=casa)
//===========================Pantallas Cinematicas Entrada a la iglesia========================//
const escenaPomberito1 = new PantallaCinematica(delay = 4000 ,image="escenaPomberito1.png", siguiente=escenaPomberito2)
const escenaPomberito2 = new PantallaCinematica(delay = 6000 ,image="escenaPomberito2.png", siguiente=iglesia)
//===========================Cinematicas Ataque============================//
/*

Se realiza como un objeto independiente (por mas que su logica sea identica a la clase PantallaCinematica) 
debido a que en pantalla cinematica se borra toda la escena y se agrega una nueva visual,
por lo que no se puede implementar la cinematica de ataque como una instancia de PantallaCinematica
ya que se borraria toda la escena y se "romperia" el juego.

Si a alguno se le llega a ocurrir alguna manera de solucionarlo y que se pueda implementar como una instancia, bienvenido sea.
- Ya intenté sacar el escenario.borrarEscena() y reemplazarlo por el metodo removerEscenaAnterior(){ if(escena != null) game.removeVisual(anterior)} pero no funcionó -
*/
object animacionAtaque {
  var property image = "ataque1.png"
  var property position = game.origin()
  method iniciar() {
    game.addVisual(self)
    game.schedule(1800, { self.siguienteImagen(2) })
    musicaFondo.volumen(0.05)
  }
  
  method siguienteImagen(img) {
    if (img < 5) {
      image = ("ataque" + img) + ".png"
      game.removeVisual(self)
      game.addVisual(self)
      game.schedule(1800, { self.siguienteImagen(img + 1) })
    } else {
      game.sound("grito.mp3").play()
      game.schedule(
        1500,
        { 
          game.removeVisual(self)
          musicaFondo.volumen(0.25)
          image = "ataque1.png"
        }
      )
    }
  }
  
  method duracion() = 9000
}
//===========================Pantalla Game Over===============================//
object pantallaGameOver {
  var property image = "gameOver2.png"
  var property position = game.origin()
  
  method iniciar() {
    escenario.enGameOver(true) 
    escenario.borrarEscena()
    game.addVisual(self)
    musicaFondo.detener()
    musicaFondo.iniciar(3)
    game.schedule(12000, { game.stop() })
    game.removeTickEvent("moverse")
    game.removeTickEvent("atacar")
    game.removeTickEvent("actualizarPuertas")
    game.removeTickEvent("ataque4Pomberito")
    game.removeTickEvent("ataque3Pomberito")
  }
  

}
object finalJuego {
  var property image = "fin1.png"
  var property position = game.origin()
  method iniciar() {
    musicaFondo.detener()
    game.addVisual(self)
    game.schedule(1800, { self.siguienteImagen(2) })
    musicaFondo.iniciar(1)
  }
  
  method siguienteImagen(img) {
    if (img < 6) {
      image = ("fin" + img) + ".png"
      game.removeVisual(self)
      game.addVisual(self)
      game.schedule(200, { self.siguienteImagen(img + 1) })
    } else {
      escenario.enFinal(true)
      keyboard.f().onPressDo(
        { if (escenario.enFinal()) {
            image = "fin6.png"
            game.removeVisual(self)
            game.addVisual(self)
            game.schedule(3000, {game.stop() })
          } }
      )

    }
  }
  }