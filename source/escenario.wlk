import wollok.game.*
import cachito.*
import enemigos.*
import musicaFondo.*
import textos.*
import objetos.*
import ubicaciones.*
import escenas.*


object escenario {
  var property elementosEnEscena = []
  var property animar = false
  const property puertas = [
    puertaIglesia,
    puertaNahuelito,
    puertaAlien,
    puertaLuzMala
  ]
  
  method cargarListaconElementos() {
    elementosEnEscena = game.allVisuals()
  }
  
  method borrarTodaLaListaDeelementos() {
    elementosEnEscena.forEach({ a => game.removeVisual(a) })
    elementosEnEscena.clear()
  }
  
  method borrarEscena() {
    self.cargarListaconElementos()
    self.borrarTodaLaListaDeelementos()
  }
  
  method iniciarEscena(unaUbicacion, textoUbicacion) {
    self.borrarEscena()
    game.addVisual(unaUbicacion)
    game.addVisual(textoUbicacion)
  }
  
  method ubicarEnEscena(elementoA, x, y) {
    game.addVisual(elementoA)
    elementoA.ubicarEn(x, y)
  }
  
  method colocarJugadorEn(x, y) {
    game.addVisual(cachito)
    cachito.poscionarEn(game.at(x, y))
  }
  
  method actualizarPuertas() {
    puertas.forEach({ puerta => puerta.actualizarImagen() })
  }
  
  method animarCartel(c1, c2) {
    if (game.hasVisual(c1) && animar) {
      game.removeVisual(c1)
      game.addVisual(c2)
      game.schedule(600, { self.animarCartel(c1, c2) })
    } else {
      if (game.hasVisual(c2) && animar) {
        game.removeVisual(c2)
        game.addVisual(c1)
        game.schedule(600, { self.animarCartel(c1, c2) })
      }
    }
  }
  
  method detenerAnimacion(c1, c2) {
    animar = false
    if (game.hasVisual(c1)) game.removeVisual(c1)
    if (game.hasVisual(c2)) game.removeVisual(c2)
  }
  
  method probabilidadAleatoria() {
    const numeros = [1, 2]
    return numeros.anyOne().even()
  }
}

object batallaFinal {
  const jefe = pomberito
  var duracionTurnoPomberito = 6000
  var pomberitoEnBatalla = false
  var turnoCachito = true
  
  method iniciarPelea() {
      cachito.estaEnCombate(true)
      pomberitoEnBatalla = true
      self.habilitarAtaque() 
  
  }
  
  
  method habilitarAtaque() {
    keyboard.f().onPressDo({ self.gestionarAtaque() })
    if (!cachito.derrotado()) {
      cachito.posicionDeAtaque()
      game.addVisual(cartelAtaque)
      turnoCachito = true
    }
  }
  
  method gestionarAtaque() {
    if ((pomberitoEnBatalla && turnoCachito) && (!cachito.derrotado())) {
      turnoCachito = false
      game.removeVisual(cartelAtaque)
      const duracionCinematica = animacionAtaque.duracion()
      cachito.atacar()
      game.schedule(duracionCinematica, { self.golpearPomberito() })
    }
  }
  
  method golpearPomberito() {
    pomberito.recibirDanio()
    if (pomberito.derrotado()) finalJuego.iniciar()
    else game.schedule(500, { self.etapaDefensa() })
  }
  
  method etapaDefensa() {
    cachito.posicionDeDefensa()
    duracionTurnoPomberito = jefe.duracionAtaque()
    game.schedule(duracionTurnoPomberito + 50, { self.habilitarAtaque() })
  }
  
  method finalizarBatalla() {
    pomberitoEnBatalla = false
    cachito.estaEnCombate(false)
    finalJuego.iniciar()
  }
}