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
  method accionTecla() { inicio1.iniciar()}
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
  method accionTecla() {lore1.iniciar() musicaFondo.iniciar("pistaLore") cartelIniciar.detenerAnimacion()}
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

//=========================Cinematica Inicial=========================//
const inicio1 = new PantallaCinematica(nombreImagen="portada", inicio=1, fin=6, siguiente=portada, pistaMusical="pistaTitulo")
//=========================Cinematica Lore=========================//
const lore1 = new PantallaCinematica(nombreImagen="lore", inicio=1, fin=5, siguiente=lore2, pistaMusical="pistaLore")
const lore2 = new PantallaCinematicaEspecial(image="lore5.png", siguiente=lore3)
const lore3 = new PantallaCinematica(nombreImagen="lore", inicio=6, fin=11, siguiente=lore4)
const lore4 = new PantallaCinematicaEspecial(image="lore12.png", siguiente=lore5)
const lore5 = new PantallaCinematica(nombreImagen="lore", inicio=13, fin=17, siguiente=lore6)
const lore6 = new PantallaCinematicaEspecial(image="lore18.png", siguiente=casa)

//===========================Cinematica Entrada a la iglesia========================//
const cinematicaPomberito = new PantallaCinematica(delay = 1500 ,nombreImagen="escenaPomberito",inicio=1, fin=3,
siguiente=iglesia, pistaMusical="pistaFinalBoss", delaySiguiente=6000)

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
//===========================Pantalla Game Over - Creditos ===============================//
const finalJuego = new PantallaCinematica(nombreImagen="fin", inicio=1, fin=4, siguiente=creditos, pistaMusical="pistaFinal")

object pantallaGameOver {
  var property image = "gameOver2.png"
  var property position = game.origin()
  
  method iniciar() {
    escenario.enGameOver(true) 
    escenario.borrarEscena()
    game.addVisual(self)
    musicaFondo.detener()
    musicaFondo.iniciar("pistaGameOver")
    game.removeTickEvent("moverse")
    game.removeTickEvent("atacar")
    game.removeTickEvent("actualizarPuertas")
    game.removeTickEvent("ataque4Pomberito")
    game.removeTickEvent("ataque3Pomberito")
    game.schedule(12000, { 
      image = "fin6.png"
      game.removeVisual(self)
      game.addVisual(self)
      self.finalizarJuego() })
  }
  method finalizarJuego() {
    game.schedule(2000,{
      game.stop()
    })
  }

}
object creditos {
  var property image = "fin5.png"
  var property position = game.origin()
  const tecla = keyboard.f()
  method accionTecla() {image = "fin6.png"; game.schedule(3000, {game.stop()})}
  method iniciar() {
    escenario.borrarEscena()
    game.addVisual(self)
    accionesTeclas.pantallaValida(true)
    accionesTeclas.asignarTecla(tecla)
    accionesTeclas.actualizarPantalla(self)
    accionesTeclas.accion()
  }
}