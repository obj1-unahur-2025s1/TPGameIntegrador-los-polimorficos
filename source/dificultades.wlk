import objetos.*
import enemigos.*
import cachito.*


object dificultadFacil {

    method agregarEspinasDelAlien() {
        game.addVisual(new Espina(position = game.at(1, 10)))
        game.addVisual(new Espina(position = game.at(1, 9)))
        game.addVisual(new Espina(position = game.at(1, 8)))
        game.addVisual(new Espina(position = game.at(1, 6)))
        game.addVisual(new Espina(position = game.at(1, 5)))
        game.addVisual(new Espina(position = game.at(1, 3)))
        game.addVisual(new Espina(position = game.at(9, 10)))
        game.addVisual(new Espina(position = game.at(9, 8)))
        game.addVisual(new Espina(position = game.at(9, 7)))
        game.addVisual(new Espina(position = game.at(9, 6)))
        game.addVisual(new Espina(position = game.at(9, 4)))
        game.addVisual(new Espina(position = game.at(9, 3)))
        game.addVisual(new Espina(position = game.at(9, 2)))
        game.addVisual(new Espina(position = game.at(5, 6)))
        game.addVisual(new Espina(position = game.at(7, 1)))
        game.addVisual(new Espina(position = game.at(4, 10)))
  }

  method flashLuzMala() {
    game.addVisual(flash)
    const sonido = game.sound("flash.mp3")
    sonido.volume(0.05)
    sonido.play()
  }

  method moverTotem() {
    luzMala.contador(luzMala.contador() + 1) 
    totemL.position(luzMala.posicionesTotem().anyOne())
  }

  method ataqueNahuelito() {
    game.onTick(850, "atacar", { nahuelito.atacar() })
  }
}

object dificultadDificil {

  method ataquePomberito() {
    const ataques = [ataque1 ,ataque2, ataque3, ataque4]
    ataques.anyOne().atacar()
    }

  method crearYDispararRocaAbajo(x, y, velocidad) {
    const roca = new RocaAbajo(vel = velocidad, x = x, y = y)
    roca.position(pomberito.position())
    roca.disparar()
  }
  
  method crearYDispararRocaIzq(x, y, velocidad) {
    const roca = new RocaIzq(vel = velocidad, x = x, y = y)
    roca.position(pomberito.position())
    roca.disparar()
  }
  
  method crearYDispararRocaDer(x, y, velocidad) {
    const roca = new RocaDer(vel = velocidad, x = x, y = y)
    roca.position(pomberito.position())
    roca.disparar()
  }

  method paredCentral(){
    (2..7).forEach { x => 
      self.crearYDispararRocaAbajo(x, 9, 150)
    }
  }
  
  method paredConHuecosYDesface(x, y){
    (0..7).forEach { i => 
      self.crearYDispararRocaAbajo(i * 2 + x, y, 150)
    }
  }

  method agregarEspinasDelAlien() {
    game.addVisual(new Espina(position = game.at(1, 10)))
    game.addVisual(new Espina(position = game.at(1, 9)))
    game.addVisual(new Espina(position = game.at(1, 8)))
    game.addVisual(new Espina(position = game.at(1, 6)))
    game.addVisual(new Espina(position = game.at(1, 5)))
    game.addVisual(new Espina(position = game.at(1, 3)))
    game.addVisual(new Espina(position = game.at(9, 10)))
    game.addVisual(new Espina(position = game.at(9, 8)))
    game.addVisual(new Espina(position = game.at(9, 7)))
    game.addVisual(new Espina(position = game.at(9, 6)))
    game.addVisual(new Espina(position = game.at(9, 4)))
    game.addVisual(new Espina(position = game.at(9, 3)))
    game.addVisual(new Espina(position = game.at(9, 2)))
    game.addVisual(new Espina(position = game.at(5, 9)))
    game.addVisual(new Espina(position = game.at(5, 6)))
    game.addVisual(new Espina(position = game.at(5, 3)))
    game.addVisual(new Espina(position = game.at(3, 1)))
    game.addVisual(new Espina(position = game.at(5, 1)))
    game.addVisual(new Espina(position = game.at(7, 1)))
    game.addVisual(new Espina(position = game.at(2, 10)))
    game.addVisual(new Espina(position = game.at(3, 10)))
    game.addVisual(new Espina(position = game.at(4, 10)))
  }

  method flashLuzMala() {
    luzMala.ubicarEspina()
    game.addVisual(flash)
    const sonido = game.sound("flash.mp3")
    sonido.volume(0.05)
    sonido.play()
  }

method moverTotem() {
    luzMala.contador(luzMala.contador() + 1) 
    totemL.position(luzMala.posicionesTotem().filter({p=>p != luzMala.espina().position()}).anyOne())
  }

method ataqueNahuelito() {
    game.onTick(700, "atacar", { nahuelito.atacar() })
    game.onTick(3500, "atacar", { nahuelito.ataqueEspecial() })
}
}

object ataque1 {
    method atacar() {
        dificultadDificil.paredCentral()
        game.schedule(5000, { 
          const roca = new RocaAbajo(vel = 100,x=cachito.position().x(),y=9) 
          roca.position(pomberito.position())
          roca.disparar()
          })
    }
}

object ataque2 {
    method atacar() {
        dificultadDificil.paredConHuecosYDesface(0, 7)
        dificultadDificil.paredConHuecosYDesface(1, 9)
        dificultadDificil.paredConHuecosYDesface(0, 11)
    }
}

object ataque3 {
    method atacar() {
      game.onTick(200, "ataque3Pomberito", {
      const roca = new RocaAbajo(vel = 100,x=[0,1,2,3,4,5,6,7,8,9,10].anyOne(),y=9) 
          roca.position(pomberito.position())
          roca.disparar() })
    game.schedule(5500, {game.removeTickEvent("ataque3Pomberito")})
    }
}

object ataque4 {
    method atacar() {
    game.onTick(750, "ataque4Pomberito", {
      const roca = new RocaAbajo(vel = 100,x=cachito.position().x(),y=9) 
          roca.position(pomberito.position())
          roca.disparar()
      const roca1 = new RocaIzq(vel = 250,x=1,y=7) 
          roca1.position(pomberito.position())
          roca1.disparar()
      const roca2 = new RocaDer(vel = 250,x=10,y=7) 
          roca2.position(pomberito.position())
          roca2.disparar() })
          
    game.schedule(5500, {game.removeTickEvent("ataque4Pomberito")})
    }
}