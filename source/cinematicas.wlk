import escenario.*
import musicaFondo.*
import escenas.*
import ubicaciones.*
import objetos.*

class PantallaCinematica{
    var property image 
    var property position = game.origin()
    const delay = 350 // originalmente 200
    const siguiente
    method iniciar() {
        escenario.borrarEscena()
        game.addVisual(self)
        game.schedule(delay,{siguiente.iniciar() game.removeVisual(self)})
    } 

}


class PantallaCinematicaEspecial inherits PantallaCinematica (delay = 1500) {
  const tecla = keyboard.space()
  method accionTecla() {siguiente.iniciar()}
  override method iniciar() {
    escenario.borrarEscena() 
    game.addVisual(self)
    game.addVisual(spaceParaContinuar1)
    accionesTeclas.pantallaValida(true)
    accionesTeclas.asignarTecla(tecla)
    accionesTeclas.actualizarPantalla(self)
    accionesTeclas.accion()
  }
}
/*
//=========================Pantallas Cinematica Inicial=========================//
const inicio1 = new PantallaCinematica(delay = 500,image="p1.png", siguiente=inicio2)
const inicio2 = new PantallaCinematica(delay = 500,image="p2.png", siguiente=inicio3)
const inicio3 = new PantallaCinematica(delay = 500,image="p3.png", siguiente=inicio4)
const inicio4 = new PantallaCinematica(delay = 500,image="p4.png", siguiente=inicio5)
const inicio5 = new PantallaCinematica(delay = 500,image="p5.png", siguiente=inicio6)
const inicio6 = new PantallaCinematica(delay = 500,image="p6.png", siguiente=portada)
//=========================Pantallas Cinematica Lore=========================//
const lore1 = new PantallaCinematica(delay = 500,image="l1.png", siguiente=lore2)
const lore2 = new PantallaCinematica(delay = 500,image="l2.png", siguiente=lore3)
const lore3 = new PantallaCinematica(delay = 500,image="l3.png", siguiente=lore4)
const lore4 = new PantallaCinematica(delay = 500,image="l4.png", siguiente=lore5)
const lore6 = new PantallaCinematica(delay = 500,image="l6.png", siguiente=lore7)
const lore7 = new PantallaCinematica(delay = 500,image="l7.png", siguiente=lore8)
const lore8 = new PantallaCinematica(delay = 500,image="l8.png", siguiente=lore9)
const lore9 = new PantallaCinematica(delay = 500,image="l9.png", siguiente=lore10)
const lore10 = new PantallaCinematica(delay = 500,image="l10.png", siguiente=lore11)
const lore11 = new PantallaCinematica(delay = 500,image="l11.png", siguiente=lore12)
//===========================Pantallas Cinematicas Entrada a la iglesia========================//
const escenaPomberito1 = new PantallaCinematica(delay = 4000 ,image="escenaPomberito1.png", siguiente=escenaPomberito2)
const escenaPomberito2 = new PantallaCinematica(delay = 6000 ,image="escenaPomberito2.png", siguiente=iglesia)
*/