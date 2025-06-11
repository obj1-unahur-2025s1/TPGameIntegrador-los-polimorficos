import wollok.game.*
import cachito.*
import enemigos.*
import musicaFondo.*
import textos.*
import objetos.*
import escenario.*

object casa {
  const property image = "casa.png"
  var property position = game.origin()
  
  method iniciar() {
    musicaFondo.cambiarAPista(1)
    escenario.iniciarEscena(self, casaCachito)
    escenario.ubicarEnEscena(puertaSalidaCasa, 5, 1)
    escenario.colocarJugadorEn(7, 8)
    escenario.ubicarEnEscena(topeSuperior, 0, 15)
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, 0, 0)
  }
}

object pueblo {
  const property image = "pueblo3.png"
  var property position = game.origin()
  var property x = 5
  var property y = 8
  method iniciar() {
    musicaFondo.detener()
    escenario.iniciarEscena(self, teroPiolado)
    cachito.ubicacion(self)
    cachito.actualizarImagen()
    escenario.colocarJugadorEn(x,y)
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
    escenario.colocarJugadorEn(1,5)
    cachito.ubicacion(self)
    cachito.actualizarImagen()
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
    cachito.ubicacion(self)
    cachito.actualizarImagen()
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
  //implementar la salida de la sala (Ejemplo en la sala del nahuelito)
}

object salaNahuelito {
  const property image = "fondoNahuelito.png"
  //Eliminar la C para que quede el fondo sin cuadricula
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(nahuelito)) "pNahueB.png"
                          else "pNahue.png"
  method iniciar() {
    escenario.iniciarEscena(self, costaNahuelito)
    escenario.colocarJugadorEn(5, 14)
    cachito.ubicacion(self)
    cachito.actualizarImagen()
    escenario.ubicarEnEscena(topeInferior, 0, 0)
    escenario.ubicarEnEscena(topeSuperior, 0, 15)
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, -1, 0)
    nahuelito.iniciar()
  }
  method interaccion() {
    if (self.imagenPuerta() == "pNahueB.png") {
      game.say(puertaNahuelito, "No podes pasar, ya derrotaste a Nahuelito")
    } else{
      game.schedule(1000, {
        self.iniciar() })
    }
  }
  method salidaDeLaSala(){
    if (cachito.ubicacion() == self) {
        escenario.ubicarEnEscena(puertaSalidaNahuelito, 5,14)
    }
  }
}

object salaLuzMala {
  const property image = "zonaLuzMala.png" //Realizar el fondo
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(luzMala)) "pluzMalaB.png" else "pluzMala.png"
  
  method iniciar() {
    escenario.iniciarEscena(self, zonaLuzMala)
    escenario.colocarJugadorEn(9, 12)
    cachito.ubicacion(self)
    cachito.actualizarImagen()
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
  //implementar la salida de la sala (Ejemplo en la sala del nahuelito)
}