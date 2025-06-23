object musicaFondo {
  var property musicaFondo = null
  var pista = null
  var property volumen = 0.25
  
  method iniciar(num) {
    if ((num == 0) && (!self.seEstaReproduciendo(0))) {
      musicaFondo = game.sound("mainTitle.mp3")
      pista = 0
    }
    if ((num == 1) && (!self.seEstaReproduciendo(1))) {
      musicaFondo = game.sound("casaCachito.mp3")
      pista = 1
    }
    if ((num == 2) && (!self.seEstaReproduciendo(2))) {
      musicaFondo = game.sound("marciano.mp3")
      pista = 2
    }
    if ((num == 3) && (!self.seEstaReproduciendo(2))) {
      musicaFondo = game.sound("gameOver.mp3")
      pista = 3
      volumen = 1
    }
    if (num == 4){
      musicaFondo = game.sound("finalboss.mp3")
      pista = 4
      volumen = 0.25
    }

    if (num == 5){
      musicaFondo = game.sound("lore.mp3")
      pista = 5
      volumen = 0.25
    }
    musicaFondo.play()
    musicaFondo.shouldLoop(true)
    musicaFondo.volume(volumen)
  }
  
  method cambiarAPista(num) {
    self.detener() 
    self.iniciar(num)
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
  
  method seEstaReproduciendo(num) = pista == num
}

/*object juiraBicho{
  const sonido = game.sound("juira.mp3")
  const volumen = 0.05
  method iniciar() {
    sonido.volume(volumen)
    sonido.play()
  }
} Despues veo si se me ocurre como solucionar el problema que tiraba - Toby*/