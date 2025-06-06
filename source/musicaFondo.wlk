object musicaFondo {
  var musicaFondo = null
  var pista = null
  
  method iniciar(num) {
    if (num == 0 &&  !self.seEstaReproduciendo(0)) {
      musicaFondo = game.sound("zelda.mp3")
      pista = 0

    }
    if (num == 1 && !self.seEstaReproduciendo(1)) {
      musicaFondo = game.sound("main.mp3")
      pista = 1

    }
    if (num == 2 && !self.seEstaReproduciendo(2)) {
      musicaFondo = game.sound("marciano.mp3")
      pista = 2
    }
    musicaFondo.play()
    musicaFondo.shouldLoop(true)
    musicaFondo.volume(0.25)
  }
  
  method detener() {
    if (musicaFondo != null) {
    musicaFondo.stop()
    }
  }
  method seEstaReproduciendo(num){
    return pista == num
  }
}