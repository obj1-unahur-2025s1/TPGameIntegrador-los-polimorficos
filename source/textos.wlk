import objetos.*
import wollok.game.*

class TextosInfo {
  const property texto
  const property color
  const property position 

  method text() = texto
  method textColor() = color
  method position() = position
}


object color {
  const property blanco = "#ffffff"
  const property rojo = "#ff0000"
  const property amarillo = "#ffff00"
}
const casaCachito =              new TextosInfo(texto ="               Estas en: Casa de Cachito",             color =color.blanco(), position = game.at(8,15))
const teroPiolado =              new TextosInfo(texto ="               Estas en: Tero Piolado",             color =color.blanco(), position = game.at(8,15))
const presioneParaIniciar =      new TextosInfo(texto ="               Presione (E) para iniciar",             color =color.blanco(), position = game.center()) //Esto capaz se puede mejorar
const iglesiaTeroPiolado =       new TextosInfo(texto ="      Estas en: Iglesia de Tero Piolado",             color =color.blanco(), position = game.at(8,15))
const ovniAlien =                new TextosInfo(texto ="      Estas en: zona de aterrizaje del ovni",             color =color.blanco(), position = game.at(8,15)) //Renombrar
const costaNahuelito =           new TextosInfo(texto ="      Estas en: Costa del lago",             color =color.blanco(), position = game.at(8,15)) //Renombrar
const zonaLuzMala =           new TextosInfo(texto ="         Estas en: Zona de luz Mala",             color =color.blanco(), position = game.at(8,15)) //renombrar