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
    game.addVisual(spaceParaContinuar1)
    game.onTick(500, "actualizarPuertas", {escenario.actualizarPuertas()}) 
    keyboard.space().onPressDo({
      musicaFondo.iniciar(0)
      image = "p1.png"
      game.removeVisual(self)
      game.addVisual(self)
      game.schedule(2000, { self.animacionIntro(2) }) }) 
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
    self.iniciar()
  }
  
  method animacionIntro(escenaAc) {
    if (escenaAc < 7) {
      image = ("p" + escenaAc) + ".png"
      game.removeVisual(self)
      game.addVisual(self)
      game.schedule(200, { self.animacionIntro(escenaAc + 1) })
    } else {
      escenario.animar(true)
      image = "portada.png"
      game.removeVisual(self)
      game.addVisual(self)
      game.addVisual(iniciar1)
      cartelIniciar.animar()
      keyboard.e().onPressDo({ self.iniciarJuego()})
    }
  }
  method iniciarJuego() {
    game.schedule(2000, {cartelIniciar.detenerAnimacion() casa.iniciar() })
  }
}

object pantallaGameOver{
  var property image = "gameOver.png"
  var property position = game.origin()
  method iniciar() {
    escenario.borrarEscena()
    game.addVisual(self)
    musicaFondo.iniciar(3)
    escenario.animar(true)
    game.addVisual(opcionGameOver1)
    cartelGameOver.animar()
    game.removeTickEvent("moverse")
    game.removeTickEvent("atacar")
    game.removeTickEvent("actualizarPuertas")
    keyboard.y().onPressDo({inicio.reiniciar()})
    keyboard.n().onPressDo({self.finalizar()})
  }
  method finalizar() {
    image = "gameOver2.png"
    game.removeVisual(self)
    game.addVisual(self)
    cartelGameOver.detenerAnimacion()
    musicaFondo.detener()
    game.schedule(12000,{game.stop()})
  }
}

object animacionAtaque{
  var property image = "ataque1.png"
  var property position = game.origin()
  method iniciar() {
    game.addVisual(self)
    game.schedule(1800, {self.siguienteImagen(2)})
    musicaFondo.pausar()
  }
  method siguienteImagen(img){
    if (img < 5) {
      image = "ataque" + img + ".png"
      game.removeVisual(self)
      game.addVisual(self)
      game.schedule(1800, {self.siguienteImagen(img + 1)})
    } else {
      game.sound("grito.mp3").play()
      game.schedule(1500, {
        game.removeVisual(self)
       musicaFondo.reanudar()
       })
     
    }
    
  }
  method duracion() = 9000
}

object escenaPomberito{
  var property image = "escenaPomberito1.png"
  var property position = game.origin()
  method iniciar(interior) {
    musicaFondo.iniciar(4)
    game.addVisual(self)
    game.schedule(4000, {self.siguienteImagen(interior)}) 
  }  
  method siguienteImagen(interior) {
    image = "escenaPomberito2.png"
    game.removeVisual(self)
    game.addVisual(self)
    game.schedule(5000, {
      if( interior ==1){
        iglesia.iniciar()
      }else{
        iglesia2.iniciar()
      }
    })
  }
  method duracion() = 9000
}

object finalJuego{
  method iniciar(){
    //DESARROLLAR FINAL
  }
}