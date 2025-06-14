import ubicaciones.*
import cachito.*
import escenario.*


class Corazon{
  const x = 0
  const property image = "corazonFull.png"
  const property position = game.at(x, 15)
}

//----------------------------------------LIMITES DEL TABLERO----------------------------------------
class Limite {
  var property position = game.origin()
  method ubicarEn(x,y) {
    self.position(game.at(x,y))  
  }
}
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
class PuertaAlPueblo inherits Puerta{
  const puebloCoordX
  const puebloCoordY
  override method interaccion(){
    pueblo.x(puebloCoordX)
    pueblo.y(puebloCoordY)
    pueblo.iniciar()
  }
}
class Cartel {
  const property image
  const x
  const y 
  method imagen() = image
  method position() = game.at(x,y)
}
class CartelAnimado {
  const property c1
  const property c2
  method animar() {
    escenario.animarCartel(c1, c2)
  }
  method detenerAnimacion() {
    escenario.detenerAnimacion(c1, c2)
  }
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
  const salaEnemigo 
  method interaccion() {
    game.removeVisual(self)
    salaEnemigo.salidaDeLaSala()
    game.removeTickEvent("atacar")
    game.removeTickEvent("moverse")
    cachito.agregarTotem(self)
  }
}

object flash{
  var property image = "ataqueLuzMala.png"
  var property position = game.origin()
}

//=====================INSTANCIACIONES=============//
//LIMITES
const limiteInferior  = new Limite()
const limiteSuperior = new Limite()
const limiteLatIzq    = new Limite()
const limiteLatDer    = new Limite()
//CORAZONES-BARRA DE VIDA
const corazon1 = new Corazon()
const corazon2 = new Corazon(x=1)
const corazon3 = new Corazon(x=2)
const corazon4 = new Corazon(x=3)
//CARTELES
const iniciar1 = new Cartel(image = "press1.png", x= 1, y = 1)
const iniciar2 = new Cartel(image = "press2.png", x= 1, y = 1)
const opcionGameOver1 = new Cartel(image = "SN1.png", x= 1, y = 4)
const opcionGameOver2 = new Cartel(image = "SN2.png", x= 1, y = 4)
const spaceParaContinuar1 = new Cartel(image = "cont1.png", x= 0, y = 4)
const cartelIniciar = new CartelAnimado(c1 = iniciar1, c2 = iniciar2)
const cartelGameOver = new CartelAnimado(c1 = opcionGameOver1, c2 = opcionGameOver2)
const ovniAnimado = new CartelAnimado(c1 = ovni1, c2 = ovni2)

//OVNI (SE DEFINE COMO CARTEL PARA PODER ANIMARLO)
const ovni1 = new Cartel(image = "ov1.png", x= 4, y = 13)
const ovni2 = new Cartel(image = "ov2.png", x= 4, y = 13)

//PURTAS HACIAOTRAS ZONAS
const puertaIglesia = new Puerta(proxZona = iglesia)
const puertaNahuelito = new Puerta(proxZona = salaNahuelito)
const puertaAlien = new Puerta(proxZona = salaAlien)
const puertaLuzMala = new Puerta(proxZona = salaLuzMala)

//PUERTAS HACIA EL PUEBLO
const puertaSalidaCasa = new PuertaAlPueblo(proxZona = pueblo, puebloCoordX = 9, puebloCoordY = 12)
const puertaSalidaNahuelito = new PuertaAlPueblo(proxZona = pueblo, puebloCoordX = 5, puebloCoordY = 2)
const puertaSalidaAlien = new PuertaAlPueblo(proxZona = pueblo, puebloCoordX = 9, puebloCoordY = 8, image= "latIzq.png")
const puertaSalidaLuzMala = new PuertaAlPueblo(proxZona = pueblo, puebloCoordX = 1, puebloCoordY = 8, image= "latDer.png")

//TOTEMS
const totemL = new Totem(image = "totemLuzMala.png", position = self.posicionesTotem().get(1),salaEnemigo = salaLuzMala)
const totemA = new Totem(image = "totemAlien.png", position = game.at(5,11), salaEnemigo = salaAlien)
const totemN = new Totem(image = "totemNahue.png", position = game.at(5,4), salaEnemigo = salaNahuelito)