object musicaFondo {
  var musicaFondo = null
  
  method iniciar(num) {
    if (num == 0) {
      musicaFondo = game.sound("zelda.mp3")

    }
    if (num == 1) {
      musicaFondo = game.sound("main.mp3")


    }
    if (num == 2) {
      musicaFondo = game.sound("marciano.mp3")
    }
    musicaFondo.play()
    musicaFondo.shouldLoop(true)
  }
  
  method detener() {
    musicaFondo.stop()
  }
}