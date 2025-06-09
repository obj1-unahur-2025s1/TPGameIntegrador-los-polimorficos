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
  var anim = false
  method iniciar() {
    musicaFondo.iniciar(0)
    game.addVisual(self)
    game.schedule(2000, { self.animacionIntro(2) })
  }

  method reiniciar() {
    game.removeVisual(self)
    musicaFondo.detener()
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
      anim = true
      image = "portada.png"
      game.removeVisual(self)
      game.addVisual(self)
      game.addVisual(pres1)
      self.animarCartel()
      keyboard.e().onPressDo({ self.iniciarJuego()})
    }
  }
  method iniciarJuego() {
    game.schedule(2000, {self.detenerAnimacion() casa.iniciar() })
  }

  method animarCartel(){
    if (game.hasVisual(pres1) && anim) {
      game.removeVisual(pres1)
      game.addVisual(pres2)
      game.schedule(600, { self.animarCartel() })
    } else if (game.hasVisual(pres2) && anim) {
      game.removeVisual(pres2)
      game.addVisual(pres1)
      game.schedule(600, { self.animarCartel() })
    }
  }

  method detenerAnimacion() {
    anim = false
    if (game.hasVisual(pres1)) game.removeVisual(pres1)
    if (game.hasVisual(pres2)) game.removeVisual(pres2)
  }
}

//======================ZONAS=========================// HAY QUE REVISAR XQ NO SE ACTUALIZAN LAS IMAGENES DE LAS PUERTAS. CAPAZ HACER UN METODO QUE SE LLAME ACTUALIZARPUERTAS()
// Y SE LLAME CON EL ON TICK DEL JUEGO (LAS PUERTAS SE PODRÍAN GUARDAR EN UNA LISTA EN ESCENARIO.WLK Y USAR UN FOR EACH PARA RECORRERLAS Y ACTUALIZARLAS)


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
  }
  method imagenPuerta() = "puertaAlPueblo.png"
  method interaccion(){
    game.schedule(2000, {
      cachito.image("cachitoE.png")
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
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, -1, 0) //Se pone en -1 para que no quede toda la columna 0 inutilizable
  }
  method interaccion(){
    if (cachito.enemigosDerrotados() < 3) 
      game.say(puertaIglesia, "Necesitas derrotar a: " + 
      (3 - cachito.enemigosDerrotados()) + " enemigos más para poder pasar")
    else
      game.schedule(1000, {
        cachito.image("cachitoIntE.png")
        self.iniciar() })
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
    escenario.colocarJugadorEn(5, 15)
    escenario.ubicarEnEscena(puertaAlPueblo1, 6, 9)
    escenario.ubicarEnEscena(topeInferior, 0, 0)
    escenario.ubicarEnEscena(topeLatDer, 11, 0)
    escenario.ubicarEnEscena(topeLatIzq, -1, 0)
  }
  
  method interaccion() {
    game.schedule(1000, { self.iniciar() })
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
    game.say(puertaLuzMala, "En desarrollo")
  }
} //=====================INSTANCIACIONES=============//

const pres1 = new PressParaIniciar(image = "press1.png")
const pres2 = new PressParaIniciar(image = "press2.png")

const puertaAlPueblo1 = new Puerta(proxZona = pueblo)
const puertaIglesia = new Puerta(proxZona = iglesia)
const puertaNahuelito = new Puerta(proxZona = salaNahuelito)
const puertaAlien = new Puerta(proxZona = salaAlien)
const puertaLuzMala = new Puerta(proxZona = salaLuzMala)