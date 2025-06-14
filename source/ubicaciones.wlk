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
    escenario.ubicarEnEscena(limiteSuperior, 0, 15)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, 0, 0)
    barraDeVida.mostrarVidas()
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
    escenario.ubicarEnEscena(limiteSuperior, 0, 13)
    escenario.ubicarEnEscena(limiteInferior, 0, -1)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, -1, 0)
    barraDeVida.mostrarVidas()
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
    escenario.ubicarEnEscena(limiteSuperior, 0, 9)
    escenario.ubicarEnEscena(limiteInferior, 0, 0)
    escenario.ubicarEnEscena(limiteLatDer, 10, 0)
    escenario.ubicarEnEscena(limiteLatIzq, 0, 0) //Se pone en -1 para que no quede toda la columna 0 inutilizable
    barraDeVida.mostrarVidas()
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
  const property image = "fondoAlien.png" //Hacer el fondo
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(alien)) "palienB.png" else "palien.png"
  method iniciar() {
    musicaFondo.cambiarAPista(2)
    escenario.iniciarEscena(self, ovniAlien)
    escenario.colocarJugadorEn(0, 1)
    game.addVisual(ovni1)
    cachito.ubicacion(self)
    cachito.actualizarImagen()
    escenario.ubicarEnEscena(limiteSuperior, 0, 12)
    escenario.ubicarEnEscena(limiteInferior, 0, 0)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, -1, 0)
    barraDeVida.mostrarVidas()
    escenario.animar(true)
    alien.iniciar()
    ovniAnimado.animar()
  }
  
  method interaccion() {
    if (self.imagenPuerta() == "palienB.png") {
      game.say(puertaAlien, "No podes pasar, ya derrotaste al Alien")
    } else
    game.schedule(1000, {
      self.iniciar() })
  }
    method salidaDeLaSala(){
    if (cachito.ubicacion() == self) {
        escenario.ubicarEnEscena(puertaSalidaAlien, 0,1)
    }
  }
}

object salaNahuelito {
  const property image = "fondoNahuelito.png"
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(nahuelito)) "pNahueB.png"
                          else "pNahue.png"
  method iniciar() {
    escenario.iniciarEscena(self, costaNahuelito)
    escenario.colocarJugadorEn(5, 14)
    cachito.ubicacion(self)
    cachito.actualizarImagen()
    escenario.ubicarEnEscena(limiteInferior, 0, 0)
    escenario.ubicarEnEscena(limiteSuperior, 0, 15)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, -1, 0)
    nahuelito.iniciar()
    barraDeVida.mostrarVidas()
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
  const property image = "fondoLuzMala.png" //Realizar el fondo
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(luzMala)) "pluzMalaB.png" else "pluzMala.png"
  
  method iniciar() {
    escenario.iniciarEscena(self, zonaLuzMala)
    escenario.colocarJugadorEn(10, 1)
    cachito.ubicacion(self)
    cachito.actualizarImagen()
    escenario.ubicarEnEscena(limiteSuperior, 0, 15)
    escenario.ubicarEnEscena(limiteInferior, 0, 0)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, -1, 0)
    barraDeVida.mostrarVidas()
    luzMala.iniciar()
  }
  
  method interaccion() {
    if (self.imagenPuerta() == "pluzMalaB.png") {
      game.say(puertaLuzMala, "No podes pasar, ya derrotaste a la Luz Mala")
    } else {
     game.schedule(1000, {
        self.iniciar() })
    }
  }
  method salidaDeLaSala(){
    if (cachito.ubicacion() == self) {
      escenario.ubicarEnEscena(puertaSalidaAlien, 10,1) //Crer en Objetos.wlk la puerta de salida de la luz mala
    }
  }
 
}