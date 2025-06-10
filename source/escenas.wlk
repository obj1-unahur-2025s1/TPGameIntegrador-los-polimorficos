import escenario.*
import textos.*
import objetos.*
import musicaFondo.*
import cachito.*
import enemigos.*

//======================PANTALLAS========================//

object inicio {
  var property image = "p1.png"
  var property position = game.origin()
  method iniciar() {
    musicaFondo.iniciar(0)
    game.addVisual(self)
    game.onTick(500, "actualizarPuertas", {escenario.actualizarPuertas()}) 
    game.schedule(2000, { self.animacionIntro(2) })
  }

  method reiniciar() {
    game.removeVisual(self)
    musicaFondo.detener()
    musicaFondo.volumen(0.25)
    escenario.borrarEscena()
    cachito.reiniciar()

    image = "p1.png"
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
      game.addVisual(pres1)
      escenario.animarCartel(pres1, pres2)
      keyboard.e().onPressDo({ self.iniciarJuego()})
    }
  }
  method iniciarJuego() {
    game.schedule(2000, {escenario.detenerAnimacion(pres1,pres2) casa.iniciar() })
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
    game.addVisual(continuar1)
    escenario.animarCartel(continuar1, continuar2)
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
    escenario.detenerAnimacion(continuar1, continuar2)
    musicaFondo.detener()
    game.schedule(12000,{game.stop()})
  }
}



//======================ZONAS=========================
//VER DE COMO HACER QUE CACHITO APAREZCA EN UN LUGAR DEL PUEBLO ACORDE DEL LUGAR QUE VIENE (SIEMPRE CON UNA CELDA MAS PARA QUE NO QUEDE ENCIMA DE LA PUERTA Y SE HAGA UN BUCLE)
object casa {
  const property image = "casa.png"
  var property position = game.origin()
  
  method iniciar() {
    musicaFondo.cambiarAPista(1)
    escenario.iniciarEscena(self, casaCachito)
    escenario.ubicarEnEscena(puertaAlPueblo1, 5, 1)
    escenario.colocarJugadorEn(7, 8)
    escenario.ubicarEnEscena(topeSuperior, 0, 15)
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, 0, 0)
  }
}

object pueblo {
  const property image = "pueblo3.png"
  var property position = game.origin()
  method iniciar() {
    musicaFondo.detener()
    escenario.iniciarEscena(self, teroPiolado)
    escenario.colocarJugadorEn(9,12)
    escenario.ubicarEnEscena(puertaIglesia, 5, 11)
    escenario.ubicarEnEscena(puertaAlien, 10,8)
    escenario.ubicarEnEscena(puertaLuzMala, 0,8)
    escenario.ubicarEnEscena(puertaNahuelito, 5,0)
    escenario.ubicarEnEscena(topeSuperior, 0, 13)
    escenario.ubicarEnEscena(topeInferior, 0, -1)
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, -1, 0)
  }
  method imagenPuerta() = "puertaAlPueblo.png"
  method interaccion(){
    game.schedule(2000, {
      cachito.ubicacion(self)
      cachito.actualizarImagen()
      self.iniciar() 
    })
  }
}

object iglesia {
  const property image = "iglesia.png"
  method imagenPuerta() = if (cachito.enemigosDerrotados() == 3) "pIglesia.png" else "pIglesiaB.png"
  var property position = game.origin()
  method iniciar() {
    escenario.iniciarEscena(self, iglesiaTeroPiolado)
    escenario.colocarJugadorEn(9,12)
    game.addVisual(pomberito)
    game.onTick(1000, "perseguir", {pomberito.perseguirPersonaje()})
    escenario.ubicarEnEscena(topeSuperior, 0, 9)
    escenario.ubicarEnEscena(topeInferior, 0, 0)
    escenario.ubicarEnEscena(topeLatDer, 10, 0)
    escenario.ubicarEnEscena(topeLatIzq, 0, 0) //Se pone en -1 para que no quede toda la columna 0 inutilizable
  }
  method interaccion(){
    if (cachito.enemigosDerrotados() < 3) 
      game.say(puertaIglesia, "Necesitas derrotar a: " + 
      (3 - cachito.enemigosDerrotados()) + " enemigos más para poder pasar")
    else{
      game.schedule(1000, {
      cachito.ubicacion(self)
      cachito.actualizarImagen()
      self.iniciar() })
    }
  } 
}

object salaAlien {
  const property image = "zonaAlien.png" //Hacer el fondo
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(alien)) "palienB.png" else "palien.png"
  method iniciar() {
    musicaFondo.cambiarAPista(2)
    escenario.iniciarEscena(self, ovniAlien)
    escenario.colocarJugadorEn(9, 12)
    escenario.ubicarEnEscena(topeSuperior, 0, 13)
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, -1, 0)
  }
  
  method interaccion() {
    if (self.imagenPuerta() == "palienB.png") {
      game.say(puertaAlien, "No podes pasar, ya derrotaste al Alien")
    } else
    game.say(puertaAlien, "En desarrollo")
  }
}

object salaNahuelito {
  const property image = "fondoNahuelitoC.png"
  //Eliminar la C para que quede el fondo sin cuadricula
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(nahuelito)) "pNahueB.png"
                          else "pNahue.png"
  method iniciar() {
    escenario.iniciarEscena(self, costaNahuelito)
    escenario.colocarJugadorEn(5, 14)
    escenario.ubicarEnEscena(puertaAlPueblo1, 6, 9)
    escenario.ubicarEnEscena(topeInferior, 0, 0)
    escenario.ubicarEnEscena(topeSuperior, 0, 15)
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, -1, 0)
    //nuevo. pruebas. borrar
    //nuevo. pruebas. borrar
    nahuelito.iniciar()
  }
  method interaccion() {
    if (self.imagenPuerta() == "pNahueB.png") {
      game.say(puertaNahuelito, "No podes pasar, ya derrotaste a Nahuelito")
    } else{
      game.schedule(1000, {
        cachito.ubicacion(self)
        cachito.actualizarImagen()
        self.iniciar() })
    }
    
    //Este metodo es el que utiliza la puerta cuando el personaje colisiona con ella. Va solo esto (las otras tienen un mensaje xq no estan terminadas)
  }
}

object salaLuzMala {
  const property image = "zonaLuzMala.png" //Realizar el fondo
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(luzMala)) "pluzMalaB.png" else "pluzMala.png"
  
  method iniciar() {
    escenario.iniciarEscena(self, zonaLuzMala)
    escenario.colocarJugadorEn(9, 12)
    escenario.ubicarEnEscena(topeSuperior, 0, 13)
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, -1, 0)
  }
  
  method interaccion() {
    if (self.imagenPuerta() == "pluzMalaB.png") {
      game.say(puertaLuzMala, "No podes pasar, ya derrotaste a la Luz Mala")
    } else
    game.say(puertaLuzMala, "En desarrollo")
  }
}