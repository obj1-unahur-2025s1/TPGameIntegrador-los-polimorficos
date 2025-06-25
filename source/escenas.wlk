import escenario.*
import textos.*
import objetos.*
import musicaFondo.*
import cachito.*
import enemigos.*
import ubicaciones.*

//======================PANTALLAS========================//
object inicio {
  var property image = "controles.png"
  var property position = game.origin()
  
  method iniciar() {
    game.addVisual(self)
    game.onTick(500, "actualizarPuertas", { escenario.actualizarPuertas() })
    escenario.enControles(true)
    keyboard.space().onPressDo(
      { if (escenario.enControles()) {
          musicaFondo.iniciar(0)
          image = "p1.png"
          game.removeVisual(self)
          game.addVisual(self)
          game.schedule(
            2000,
            { 
              self.animacionIntro(2)
                escenario.enControles(false)
            }
          )
        } }
    )
  }
  
  method reiniciar() {
    musicaFondo.detener()
    musicaFondo.volumen(0.25)
    escenario.borrarEscena()
    cachito.reiniciar()
    game.removeTickEvent("moverse")
    game.removeTickEvent("atacar")
    game.removeTickEvent("actualizarPuertas")
    game.removeTickEvent("disparar roca")
    image = "controles.png"
    musicaFondo.reestablecerPista()
    self.iniciar()
    escenario.enGameOver(false)
  }
  
  method animacionIntro(escenaAc) {
    if (escenaAc < 7) {
      image = ("p" + escenaAc) + ".png"
      game.removeVisual(self)
      game.addVisual(self)
      game.schedule(200, { self.animacionIntro(escenaAc + 1) })
    } else {
      escenario.animar(true)
      escenario.enMenu(true)
      image = "portada.png"
      game.removeVisual(self)
      game.addVisual(self)
      game.addVisual(iniciar1)
      cartelIniciar.animar()
      keyboard.e().onPressDo({ if (escenario.enMenu()) self.iniciarLore() })
    }
  }
  
  method iniciarLore() {
    escenario.enMenu(false)
    game.schedule(
      2000,
      { 
        cartelIniciar.detenerAnimacion()
        lore1.iniciar()
      }
    )
  }
}

object lore1 {
  var property image = "l1.png"
  var property position = game.origin()
  
  method iniciar() {
    escenario.borrarEscena() // Prueba
    musicaFondo.detener()
    musicaFondo.iniciar(5)
    game.addVisual(self)
    self.animacionLore(2)

  }
  
  method animacionLore(escenaAc) {
    if (escenaAc < 6) {
      image = ("l" + escenaAc) + ".png"
      game.removeVisual(self)
      game.addVisual(self)
      game.schedule(500, { self.animacionLore(escenaAc + 1) })
    } else {
      escenario.enLore1(true)
      game.addVisual(spaceParaContinuar1)
      keyboard.space().onPressDo(
        { if (escenario.enLore1()) {
            escenario.borrarEscena() // Prueba
            lore2.iniciar()
            escenario.enLore1(false)
          } }
      )
    }
  }
}

object lore2 {
  var property image = "l6.png"
  var property position = game.origin()
  
  method iniciar() {
    game.addVisual(self)
    self.animacionLore(7)
  }
  
  method animacionLore(escenaAc) {
    if (escenaAc < 13) {
      image = ("l" + escenaAc) + ".png"
      game.removeVisual(self)
      game.addVisual(self)
      game.schedule(500, { self.animacionLore(escenaAc + 1) })
    } else {
      escenario.enLore2(true)
      game.addVisual(spaceParaContinuar1)
      keyboard.space().onPressDo(
        { if (escenario.enLore2()) {
            image = "l13.png"
            escenario.borrarEscena() 
            game.addVisual(self)
            self.iniciarJuego() 
          } }
      )
    }
  }
  
  method iniciarJuego() {
    game.addVisual(spaceParaContinuar1)
    keyboard.space().onPressDo(
      { if (escenario.enLore2()) {
          game.schedule(2000, { casa.iniciar() escenario.enLore2(false)})
        } }
    )
  }
}

object pantallaGameOver {
  var property image = "gameOver.png"
  var property position = game.origin()
  
  method iniciar() {
    escenario.enGameOver(true) 
    escenario.borrarEscena()
    game.addVisual(self)
    musicaFondo.detener()
    musicaFondo.iniciar(3)
    escenario.animar(true)
    game.addVisual(opcionGameOver1)
    cartelGameOver.animar()
    game.removeTickEvent("moverse")
    game.removeTickEvent("atacar")
    game.removeTickEvent("actualizarPuertas")
    keyboard.y().onPressDo({ if (escenario.enGameOver()) inicio.reiniciar() })
    keyboard.n().onPressDo({ if (escenario.enGameOver()) self.finalizar() })
  }
  
  method finalizar() {
    image = "gameOver2.png"
    game.removeVisual(self)
    game.addVisual(self)
    cartelGameOver.detenerAnimacion()
    musicaFondo.detener()
    game.schedule(12000, { game.stop() })
    escenario.enGameOver(false)
  }
}

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

object escenaPomberito {
  var property image = "escenaPomberito1.png"
  var property position = game.origin()
  
  method iniciar() {
    musicaFondo.iniciar(4)
    escenario.borrarEscena() // Prueba
    game.addVisual(self)
    game.schedule(4000, { self.siguienteImagen() })
  }
  
  method siguienteImagen() {
    image = "escenaPomberito2.png"
    game.removeVisual(self)
    game.addVisual(self)
    game.schedule(
      6000,
      { //5000 orig
        iglesia.iniciar() }
    )
  }
  
  method duracion() = 9000
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