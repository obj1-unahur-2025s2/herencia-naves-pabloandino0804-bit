class Nave {
  var velocidad = 0
  var direccionRespectoAlSol = 0
  var combustible = 0

  method velocidad() = velocidad

  method direccionRespectoAlSol() = direccionRespectoAlSol.min(10).max(-10)
  method acelerar(cuanto) {
    velocidad = (velocidad + cuanto).min(100000).max(0)
  }

  method desacelerar(cuanto){
    velocidad = (velocidad - cuanto).min(100000).max(0)
  }

  method irHaciaElSol() {
    direccionRespectoAlSol = 10
  }

  method escaparDelSol() {
    direccionRespectoAlSol = -10
  }

  method ponerseParaleloAlSol() {
    direccionRespectoAlSol = 0
  }

  method acercarseUnPocoAlSol() {
    direccionRespectoAlSol = (direccionRespectoAlSol + 1).min(10)
  }

  method alejarseUnPocoDelSol() {
    direccionRespectoAlSol = (direccionRespectoAlSol - 1).max(-10)
  }

  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }

  method cargarCombustible(cantidad) {
    combustible += cantidad
  }

  method descargarCombustible(cantidad) {
    combustible -= cantidad
  }

  method combustible() = combustible

  method estaTranquila() = combustible <= 4000 and velocidad < 12000

  method escapar() {}

  method avisar() {}

  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
}

class NaveBaliza inherits Nave {
  var color

  method cambiarColorDeBaliza(colorNuevo) {
    color = colorNuevo
  }

  method color() = color

  override method prepararViaje(){
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
    super()
  }

  override method estaTranquila() = super() and color != "rojo"

  override method escapar() {
    self.irHaciaElSol() 
  }

  override method avisar() {
    self.cambiarColorDeBaliza("rojo")
  }
}

class NavePasajeros inherits Nave {
  var  property cantidadDePasajeros
  var comida
  var bebida

  method comida() = comida
  method bebida() = bebida

  method cargarComida(cantidad) {
    comida += cantidad
  }

  method descargarComida(cantidad) {
    comida -= cantidad
  }

  method cargarBebida(cantidad) {
    bebida += cantidad
  }

  method descargarBebida(cantidad) {
    bebida -= cantidad
  }

  override method prepararViaje(){
    self.cargarComida(4 * cantidadDePasajeros)
    self.cargarBebida(6 * cantidadDePasajeros)
    super()
  }

  override method escapar() {
    velocidad = velocidad * 2
  }

  override method avisar() {
    comida = comida - cantidadDePasajeros
    bebida = bebida - cantidadDePasajeros
  }
}

class NaveDeCombate inherits Nave {
  var estaVisible = true
  var misilesDesplegados = false
  const property mensajesEmitidos = []

  method estaVisible() = estaVisible

  method ponerseVisible() {
    estaVisible = true
  }

  method ponerseInvisible() {
    estaVisible = false
  }

  method desplegarMisiles() {
    misilesDesplegados = true
  }

  method  replegarMisiles() {
    misilesDesplegados = false
  }

  method misilesDesplegados() = misilesDesplegados

  method emitirMensaje(mensaje) {
    mensajesEmitidos.add(mensaje)
  }

  method primerMensajeEmitido() = mensajesEmitidos.first()

  method ultimoMensajeEmiriso() = mensajesEmitidos.last()

  method esEscueta() = mensajesEmitidos.all({unMensaje => unMensaje.length() <= 30})

  method emitioMensaje(mensaje) = mensajesEmitidos.contains(mensaje)

  override method prepararViaje(){
    self.ponerseVisible()
    self.replegarMisiles()
    super()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en misión")
  }

  override method estaTranquila() = super() and not misilesDesplegados

  override method escapar() {
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
  }

  override method avisar() {
    self.emitirMensaje("Amenaza recibida")
  }
}

class NaveHospital inherits NavePasajeros {
  var tieneQuirofanos

  method tieneQuirofanos() = tieneQuirofanos

  method prepararQuirofanos() {
    tieneQuirofanos = true
  }

  method usarQuirofanos() {
    tieneQuirofanos = false
  }

  override method estaTranquila() = super() and not tieneQuirofanos

  override method recibirAmenaza() {
    super()
    self.prepararQuirofanos()
  }
}

class NaveDeCombateSigilosa inherits NaveDeCombate {
  override method estaTranquila() = super() and estaVisible

  override method escapar() {
    super()
    self.desplegarMisiles()
    self.ponerseInvisible() 
  }
}