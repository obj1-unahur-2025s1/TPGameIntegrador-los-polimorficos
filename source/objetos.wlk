import escenas.*
import cachito.*
import escenario.*


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
  method actualizarImagen() {
    self.image(proxZona.imagenPuerta())
  }
}
class CartelAnimado {
  const property image
  const x
  const y 
  method imagen() = image
  method position() = game.at(x,y)
}
class Ola{
  var property image = "Olas.png"
  var property position = cachito.position()
  method disparar(){
		position = self.position().up(1)
		game.addVisual(self)
    game.onTick(200, "disparar", {self.mover()})

  }
  method mover(){
    self.position(self.position().up(1))
    
    if(self.position().y() == 11){
      game.removeVisual(self)
      }
  }
  method interaccion(){
    cachito.recibirDanio()
    //game.removeTickEvent("moverse")
    //game.removeTickEvent("atacar")
  }
}
class OlaRapida inherits Ola{
   override method disparar(){
    position = self.position().up(1)
		game.addVisual(self)
    game.onTick(50, "disparar", {self.mover()})
  }
}
//Totems
class Totem{
  var property image 
  var property position 
  method interaccion() {
    game.removeVisual(self)
    game.removeTickEvent("atacar")
    game.removeTickEvent("moverse")
    cachito.agregarTotem(self)
  }
}

//=====================INSTANCIACIONES=============//

const pres1 = new CartelAnimado(image = "press1.png", x= 1, y = 1)
const pres2 = new CartelAnimado(image = "press2.png", x= 1, y = 1)
const continuar1 = new CartelAnimado(image = "SN1.png", x= 1, y = 4)
const continuar2 = new CartelAnimado(image = "SN2.png", x= 1, y = 4)

const puertaAlPueblo1 = new Puerta(proxZona = pueblo)
const puertaIglesia = new Puerta(proxZona = iglesia)
const puertaNahuelito = new Puerta(proxZona = salaNahuelito)
const puertaAlien = new Puerta(proxZona = salaAlien)
const puertaLuzMala = new Puerta(proxZona = salaLuzMala)