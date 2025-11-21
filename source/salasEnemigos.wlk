import escenario.*
import enemigos.*
import objetos.*
import cachito.*
import musicaFondo.*
import textos.*

class SalaEnemigo{
    const enemigo = null
    const pista = null
    const jugadorX = 0
    const jugadorY = 0
    const lSup = null
    const lInf = null
    const lDer = null
    const lIzq = null
    const tieneAgua = false
    method esExterior() = false
    method esSalaConAgua() = tieneAgua
    var property image = "fondoSala-" + enemigo + "-dificil.png"
    var property position = game.origin()
    method imagenPuerta() = "puerta-" + enemigo + ".png"
    method iniciar(){
        musicaFondo.cambiarAPista(pista)
        self.actualizarFondo()
        escenario.iniciarEscena(self, enemigo.texto())
        escenario.colocarJugadorEn(jugadorX, jugadorY)
        cachito.actualizarImagen()
        barraDeVida.mostrarVidas()
        escenario.ubicarEnEscena(limiteSuperior, 0, lSup)
        escenario.ubicarEnEscena(limiteInferior, 0, lInf)
        escenario.ubicarEnEscena(limiteLatDer, 11, lDer)
        escenario.ubicarEnEscena(limiteLatIzq, -1, lIzq)
        enemigo.iniciar()
        cachito.bloquearMovimiento()
        game.schedule(3000, {cachito.activarMovimiento()})
    }
    method interaccion() {
        cachito.ubicacion(self)
        game.schedule(1000, {
        self.iniciar() })
    }
    method salidaDeLaSala(){
        if (cachito.ubicacion() == self) {
            enemigo.habilitarSalidaDeLaSala()
        }
    }
    method actualizarFondo() {
        if (escenario.enDificil()){
            image = "fondoSala-" + enemigo + "-dificil.png"
        } else {
            image = "fondoSala-" + enemigo + ".png"
        }
    }
}