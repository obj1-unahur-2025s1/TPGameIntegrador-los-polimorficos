import cachito.*

object pomberito {
  var posicion = game.center()
  
  method image() = "pomberito.png"
  
  method position() = posicion
  
  method interaccion() {
    game.sound("grito.mp3").play()
  }
  
  method perseguirPersonaje() {
    const otraPosicion = cachito.position()
    const newX = posicion.x() + if (otraPosicion.x() > posicion.x()) 1 else -1
    const newY = posicion.y() + if (otraPosicion.y() > posicion.y()) 1 else -1
    posicion = game.at(newX, newY)
  }
}

//Renombrar Totems. Capaz hacer clase totem y que cada totem tenga una imagen y nombre distinto. 

object luzMala {
  const totem = "lm" 
  
  method totem() = totem
}

object alien {
  const totem = "a"
  
  method totem() = totem
}

object nahuelito {
  const totem = "nh"
  
  method totem() = totem
}