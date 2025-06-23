import escenas.*
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
    self.agregarLimitadoresDeMovimiento()
  }

  method agregarLimitadoresDeMovimiento() {
    escenario.ubicarEnEscena(new LimitadorArriba(), 0, 10)
    escenario.ubicarEnEscena(new LimitadorArriba(), 1, 10)
    escenario.ubicarEnEscena(new LimitadorArriba(), 2, 10)
    escenario.ubicarEnEscena(new LimitadorArriba(), 3, 10)
    escenario.ubicarEnEscena(new LimitadorArriba(), 4, 9)
    escenario.ubicarEnEscena(new LimitadorArriba(), 5, 9)
    escenario.ubicarEnEscena(new LimitadorArriba(), 6, 9)
    escenario.ubicarEnEscena(new LimitadorArriba(), 7, 10)
    escenario.ubicarEnEscena(new LimitadorArriba(), 8, 10)
    escenario.ubicarEnEscena(new LimitadorArriba(), 9, 10)
    escenario.ubicarEnEscena(new LimitadorArriba(), 10, 10)
    escenario.ubicarEnEscena(new LimitadorArriba(), 7, 4)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 8, 7)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 8, 8)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 8, 9)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 8, 5)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 8, 4)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 8, 3)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 9, 7)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 9, 8)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 9, 9)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 9, 5)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 9, 4)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 9, 3)
  }//Capaz se puede hacer un archivo limitadores.wlk con objetos limitadores y que tengas un metodo
  //agregarLimitadoresCasa()  que tenga todos los  escenario.ubicarEnEscena(new LimitadorArriba(x,y))  utilizados en la funcion arriba de este comentario
  //El llamado quedaria limitadores.agregarLimitadoresCasa()
}
object pueblo {
  const property image = "pueblo3.png"
  var property position = game.origin()
  var property x = 5
  var property y = 8
  method iniciar() {
    musicaFondo.detener()
    escenario.iniciarEscena(self, teroViolado)
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
    self.agregarLimitadoresDeMovimiento()
  }
  method imagenPuerta() = "puertaAlPueblo.png"
  method interaccion(){
    game.schedule(2000, {
      self.iniciar() 
    })
  }

  method agregarLimitadoresDeMovimiento() {
    escenario.ubicarEnEscena(new LimitadorDerecha(), 10, 12)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 10, 11)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 10, 10)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 10, 9)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 10, 7)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 10, 6)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 10, 5)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 6, 0)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 6, 1)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 6, 2)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 6, 3)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 6, 4)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 2, 7)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 2, 8)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 6, 9)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 6, 10)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 6, 11)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 6, 12)
    escenario.ubicarEnEscena(new LimitadorDerecha(), 7, 6)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 8, 12)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 8, 11)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 8, 10)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 8, 9)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 8, 7)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 8, 6)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 4, 0)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 4, 1)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 4, 2)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 4, 3)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 4, 4)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 0, 5)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 0, 6)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 0, 7)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 4, 8)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 4, 9)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 4, 10)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 4, 11)
    escenario.ubicarEnEscena(new LimitadorIzquierda(), 4, 12)
    escenario.ubicarEnEscena(new LimitadorAbajo(), 9, 4)
    escenario.ubicarEnEscena(new LimitadorAbajo(), 8, 4)
    escenario.ubicarEnEscena(new LimitadorAbajo(), 7, 4)
    escenario.ubicarEnEscena(new LimitadorAbajo(), 1, 4)
    escenario.ubicarEnEscena(new LimitadorAbajo(), 2, 4)
    escenario.ubicarEnEscena(new LimitadorAbajo(), 3, 4)
    escenario.ubicarEnEscena(new LimitadorAbajo(), 4, 4)
    escenario.ubicarEnEscena(new LimitadorAbajo(), 5, 7)
    escenario.ubicarEnEscena(new LimitadorAbajo(), 7, 7)
    escenario.ubicarEnEscena(new LimitadorArriba(), 7, 6)
    escenario.ubicarEnEscena(new LimitadorArriba(), 2, 6)
    escenario.ubicarEnEscena(new LimitadorArriba(), 3, 6)
    escenario.ubicarEnEscena(new LimitadorArriba(), 4, 6)
    escenario.ubicarEnEscena(new LimitadorArriba(), 1, 9)
    escenario.ubicarEnEscena(new LimitadorArriba(), 7, 9)
    escenario.ubicarEnEscena(new LimitadorArriba(), 7, 9)
  }//Lo mismo que en el objeto casa pero con el nombre agregarLimitadoresPueblo(). El llamado quedaria limitadores.agregarLimitadoresPueblo()
  
}

object iglesia {
  const property image = "iglesia.png"
  method imagenPuerta() = if (cachito.enemigosDerrotados() == 3) "pIglesia.png" else "pIglesiaB.png"
  var property position = game.origin()
  method iniciar() {
    escenario.iniciarEscena(self, iglesiaTeroViolado)
    batallaFinal.iniciarPelea()
    pomberito.iniciar()
    escenario.colocarJugadorEn(5,1)
    cachito.actualizarImagen()
    escenario.ubicarEnEscena(limiteSuperior, 0, 2)
    escenario.ubicarEnEscena(limiteInferior, 0, -1)
    escenario.ubicarEnEscena(limiteLatDer, 10, 0)
    escenario.ubicarEnEscena(limiteLatIzq, 0, 0) 
    barraDeVida.mostrarVidas()
  }
  method interaccion(){
    if (cachito.enemigosDerrotados() < 3) 
      game.say(puertaIglesia, "Necesitas derrotar a: " + 
      (3 - cachito.enemigosDerrotados()) + " enemigos más para poder pasar")
    else if ((cachito.enemigosDerrotados() == 3) && cachito.habloConElViejo()) {
      game.schedule(1000, { escenaPomberito.iniciar(1) })
      cachito.ubicacion(self)
    }else if (cachito.enemigosDerrotados() == 3) {
      game.schedule(1000, { escenaPomberito.iniciar(2) })
      cachito.ubicacion(self)
    }
  }
}

object iglesia2{
  const property image = "iglesia.png"
  var property position = game.origin()
  method iniciar() {
    escenario.iniciarEscena(self, iglesiaTeroViolado)
    cachito.ubicacion(self)
    batallaFinal.iniciarPelea()
    pomberito.iniciar()
    escenario.colocarJugadorEn(5,1)
    cachito.actualizarImagen()
    escenario.ubicarEnEscena(limiteSuperior, 0, 2)
    escenario.ubicarEnEscena(limiteInferior, 0, -1)
    escenario.ubicarEnEscena(limiteLatDer, 10, 0)
    escenario.ubicarEnEscena(limiteLatIzq, 0, 0) 
    barraDeVida.mostrarVidas()
  }
}
object salaAlien {
  const property image = "fondoAlien.png" //Hacer el fondo
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(alien)) "palienB.png" else "palien.png"
  method iniciar() {
    musicaFondo.cambiarAPista(2)
    //cachito.ubicacion(self)
    escenario.iniciarEscena(self, ovniAlien)
    escenario.colocarJugadorEn(0, 1)
    cachito.actualizarImagen()
    escenario.ubicarEnEscena(limiteSuperior, 0, 12)
    escenario.ubicarEnEscena(limiteInferior, 0, 0)
    escenario.ubicarEnEscena(limiteLatDer, 11, 0)
    escenario.ubicarEnEscena(limiteLatIzq, -1, 0)
    barraDeVida.mostrarVidas()
    escenario.animar(true)
    game.addVisual(ovni1)
    self.iniciarAnimacion()
    game.schedule(3000, {alien.iniciar()})
    game.schedule(3000, {ovniAnimado.animar()})
  }
  
  method interaccion() {
    if (self.imagenPuerta() == "palienB.png") {
      game.say(puertaAlien, "No podes pasar, ya derrotaste al Alien")
    } else
    cachito.ubicacion(self)
    game.schedule(1000, {
      self.iniciar() })
  }
    method salidaDeLaSala(){
    if (cachito.ubicacion() == self) {
        escenario.ubicarEnEscena(puertaSalidaAlien, 0,1)
    }
  }
  method iniciarAnimacion() {
    game.schedule(1000, {ovni1.image("animacionO2.png")})
    game.schedule(2000, {ovni1.image("animacionO3.png")})
    game.schedule(3000, {ovni1.image("ov1.png")})
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
    cachito.ubicacion(self)
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
  const property image = "fondoLuzMala.png" 
  var property position = game.origin()
  method imagenPuerta() = if (cachito.derrotoA(luzMala)) "pluzMalaB.png" else "pluzMala.png"
  
  method iniciar() {
    escenario.iniciarEscena(self, zonaLuzMala)
    escenario.colocarJugadorEn(10, 1)
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
    cachito.ubicacion(self)
     game.schedule(1000, {
        self.iniciar() })
    }
  }
  method salidaDeLaSala(){
    if (cachito.ubicacion() == self) {
      escenario.ubicarEnEscena(puertaSalidaLuzMala, 10,1) 
    }
  }
}