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
    // Métodos auxiliares para crear limitadores en rangos
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
    
    method crearLimitadorIndividual(tipo, x, y) {
        if (tipo == "arriba") {
            escenario.ubicarEnEscena(new LimitadorArriba(), x, y)
        } else if (tipo == "abajo") {
            escenario.ubicarEnEscena(new LimitadorAbajo(), x, y)
        } else if (tipo == "derecha") {
            escenario.ubicarEnEscena(new LimitadorDerecha(), x, y)
        } else if (tipo == "izquierda") {
            escenario.ubicarEnEscena(new LimitadorIzquierda(), x, y)
        }
    }

    method agregarLimitadoresEnCasa() {
        // Limitadores arriba - línea superior
        self.crearLimitadoresArribaHorizontales(10, 0, 3)
        self.crearLimitadoresArribaHorizontales(10, 7, 10)
        self.crearLimitadoresArribaHorizontales(9, 4, 6)
        
        // Limitadores específicos
        escenario.ubicarEnEscena(new LimitadorArriba(), 7, 4)
        
        // Limitadores derecha
        self.crearLimitadoresDerechaVerticales(8, 3, 9)
        
        // Limitadores izquierda  
        self.crearLimitadoresIzquierdaVerticales(9, 3, 9)
    }

    method agregarLimitadoresEnPueblo() {
        // Limitadores derecha en columnas específicas
        self.crearLimitadoresDerechaVerticales(10, 5, 7)
        self.crearLimitadoresDerechaVerticales(10, 9, 12)
        self.crearLimitadoresDerechaVerticales(6, 0, 4)
        self.crearLimitadoresDerechaVerticales(6, 9, 12)
        
        // Limitadores derecha individuales
        self.crearLimitadorIndividual("derecha", 2, 7)
        self.crearLimitadorIndividual("derecha", 2, 8)
        self.crearLimitadorIndividual("derecha", 7, 6)
        
        // Limitadores izquierda en columnas específicas
        self.crearLimitadoresIzquierdaVerticales(8, 6, 12)
        self.crearLimitadoresIzquierdaVerticales(4, 0, 4)
        self.crearLimitadoresIzquierdaVerticales(4, 8, 12)
        self.crearLimitadoresIzquierdaVerticales(0, 5, 7)
        
        // Limitadores abajo en fila específica
        self.crearLimitadoresAbajoHorizontales(4, 1, 4)
        self.crearLimitadoresAbajoHorizontales(4, 7, 9)
        self.crearLimitadorIndividual("abajo", 5, 7)
        self.crearLimitadorIndividual("abajo", 7, 7)
        
        // Limitadores arriba específicos
        self.crearLimitadoresArribaHorizontales(6, 2, 4)
        self.crearLimitadorIndividual("arriba", 7, 6)
        self.crearLimitadorIndividual("arriba", 1, 9)
        self.crearLimitadorIndividual("arriba", 7, 9)
    }
}