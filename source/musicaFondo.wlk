object musicaFondo {
  var property musicaFondo = null
  var pista = null
  var property volumen = 0.25
  
  method iniciar(unaPista) {
    self.detener()
    if ((unaPista == "pistaTitulo") && (!self.seEstaReproduciendo(unaPista))) {
      musicaFondo = game.sound("mainTitle.mp3")
      pista = "pistaTitulo"
    }
    if ((unaPista == "pistaCasa") && (!self.seEstaReproduciendo(unaPista))) {
      musicaFondo = game.sound("casaCachito.mp3")
      pista = "pistaCasa"
    }
    if ((unaPista == "pistaAlien") && (!self.seEstaReproduciendo(unaPista))) {
      musicaFondo = game.sound("marciano.mp3")
      pista = "pistaAlien"
    }
    if ((unaPista == "pistaGameOver") && (!self.seEstaReproduciendo(unaPista))) {
      musicaFondo = game.sound("gameOver.mp3")
      pista = "pistaGameOver"
      volumen = 1
    }
    if (unaPista == "pistaFinalBoss"){
      musicaFondo = game.sound("finalboss.mp3")
      pista = "pistaFinalBoss"
      volumen = 0.05
    }

    if (unaPista == "pistaLore"){
      musicaFondo = game.sound("lore.mp3")
      pista = "pistaLore"
      volumen = 0.25
    }

    if (unaPista == "pistaNahuelito") {
      musicaFondo = game.sound("peleaNahuelito.mp3")
      pista = "pistaNahuelito"
      volumen = 0.25
    }

    if (unaPista == "pistaFinal") {
      musicaFondo = game.sound("final.mp3")
      pista = "pistaFinal"
      volumen = 0.25
    }

    
    musicaFondo.play()
    musicaFondo.shouldLoop(true)
    musicaFondo.volume(volumen)
  }
  
  method cambiarAPista(unaPista) {
    self.detener()
    if (unaPista != null) self.iniciar(unaPista)
  }
  
  method detener() {
    if (pista != null) {
      musicaFondo.stop()
      pista = null
      musicaFondo = null
    }
  }

  method pausar() {
    if (musicaFondo != null) {
      musicaFondo.pause()
    }
  }
  method reanudar() {
    if (musicaFondo != null) {
      musicaFondo.resume()
    }
  }
  method reestablecerPista(){ pista= null }
  method seEstaReproduciendo(num) = pista == num
}
