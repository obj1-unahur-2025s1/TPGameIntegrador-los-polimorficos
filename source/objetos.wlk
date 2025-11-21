import ubicaciones.*
import cachito.*
import escenario.*
import salasEnemigos.*
import enemigos.*
import limitadores.*



class Corazon{
  const property numero
  const x = 0
  const property image = "corazonFull.png"
  const property position = game.at(x, 15)

  method agregar() {
    game.addVisual(self)
  }
  method remover() {
    game.removeVisual(self)
  }
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
class PuertaAlPueblo inherits Puerta(proxZona = pueblo) {
  const puebloCoordX
  const puebloCoordY
  override method interaccion(){
    pueblo.x(puebloCoordX)
    pueblo.y(puebloCoordY)
    pueblo.iniciar()
  }
}

//----------------------------------------CARTELES----------------------------------------
class Cartel {
  var property image
  const x
  const y 
  method imagen() = image
  method position() = game.at(x,y)
  method mostrar() {
    game.addVisual(self)
  }
}
class CartelAnimado {
  const property c1
  const property c2
  method animar() {
    escenario.animar(true)
    escenario.animarCartel(c1, c2)
  }
  method detenerAnimacion() {
    escenario.detenerAnimacion(c1, c2)
  }
}
//----------------------------------------ELEMENTOS USADOS EN ATAQUES DE ENEMIGOS----------------------------------------
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
    
    if(self.llegoAlLimite()){
      game.removeVisual(self)
      }
  }

  method llegoAlLimite() {
    return
      self.position().y() == 11
  }
  method interaccion(){
    cachito.recibirDaño()
  }
}
class OlaRapida inherits Ola{
   override method disparar(){
    position = self.position().up(1)
		game.addVisual(self)
    game.onTick(50, "disparar", {self.mover()})
  }
}

class RocaDer inherits Ola(image = "roca.png") {
  const x
  const y
  const vel = 333
  override method disparar(){
    position = game.at(x, y)
    game.addVisual(self)
    game.onTick(vel, "disparar roca", {self.mover()})
  }

  method moverEnSuDireccion() {
    self.position(self.position().left(1))
  }
  override method mover(){
    self.position(self.position().down(1))
    self.moverEnSuDireccion()

    if(self.llegoAlLimite()){
      game.removeVisual(self)
    }
  }

  override method llegoAlLimite() {
    return
      self.position().y() == -1 || self.position().x() == -1
  }
}

class RocaIzq inherits RocaDer {

  override method moverEnSuDireccion() {
    self.position(self.position().right(1))
  }

  override method llegoAlLimite() {
    return
      self.position().y() == 0 || self.position().x() == 11
  }
}

class RocaAbajo inherits RocaIzq {

  override method mover(){
    self.position(self.position().down(1))

    if(self.llegoAlLimite()){
      game.removeVisual(self)
    }
  }
}

object flash{
  var property image = "ataqueLuzMala.png"
  var property position = game.origin()
}

class Espina{
  var property image = "espinas.png"
  var property position 

  method interaccion(){
    cachito.recibirDaño()
  }
}

//-------------------------TOTEM---------------------------------------
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

//-------------------------PISTAS---------------------------------------
class Pista {

  var property cancion 
  var property volumen = 0.25
  var property loop = true
}



//=====================INSTANCIACIONES=============//
//LIMITES
const limiteInferior  = new Limite()
const limiteSuperior = new Limite()
const limiteLatIzq    = new Limite()
const limiteLatDer    = new Limite()
//CORAZONES-BARRA DE VIDA
const corazon1 = new Corazon(numero = 1)
const corazon2 = new Corazon(numero = 2 , x=1)
const corazon3 = new Corazon(numero = 3 , x=2)
const corazon4 = new Corazon(numero = 4 , x=3)
const corazon5 = new Corazon(numero = 5 , image = "corazonDorado.png")
const corazon6 = new Corazon(numero = 6 , image = "corazonDorado.png", x=1)
//CARTELES
const iniciar1 = new Cartel(image = "press1.png", x= 1, y = 1)
const iniciar2 = new Cartel(image = "press2.png", x= 1, y = 1)
const spaceParaContinuar1 = new Cartel(image = "cont1.png", x= 0, y = 0)
const cartelAtaque = new Cartel (image = "cartelDeAtaque.png", x =1, y = 13)
const reiniciar1 = new Cartel(image = "SN1.png", x= 2, y = 5)
const reiniciar2 = new Cartel(image = "SN2.png", x= 2, y = 5)
const cartelFacil = new Cartel(image = "cFacil.png", x= 0, y = 3)
const cartelDificil = new Cartel(image = "cDificil.png", x= 0, y = 3)
const cartelIniciar = new CartelAnimado(c1 = iniciar1, c2 = iniciar2)
const ovniAnimado = new CartelAnimado(c1 = ovni1, c2 = ovni2)
const cartelReiniciar = new CartelAnimado(c1 = reiniciar1, c2 = reiniciar2)
//OVNI (SE DEFINE COMO CARTEL PARA PODER ANIMARLO)
const ovni1 = new Cartel(image = "animacionO1.png", x= 4, y = 13)
const ovni2 = new Cartel(image = "ov2.png", x= 4, y = 13)

//PUERTAS HACIA OTRAS ZONAS
const puertaIglesia = new Puerta(proxZona = iglesia)
const puertaNahuelito = new Puerta(proxZona = salaNahuelito)
const puertaAlien = new Puerta(proxZona = salaAlien)
const puertaLuzMala = new Puerta(proxZona = salaLuzMala)

//PUERTAS HACIA EL PUEBLO
const puertaSalidaCasa = new PuertaAlPueblo(puebloCoordX = 9, puebloCoordY = 12)
const puertaSalidaNahuelito = new PuertaAlPueblo(puebloCoordX = 5, puebloCoordY = 2)
const puertaSalidaAlien = new PuertaAlPueblo(puebloCoordX = 9, puebloCoordY = 8, image= "latIzq.png")
const puertaSalidaLuzMala = new PuertaAlPueblo(puebloCoordX = 2, puebloCoordY = 8, image= "latD.png")

//TOTEMS
const totemL = new Totem(image = "totemLuzMala.png", position = luzMala.posicionesTotem().anyOne(),salaEnemigo = salaLuzMala)
const totemA = new Totem(image = "totemAlien.png", position = game.at(5,11), salaEnemigo = salaAlien)
const totemN = new Totem(image = "totemNahue.png", position = game.at(5,4), salaEnemigo = salaNahuelito)

//MUSICA DE FONDO
const selectDiff = new Pista(cancion = "selectDiff.mp3" , volumen = 0.25)
const pistaTitulo = new Pista(cancion = "mainTitle.mp3")
const pistaPueblo = new Pista(cancion = "pueblo.mp3")
const pistaCasa = new Pista(cancion = "casaCachito.mp3")
const pistaAlien = new Pista(cancion = "marciano.mp3")
const pistaGameOver = new Pista(cancion = "gameOver.mp3" , volumen = 1)
const pistaLore = new Pista(cancion = "lore.mp3")
const pistaFinalBoss = new Pista(cancion = "finalboss.mp3" , volumen = 0.05)
const pistaNahuelito = new Pista(cancion = "peleaNahuelito.mp3")
const pistaFinal = new Pista(cancion = "final.mp3" , loop = false)
const pistaLuzMala = new Pista(cancion = "luzMala.mp3")

//=========================VARIOS==========================//
object mujerCachito {
  var property image = "mujerCachito.png"
  var property position = game.at(0,0)

  method ubicarEn(x,y) {
    self.position(game.at(x,y))
  }

  method interaccion() {
    cachito.tiempoDeInmunidad(3000)
    game.say(self , "En tu batalla contra el pomberito luego de recibir un ataque vas a ser inmune por 3 segundos")
  }
}

object gauchitoGil {
    var property image = "gauchitoGil.png"
  	var property position = game.at(0,0)

  method ubicarEn(x,y) {
    self.position(game.at(x,y))
  }

  method interaccion() {
    cachito.vida(6)
    barraDeVida.vidas([corazon1 , corazon2 , corazon3 , corazon4 , corazon5, corazon6])
    game.say(self , "Para cuando te encuentres al pomberito, vas a estar curado")
  }
}
//=========================DIRECCIONES==========================//
object norte{
  method imagen(){
    var img = null
    if (cachito.estaEnUnExterior()){
      img = "cachitoN.png"
    }else{
      if (cachito.estaEnElAgua()) {
        img = "cachitoBN.png"
      }else{
        img = "cachitoIntN.png"
      }
    }
    return img
  }
  method puedeAvanzar() = ((limiteSuperior.position().y() - 1) > cachito.position().y()) && cachito.puedeMoverse()
  method avanzar(){
  	cachito.position(cachito.position().up(1))
    cachito.mirandoAl(self)
    cachito.actualizarImagen()
  }
  method crearLimitadorDeMovimiento(x , y) {
    escenario.ubicarEnEscena(new LimitadorArriba(), x, y)
  }
}

object sur{
  method imagen(){
    var img = null
    if (cachito.estaEnUnExterior()){
      img = "cachitoS.png"
    }else{
      if (cachito.estaEnElAgua()) {
        img = "cachitoBS.png"
      }else{
        img = "cachitoIntS.png"
      }
    }
    return img
  }
  method puedeAvanzar() = ((limiteInferior.position().y() + 1) < cachito.position().y()) && cachito.puedeMoverse()
  method avanzar(){
  	cachito.position(cachito.position().down(1))
    cachito.mirandoAl(self)
    cachito.actualizarImagen()
  }
  method crearLimitadorDeMovimiento(x , y) {
    escenario.ubicarEnEscena(new LimitadorAbajo(), x, y)
  }
}

object este{
  method imagen(){
    var img = null
    if (cachito.estaEnUnExterior()){
      img = "cachitoE.png"
    }else{
      if (cachito.estaEnElAgua()) {
        img = "cachitoBE.png"
      }else{
        img = "cachitoIntE.png"
      }
    }
    return img
  }
  method puedeAvanzar() = ((limiteLatDer.position().x() - 1) > cachito.position().x()) && cachito.puedeMoverse()
  method avanzar(){
  	cachito.position(cachito.position().right(1))
    cachito.mirandoAl(self)
    cachito.actualizarImagen()
  }
  method crearLimitadorDeMovimiento(x , y) {
    escenario.ubicarEnEscena(new LimitadorDerecha(), x, y)
  }
}

object oeste{
  method imagen(){
    var img = null
    if (cachito.estaEnUnExterior()){
      img = "cachitoO.png"
    }else{
      if (cachito.estaEnElAgua()) {
        img = "cachitoBO.png"
      }else{
        img = "cachitoIntO.png"
      }
    }
    return img
  }
  method puedeAvanzar() = ((limiteLatIzq.position().x() + 1) < cachito.position().x()) && cachito.puedeMoverse()
  method avanzar(){
  	cachito.position(cachito.position().left(1))
		cachito.mirandoAl(self)
		cachito.actualizarImagen()
  }
  method crearLimitadorDeMovimiento(x , y) {
    escenario.ubicarEnEscena(new LimitadorIzquierda(), x, y)
  }
}