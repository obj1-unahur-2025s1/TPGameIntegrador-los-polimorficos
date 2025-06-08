import escenas.*

object corazon1 {
  const property image = "corazonFull.png"
  const property position = game.at(0,14)
}
object corazon2 {
  const property image = "corazonFull.png"
  const property position = game.at(1,14)
}
object corazon3 {
  const property image = "corazonFull.png"
  const property position = game.at(2,14)
}
object corazon4 {
  const property image = "corazonFull.png"
  const property position = game.at(3,14)
}

//----------------------------------------LIMITES DEL TABLERO----------------------------------------
class Tope {
  var property position = game.origin()

  method ubicarEn(x,y) {
    self.position(game.at(x,y))  
  }
}
        const topeInferior  = new Tope()
        const topeSuperior = new Tope()
        const topeLatIzq    = new Tope()
        const topeLatDer    = new Tope()

//----------------------------------------PUERTAS----------------------------------------

class Puerta{
  const proxZona
  var property image = proxZona.imagenPuerta()
  var property position = game.origin()
  method interaccion(){
    proxZona.interaccion()
  }
  method ubicarEn(x,y) {
    self.position(game.at(x,y))
  }
}
