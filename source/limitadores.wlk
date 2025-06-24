import cachito.*
import escenario.*
class Limitador {
	var property position = game.at(0,0)

  method ubicarEn(x,y) {
    self.position(game.at(x,y))
  }

  method interaccion() {
    self.empuja(cachito)
  }

  method empuja(cachito)
}

class LimitadorArriba inherits Limitador {
	override method empuja(cachito) {
		cachito.position(cachito.position().down(1))
	}
}

class LimitadorAbajo inherits Limitador {
	override method empuja(cachito) {
		cachito.position(cachito.position().up(1))
	}
}

class LimitadorIzquierda inherits Limitador {
	override method empuja(cachito) {
		cachito.position(cachito.position().right(1))
	}
}

class LimitadorDerecha inherits Limitador {
	override method empuja(cachito) {
		cachito.position(cachito.position().left(1))
	}
}

object limitadores {

    method agregarLimitadoresEnCasa() {
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
    }

    method agregarLimitadoresEnPueblo() {
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
    }
}