import cachito.*
import escenario.*
import objetos.*

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
    method crearLimitadoresArribaHorizontales(y, xDesde, xHasta) {
        (xDesde..xHasta).forEach { x => 
            escenario.ubicarEnEscena(new LimitadorArriba(), x, y)
        }
    }
    
    method crearLimitadoresAbajoHorizontales(y, xDesde, xHasta) {
        (xDesde..xHasta).forEach { x => 
            escenario.ubicarEnEscena(new LimitadorAbajo(), x, y)
        }
    }
    
    method crearLimitadoresDerechaVerticales(x, yDesde, yHasta) {
        (yDesde..yHasta).forEach { y => 
            escenario.ubicarEnEscena(new LimitadorDerecha(), x, y)
        }
    }
    
    method crearLimitadoresIzquierdaVerticales(x, yDesde, yHasta) {
        (yDesde..yHasta).forEach { y => 
            escenario.ubicarEnEscena(new LimitadorIzquierda(), x, y)
        }
    }
    
    method crearLimitadorIndividual(direccion, x, y) {
        direccion.crearLimitadorDeMovimiento(x, y)
    }

    method agregarLimitadoresEnCasa() {
        self.crearLimitadoresArribaHorizontales(10, 0, 3)
        self.crearLimitadoresArribaHorizontales(10, 7, 10)
        self.crearLimitadoresArribaHorizontales(9, 4, 6)
        
        escenario.ubicarEnEscena(new LimitadorArriba(), 7, 4)
        
        self.crearLimitadoresDerechaVerticales(8, 3, 9)
          
        self.crearLimitadoresIzquierdaVerticales(9, 3, 9)
    }

    method agregarLimitadoresEnPueblo() {
        self.crearLimitadoresDerechaVerticales(10, 5, 7)
        self.crearLimitadoresDerechaVerticales(10, 9, 12)
        self.crearLimitadoresDerechaVerticales(6, 0, 4)
        self.crearLimitadoresDerechaVerticales(6, 9, 12)
        
        self.crearLimitadorIndividual(este, 2, 7)
        self.crearLimitadorIndividual(este, 2, 8)
        self.crearLimitadorIndividual(este, 7, 6)
        
        self.crearLimitadoresIzquierdaVerticales(8, 6, 7)
        self.crearLimitadoresIzquierdaVerticales(8, 9, 12)
        self.crearLimitadoresIzquierdaVerticales(4, 0, 4)
        self.crearLimitadoresIzquierdaVerticales(4, 8, 12)
        self.crearLimitadoresIzquierdaVerticales(0, 5, 7)
        
        self.crearLimitadoresAbajoHorizontales(4, 1, 4)
        self.crearLimitadoresAbajoHorizontales(4, 7, 9)
        self.crearLimitadorIndividual(sur, 5, 7)
        self.crearLimitadorIndividual(sur, 7, 7)
        
        self.crearLimitadoresArribaHorizontales(6, 2, 4)
        self.crearLimitadorIndividual(norte , 7, 6)
        self.crearLimitadorIndividual(norte, 1, 9)
        self.crearLimitadorIndividual(norte, 7, 9)
    }
}