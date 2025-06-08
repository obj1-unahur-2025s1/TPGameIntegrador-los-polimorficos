import escenario.*
import textos.*
import objetos.*
import musicaFondo.*
import cachito.*
import enemigos.*

//=====================ESCENAS============================//
object portada {
  const property image = "portada2.png"
  var property position = game.origin()
  method iniciar() {
    escenario.iniciarEscena(self, presioneParaIniciar)
    musicaFondo.iniciar(0)
    keyboard.e().onPressDo({ self.iniciarJuego() })
    
  }
  
  method iniciarJuego() {
    game.schedule(2000, {casa.iniciar() })
  }
}
object casa {
  const property image = "casa.png"
  var property position = game.origin()
  method iniciar() {
    musicaFondo.cambiarAPista(1)
    escenario.iniciarEscena(self, casaCachito) 
    escenario.ubicarEnEscena(puertaAlPueblo1,5,1)
    escenario.colocarJugadorEn(7, 8)
    escenario.ubicarEnEscena(topeSuperior, 0, 15) 
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, 0, 0)
    }
}
object pueblo {
  const property image = "pueblo3C.png"
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
        game.onTick(1000, "perseguir", {pomberito.perseguirPersonaje()})
  }
  method imagenPuerta() = "puertaAlPueblo.png"
  method interaccion(){
    game.schedule(2000, {
      cachito.image("cachito.png")
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
    escenario.ubicarEnEscena(topeSuperior, 0, 13)
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, -1, 0) //Se pone en -1 para que no quede toda la columna 0 inutilizable
  }
  method interaccion(){
    if (cachito.enemigosDerrotados() < 3) 
      game.say(puertaIglesia, "Necesitas derrotar a: " + 
      (3 - cachito.enemigosDerrotados()) + " enemigos más para poder pasar")
    else
      game.schedule(1000, {self.iniciar() })
  } 
}

object salaAlien {
  const property image = "zonaAlien.png" //Hacer el fondo
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(alien)) "palienB.png" else "palien.png"
  method iniciar() {
    musicaFondo.cambiarAPista(2)
    escenario.iniciarEscena(self, ovniAlien)
    escenario.colocarJugadorEn(9,12)
    escenario.ubicarEnEscena(topeSuperior, 0, 13)
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, -1, 0)
  }
  method interaccion(){
      game.say(puertaAlien, "En desarrollo") 
  } 
}

object salaNahuelito {
  const property image = "fondoNahuelitoC.png" //Eliminar la C para que quede el fondo sin cuadricula
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(nahuelito)) "pNahueB.png" else "pNahue.png"
  method iniciar() {
    escenario.iniciarEscena(self, costaNahuelito)
    escenario.colocarJugadorEn(5,15)
    escenario.ubicarEnEscena(puertaAlPueblo1, 6, 9)
    escenario.ubicarEnEscena(topeSuperior, 0, 16)
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, -1, 0)
  }
  method interaccion(){
      game.schedule(1000, {=>self.iniciar()}) //Este metodo es el que utiliza la puerta cuando el personaje colisiona con ella. Va solo esto (las otras tienen un mensaje xq no estan terminadas)
  } 
}

object salaLuzMala {
  const property image = "zonaLuzMala.png" //Realizar el fondo
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(luzMala)) "pluzMalaB.png" else "pluzMala.png"
  method iniciar() {
    escenario.iniciarEscena(self, ovniAlien)
    escenario.colocarJugadorEn(9,12)
    escenario.ubicarEnEscena(topeSuperior, 0, 13)
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, -1, 0)
  }
  method interaccion(){
      game.say(puertaLuzMala, "En desarrollo") 
  } 
}

//=====================PUERTAS========================================//
const puertaAlPueblo1 = new Puerta(proxZona = pueblo)
const puertaIglesia = new Puerta(proxZona = iglesia)
const puertaNahuelito = new Puerta(proxZona = salaNahuelito)
const puertaAlien = new Puerta(proxZona = salaAlien)
const puertaLuzMala = new Puerta(proxZona = salaLuzMala)