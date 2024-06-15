extends Node2D
@onready var hud_jugador: Node = $HUD_jugador
@onready var hud_enemigo: Node = $HUD_enemigo
@onready var timer: Timer = $Timer
@onready var tiempo: Label = $Tiempo
@onready var fase: Label = $Fase
@onready var cartas_jugador: Node = $CartasJugador
@onready var cartas_enemigo: Node = $CartasEnemigo
@onready var ruletas: Node = $Ruletas
@onready var timer_2: Timer = $Timer2
@onready var info_jugador: Node2D = $InfoJugador
@onready var info_enemigo: Node2D = $InfoEnemigo
@onready var timer_3: Timer = $Timer3
@onready var condicion_juego: Node2D = $CondicionJuego
@onready var descripcion: RichTextLabel = $Descripcion
@onready var timer_4: Timer = $Timer4
var tiempoInicial: int = 20
var tiempoRestante: int = 0
var puestoRuleta: int = 0
var guardarRuletaJugador = []
var guardarRuletaEnemigo = []
var guardarAcciones = []
var rondaJugador: int = 0
var rondaEnemigo: int = 0
var turnoJugador: bool = true
var turnoEnemigo: bool = false
var castigoJugador: int = 0
var temporalJugador = []
var temporalEnemigo = []
var bonusJugador: int = 0
var bonusEnemigo: int = 0
var carta1 = preload("res://Imagenes/Carta1.png")
var carta2 = preload("res://Imagenes/carta2.png")
var cuadro = preload("res://Imagenes/cuadro1.png")
var cuadroRojo = preload("res://Imagenes/cuadro1Rojo.png")
var ganar = preload("res://Imagenes/Ganar.png")
var perder = preload("res://Imagenes/Perder.png")
var pingpong: bool = true

func _ready() -> void:
	fase.text = "ELEGIR"
	tiempoRestante = tiempoInicial
	generarVidas()
	generarCartas()
	visibleLucha()
	guardarRuletaJugador = []
	guardarRuletaEnemigo = []
	castigoJugador = 0
	rondaJugador = 0
	rondaEnemigo = 0
	descripcion.text = ""

func _on_timer_timeout() -> void:
	info_jugador.get_node("Label").text = ""
	info_enemigo.get_node("Label").text = ""
	tiempoRestante -= 1
	if tiempoRestante < 0:
		estadoRuleta(false)
	else:
		estadoRuleta()

func estadoRuleta(condicion = true) -> void:
	if !condicion:
		fase.text = "PELEAR"
		tiempoRestante = 0
		tiempo.text = ""
		timer.stop()
		timer_2.stop()
		validarElecciones()
		cambioRuleta(false)
		visibleLucha(false)
	else:
		fase.text = "ELEGIR"
		tiempo.text = str(tiempoRestante)

func generarVidas() -> void:
	var vidaJugador = VARIABLES.vidaJugador
	var saludJugador = VARIABLES.saludJugador
	var proteccionJugador = VARIABLES.proteccionJugador
	var vidaEnemigo = VARIABLES.vidaEnemigo
	var saludEnemigo = VARIABLES.saludEnemigo
	var proteccionEnemigo = VARIABLES.proteccionEnemigo
	for i in vidaJugador:
		var nodo = i+1
		if saludJugador > 0:
			if proteccionJugador > 0:
				hud_jugador.get_node("co"+str(nodo)).texture = preload("res://Imagenes/vidaEscudo.png")
				proteccionJugador -= 1
			else:
				hud_jugador.get_node("co"+str(nodo)).texture = preload("res://Imagenes/vidaLlena.png")
			saludJugador -= 1
		else:
			hud_jugador.get_node("co"+str(nodo)).texture = preload("res://Imagenes/vidaVacia.png")
	for j in vidaEnemigo:
		var nodo = j+1
		if saludEnemigo > 0:
			if proteccionEnemigo > 0:
				hud_enemigo.get_node("co"+str(nodo)).texture = preload("res://Imagenes/vidaEscudo.png")
				proteccionEnemigo -= 1
			else:
				hud_enemigo.get_node("co"+str(nodo)).texture = preload("res://Imagenes/vidaLlena.png")
			saludEnemigo -= 1
		else:
			hud_enemigo.get_node("co"+str(nodo)).texture = preload("res://Imagenes/vidaVacia.png")

func generarCartas() -> void:
	var cartaCiclo = ""
	var cartasJugador = VARIABLES.cartasJugador
	var cartasEnemigo = VARIABLES.cartasEnemigo
	for i in cartasJugador:
		cartaCiclo = cartasJugador[i]
		var nombreCarta = cartaCiclo["nombre"]
		var dañoCarta = cartaCiclo["daño"]
		var ciclosCarta = cartaCiclo["ciclos"]
		var tiempoCarta = cartaCiclo["tiempo"]
		var congeladoCarta = cartaCiclo["congelado"]
		if congeladoCarta != 0:
			tiempoCarta = congeladoCarta
		if nombreCarta == "Ataque":
			cartas_jugador.get_node("Carta"+str(i)+"/icono").texture = preload("res://Imagenes/ataque.png")
		if nombreCarta == "Curar":
			cartas_jugador.get_node("Carta"+str(i)+"/icono").texture = preload("res://Imagenes/curar.png")
		if nombreCarta == "Regeneración":
			cartas_jugador.get_node("Carta"+str(i)+"/icono").texture = preload("res://Imagenes/regeneracion.png")
		if nombreCarta == "Defender":
			cartas_jugador.get_node("Carta"+str(i)+"/icono").texture = preload("res://Imagenes/defender.png")
		if nombreCarta == "Aumentar Daño":
			cartas_jugador.get_node("Carta"+str(i)+"/icono").texture = preload("res://Imagenes/aumentarDaño.png")
		if nombreCarta == "Envenenar":
			cartas_jugador.get_node("Carta"+str(i)+"/icono").texture = preload("res://Imagenes/envenenar.png")
		cartas_jugador.get_node("Carta"+str(i)+"/dañoF/Label").text = str(dañoCarta)
		cartas_jugador.get_node("Carta"+str(i)+"/ciclos/Label").text = str(ciclosCarta)
		cartas_jugador.get_node("Carta"+str(i)+"/congeladoF/Label").text = str(tiempoCarta)
		if tiempoCarta > 0:
			cartas_jugador.get_node("Carta"+str(i)).texture = carta2
		else:
			cartas_jugador.get_node("Carta"+str(i)).texture = carta1
	
	for i in cartasEnemigo:
		cartaCiclo = cartasEnemigo[i]
		var nombreCarta = cartaCiclo["nombre"]
		var dañoCarta = cartaCiclo["daño"]
		var ciclosCarta = cartaCiclo["ciclos"]
		var tiempoCarta = cartaCiclo["tiempo"]
		if nombreCarta == "Ataque":
			cartas_enemigo.get_node("Carta"+str(i)+"/icono").texture = preload("res://Imagenes/ataque.png")
		if nombreCarta == "Curar":
			cartas_enemigo.get_node("Carta"+str(i)+"/icono").texture = preload("res://Imagenes/curar.png")
		if nombreCarta == "Regeneración":
			cartas_enemigo.get_node("Carta"+str(i)+"/icono").texture = preload("res://Imagenes/regeneracion.png")
		if nombreCarta == "Defender":
			cartas_enemigo.get_node("Carta"+str(i)+"/icono").texture = preload("res://Imagenes/defender.png")
		if nombreCarta == "Aumentar Daño":
			cartas_enemigo.get_node("Carta"+str(i)+"/icono").texture = preload("res://Imagenes/aumentarDaño.png")
		if nombreCarta == "Envenenar":
			cartas_enemigo.get_node("Carta"+str(i)+"/icono").texture = preload("res://Imagenes/envenenar.png")
		if dañoCarta > 0:
			cartas_enemigo.get_node("Carta"+str(i)+"/dañoF/Label").text = str(dañoCarta)
		if ciclosCarta > 0:
			cartas_enemigo.get_node("Carta"+str(i)+"/ciclos/Label").text = str(ciclosCarta)

func _on_timer_2_timeout() -> void:
	if pingpong == true:
		puestoRuleta += 1
	else:
		puestoRuleta -= 1
	if puestoRuleta == 5:
		pingpong = false
	elif puestoRuleta == 0:
		pingpong = true
	cambioRuleta()

func cambioRuleta(condicion = true):
	if condicion:
		for i in 6:
			if i == puestoRuleta:
				ruletas.get_node("Ruleta"+str(i)).texture = preload("res://Imagenes/flechasRuletaOn.png")
			else:
				ruletas.get_node("Ruleta"+str(i)).texture = preload("res://Imagenes/flechasRuletaOff.png")
	else:
		for i in 6:
			ruletas.get_node("Ruleta"+str(i)).texture = preload("res://Imagenes/flechasRuletaOff.png")

func _input(event: InputEvent) -> void:
	event = event
	if Input.is_action_just_pressed("espacio"):
		if guardarRuletaJugador.size() < 3 && guardarRuletaEnemigo.size() < 3:
			validarAccion()
			rondaCartas()
			dibujarAcciones()
			if guardarRuletaJugador.size() == 3 || guardarRuletaEnemigo.size() == 3:
				estadoRuleta(false)
		generarCartas()

func rondaCartas() -> void:
	for i in VARIABLES.cartasJugador:
		if VARIABLES.cartasJugador[i]["tiempo"] > 0:
			VARIABLES.cartasJugador[i]["tiempo"] -= 1

func validarAccion():
	var validarJugador = VARIABLES.cartasJugador[puestoRuleta]
	var validarEnemigo = VARIABLES.cartasEnemigo[puestoRuleta]
	if validarJugador["tiempo"] == 0:
		if validarJugador["ciclos"] > 0:
			var agregado =  {
				"daño" = validarJugador["daño"],
				"cura" = validarJugador["cura"],
				"plus" = validarJugador["plus"],
				"ciclos" = validarJugador["ciclos"],
			}
			temporalJugador.append(agregado)
		guardarRuletaJugador.append(puestoRuleta)
		VARIABLES.cartasJugador[puestoRuleta]["tiempo"] = 4
	if validarEnemigo["ciclos"] > 0:
		var agregado =  {
			"daño" = validarEnemigo["daño"],
			"cura" = validarEnemigo["cura"],
			"plus" = validarEnemigo["plus"],
			"ciclos" = validarEnemigo["ciclos"],
		}
		temporalEnemigo.append(agregado)
	guardarRuletaEnemigo.append(puestoRuleta)

func dibujarAcciones(condicion = true) -> void:
	var imagen
	if condicion:
		for k in guardarRuletaJugador.size():
			var accionesJugador = VARIABLES.cartasJugador[guardarRuletaJugador[k]]
			if accionesJugador["nombre"] == "Ataque":
				imagen = preload("res://Imagenes/ataque.png")
			if accionesJugador["nombre"] == "Curar":
				imagen = preload("res://Imagenes/curar.png")
			if accionesJugador["nombre"] == "Regeneración":
				imagen = preload("res://Imagenes/regeneracion.png")
			if accionesJugador["nombre"] == "Defender":
				imagen = preload("res://Imagenes/defender.png")
			if accionesJugador["nombre"] == "Aumentar Daño":
				imagen = preload("res://Imagenes/aumentarDaño.png")
			if accionesJugador["nombre"] == "Envenenar":
				imagen = preload("res://Imagenes/envenenar.png")
			hud_jugador.get_node("Accion"+str(k)+"/imagen").texture = imagen
		for k in guardarRuletaEnemigo.size():
			var accionesEnemigo = VARIABLES.cartasEnemigo[guardarRuletaEnemigo[k]]
			#######################################################
			if accionesEnemigo["nombre"] == "Ataque":
				imagen = preload("res://Imagenes/ataque.png")
			if accionesEnemigo["nombre"] == "Curar":
				imagen = preload("res://Imagenes/curar.png")
			if accionesEnemigo["nombre"] == "Regeneración":
				imagen = preload("res://Imagenes/regeneracion.png")
			if accionesEnemigo["nombre"] == "Defender":
				imagen = preload("res://Imagenes/defender.png")
			if accionesEnemigo["nombre"] == "Aumentar Daño":
				imagen = preload("res://Imagenes/aumentarDaño.png")
			if accionesEnemigo["nombre"] == "Envenenar":
				imagen = preload("res://Imagenes/envenenar.png")
			hud_enemigo.get_node("Accion"+str(k)+"/imagen").texture = imagen
	else:
		var imagenDefecto = preload("res://Imagenes/interrogacion1.png")
		hud_jugador.get_node("Accion0/cuadro").texture = cuadro
		hud_jugador.get_node("Accion0/imagen").texture = imagenDefecto
		hud_jugador.get_node("Accion1/imagen").texture = imagenDefecto
		hud_jugador.get_node("Accion1/cuadro").texture = cuadro
		hud_jugador.get_node("Accion2/imagen").texture = imagenDefecto
		hud_jugador.get_node("Accion2/cuadro").texture = cuadro
		hud_enemigo.get_node("Accion0/imagen").texture = imagenDefecto
		hud_enemigo.get_node("Accion0/cuadro").texture = cuadro
		hud_enemigo.get_node("Accion1/imagen").texture = imagenDefecto
		hud_enemigo.get_node("Accion1/cuadro").texture = cuadro
		hud_enemigo.get_node("Accion2/imagen").texture = imagenDefecto
		hud_enemigo.get_node("Accion2/cuadro").texture = cuadro

func visibleLucha(condicion = true) -> void:
	if condicion:
		for i in 6:
			cartas_jugador.get_node("Carta"+str(i)).visible = true
			cartas_enemigo.get_node("Carta"+str(i)).visible = true
			ruletas.get_node("Ruleta"+str(i)).visible = true
	else:
		for i in 6:
			cartas_jugador.get_node("Carta"+str(i)).visible = false
			cartas_enemigo.get_node("Carta"+str(i)).visible = false
			ruletas.get_node("Ruleta"+str(i)).visible = false

func _on_timer_3_timeout() -> void:
	var vueltasJugador = guardarRuletaJugador.size()
	var vueltasEnemigo = guardarRuletaEnemigo.size()
	if turnoJugador:
		if rondaJugador < vueltasJugador:
			descripcion.text = ""
			info_enemigo.get_node("Label").text = ""
			var cartaJugador = VARIABLES.cartasJugador[guardarRuletaJugador[rondaJugador]]
			if cartaJugador != null:
				hud_jugador.get_node("Accion"+str(rondaJugador)+"/cuadro").texture = cuadroRojo
				if cartaJugador["daño"] > 0:
					if cartaJugador["ciclos"] == 0:
						#info_jugador.get_node("Label").text = str(cartaJugador["daño"])
						var dañoConBonus = cartaJugador["daño"] + bonusJugador
						descripcion.text = "[color=blue]Jugador[/color] hace "+str(dañoConBonus)+" de daño al enemigo"
						daño(true,dañoConBonus)
					else:
						#info_jugador.get_node("Label").text = "T "+str(cartaJugador["daño"])
						var textoTemporal = hud_jugador.get_node("TemporalDaño/Label").text
						hud_jugador.get_node("TemporalDaño/Label").text = str(textoTemporal.to_int()+1)
						descripcion.text = "[color=blue]Jugador[/color] acumula +1 de daño temporal"
				if cartaJugador["cura"] > 0:
					if cartaJugador["ciclos"] == 0:
						#info_jugador.get_node("Label").text = "+"+str(cartaJugador["cura"])
						descripcion.text = "[color=blue]Jugador[/color] se cura 2 corazones"
						curar(true,cartaJugador["cura"])
					else:
						#info_jugador.get_node("Label").text = "T +"+str(cartaJugador["cura"])
						var textoTemporal = hud_jugador.get_node("TemporalCura/Label").text
						descripcion.text = "[color=blue]Jugador[/color] acumula +1 de cura temporal"
						hud_jugador.get_node("TemporalCura/Label").text = str(textoTemporal.to_int()+1)
				if cartaJugador["proteccion"] > 0:
					#info_jugador.get_node("Label").text = "+"+str(cartaJugador["proteccion"])
					descripcion.text = "[color=blue]Jugador[/color] se protege +1 corazón"
					proteccion(true,cartaJugador["proteccion"])
				if cartaJugador["plus"] > 0:
					#info_jugador.get_node("Label").text = ">>> "+str(cartaJugador["plus"])
					var textoTemporal = hud_jugador.get_node("TemporalBonus/Label").text
					descripcion.text = "[color=blue]Jugador[/color] acumula +1 de potencia para el siguiente turno"
					hud_jugador.get_node("TemporalBonus/Label").text = str(textoTemporal.to_int()+1)
			rondaJugador += 1
	else:
		if rondaEnemigo < vueltasEnemigo:
			info_jugador.get_node("Label").text = ""
			var cartaEnemigo = VARIABLES.cartasEnemigo[guardarRuletaEnemigo[rondaEnemigo]]
			if cartaEnemigo != null:
				hud_enemigo.get_node("Accion"+str(rondaEnemigo)+"/cuadro").texture = cuadroRojo
				if cartaEnemigo["daño"] > 0:
					if cartaEnemigo["ciclos"] == 0:
						#info_enemigo.get_node("Label").text = str(cartaEnemigo["daño"])
						var dañoConBonus = cartaEnemigo["daño"]+bonusEnemigo
						descripcion.text = "[color=red]Enemigo[/color] hace "+str(dañoConBonus)+" de daño al jugador"
						daño(false,dañoConBonus)
					else:
						#info_enemigo.get_node("Label").text = "T "+str(cartaEnemigo["daño"])
						var textoTemporal = hud_enemigo.get_node("TemporalDaño/Label").text
						descripcion.text = "[color=red]Enemigo[/color] acumula +1 de daño temporal"
						hud_enemigo.get_node("TemporalDaño/Label").text = str(textoTemporal.to_int()+1)
				if cartaEnemigo["cura"] > 0:
					if cartaEnemigo["ciclos"] == 0:
						#info_enemigo.get_node("Label").text = "+"+str(cartaEnemigo["cura"])
						descripcion.text = "[color=red]Enemigo[/color] se cura 2 corazones"
						curar(false,cartaEnemigo["cura"])
					else:
						#info_enemigo.get_node("Label").text = "T +"+str(cartaEnemigo["cura"])
						var textoTemporal = hud_enemigo.get_node("TemporalCura/Label").text
						descripcion.text = "[color=red]Enemigo[/color] acumula +1 de cura temporal"
						hud_enemigo.get_node("TemporalCura/Label").text = str(textoTemporal.to_int()+1)
				if cartaEnemigo["proteccion"] > 0:
					#info_enemigo.get_node("Label").text = "+"+str(cartaEnemigo["proteccion"])
					descripcion.text = "[color=red]Enemigo[/color] se protege +1 corazón"
					proteccion(false,cartaEnemigo["proteccion"])
				if cartaEnemigo["plus"] > 0:
					#info_enemigo.get_node("Label").text = ">>> "+str(cartaEnemigo["plus"])
					var textoTemporal = hud_enemigo.get_node("TemporalBonus/Label").text
					descripcion.text = "[color=red]Enemigo[/color] acumula +1 de potencia para el siguiente turno"
					hud_enemigo.get_node("TemporalBonus/Label").text = str(textoTemporal.to_int()+1)
			rondaEnemigo += 1
	if condicionJuego() == true:
		if rondaEnemigo == vueltasEnemigo:
			timer_3.stop()
			await get_tree().create_timer(5.0).timeout
			ejecutarTemporales()
		turnoJugador = !turnoJugador

func daño(jugador,cantidad):
	if jugador:
		if VARIABLES.proteccionEnemigo > 0:
			if cantidad > VARIABLES.proteccionEnemigo:
				var restante = cantidad-VARIABLES.proteccionEnemigo
				VARIABLES.proteccionEnemigo = 0
				VARIABLES.saludEnemigo -= restante
			VARIABLES.proteccionEnemigo -= cantidad
			if VARIABLES.proteccionEnemigo < 0:
				VARIABLES.proteccionEnemigo = 0
		else:
			VARIABLES.saludEnemigo -= cantidad
	else:
		if VARIABLES.proteccionJugador > 0:
			if cantidad > VARIABLES.proteccionJugador:
				var restante = cantidad-VARIABLES.proteccionJugador
				VARIABLES.proteccionJugador = 0
				VARIABLES.saludJugador -= restante
			VARIABLES.proteccionJugador -= cantidad
			if VARIABLES.proteccionJugador < 0:
				VARIABLES.proteccionJugador = 0
		else:
			VARIABLES.saludJugador -= cantidad
	generarVidas()

func curar(jugador,cantidad):
	if jugador:
		VARIABLES.saludJugador += cantidad
		if VARIABLES.saludJugador > VARIABLES.vidaJugador:
			VARIABLES.saludJugador = VARIABLES.vidaJugador
	else:
		VARIABLES.saludEnemigo += cantidad
		if VARIABLES.saludEnemigo > VARIABLES.vidaEnemigo:
			VARIABLES.saludEnemigo = VARIABLES.vidaEnemigo
	generarVidas()

func proteccion(jugador,cantidad):
	if jugador:
		VARIABLES.proteccionJugador += cantidad
	else:
		VARIABLES.proteccionEnemigo += cantidad
	generarVidas()

func nuevaRonda() -> void:
	_ready()
	timer.start()
	timer_2.start()
	timer_3.stop()
	dibujarAcciones(false)

func validarElecciones() -> void:
	if guardarRuletaJugador.size() == 0:
		castigoJugador = 3
	if guardarRuletaJugador.size() == 1:
		castigoJugador = 2
	if guardarRuletaJugador.size() == 2:
		castigoJugador = 1
	daño(false,castigoJugador)
	timer_3.start()
	_on_timer_3_timeout()

func condicionJuego():
	if VARIABLES.saludJugador <= 0:
		condicion_juego.visible = true
		condicion_juego.get_node("imagen").texture = perder
		timer.stop()
		timer_2.stop()
		timer_3.stop()
		visibleLucha(false)
		generarVidas()
		info_jugador.get_node("Label").text = ""
		info_enemigo.get_node("Label").text = ""
		fase.visible = false
		descripcion.visible = false
		timer_4.start()
		return false
	if VARIABLES.saludEnemigo <= 0:
		condicion_juego.visible = true
		condicion_juego.get_node("imagen").texture = ganar
		timer.stop()
		timer_2.stop()
		timer_3.stop()
		visibleLucha(false)
		generarVidas()
		info_jugador.get_node("Label").text = ""
		info_enemigo.get_node("Label").text = ""
		fase.visible = false
		descripcion.visible = false
		timer_4.start()
		return false
	return true

func ejecutarTemporales():
	var dañoTemporalJugador = 0
	var curaTemporalJugador = 0
	var plusTemporalJugador = 0
	var dañoTemporalEnemigo = 0
	var curaTemporalEnemigo = 0
	var plusTemporalEnemigo = 0
	
	if temporalJugador.size() > 0:
		for t in temporalJugador.size():
			var temporalVuelta = temporalJugador[t]
			if temporalVuelta["ciclos"] > 0:
				if temporalVuelta["daño"] > 0:
					dañoTemporalJugador += temporalVuelta["daño"]
				if temporalVuelta["cura"] > 0:
					curaTemporalJugador += temporalVuelta["cura"]
				if temporalVuelta["plus"] > 0:
					plusTemporalJugador += temporalVuelta["plus"]
		hud_jugador.get_node("TemporalDaño/Label").text = str(dañoTemporalJugador)
		hud_jugador.get_node("TemporalCura/Label").text = "+ "+str(curaTemporalJugador)
		hud_jugador.get_node("TemporalBonus/Label").text = "> "+str(plusTemporalJugador)
		
		if dañoTemporalJugador > 0:
			for i in temporalJugador.size():
				if temporalJugador[i-1]["daño"] > 0:
					temporalJugador[i-1]["ciclos"] -= 1
					descripcion.text = "[color=blue]Jugador[/color] hace +"+str(temporalJugador[i-1]["daño"])+" de daño temporal al enemigo"
					daño(true,temporalJugador[i-1]["daño"])
					condicionJuego()
					await get_tree().create_timer(2.0).timeout
		if curaTemporalJugador > 0:
			for i in temporalJugador.size():
				if temporalJugador[i-1]["cura"] > 0:
					temporalJugador[i-1]["ciclos"] -= 1
					curar(true,temporalJugador[i-1]["cura"])
					descripcion.text = "[color=blue]Jugador[/color] se cura +"+str(temporalJugador[i-1]["cura"])+" temporal"
					await get_tree().create_timer(2.0).timeout
		if plusTemporalJugador > 0:
			bonusJugador = plusTemporalJugador
			for i in temporalJugador.size():
				if temporalJugador[i-1]["plus"] > 0:
					temporalJugador[i-1]["ciclos"] = 0
		for i in temporalJugador.size():
			if temporalJugador[i-1]["ciclos"] == 0:
				if temporalJugador.has(i-1):
					temporalJugador.remove_at(i-1)
	
	if temporalEnemigo.size() > 0:
		for t in temporalEnemigo.size():
			var temporalVuelta = temporalEnemigo[t]
			if temporalVuelta["ciclos"] > 0:
				if temporalVuelta["daño"] > 0:
					dañoTemporalEnemigo += temporalVuelta["daño"]
				if temporalVuelta["cura"] > 0:
					curaTemporalEnemigo += temporalVuelta["cura"]
				if temporalVuelta["plus"] > 0:
					plusTemporalEnemigo += temporalVuelta["plus"]
		hud_enemigo.get_node("TemporalDaño/Label").text = "- "+str(dañoTemporalEnemigo)
		hud_enemigo.get_node("TemporalCura/Label").text = "+ "+str(curaTemporalEnemigo)
		hud_enemigo.get_node("TemporalBonus/Label").text = "> "+str(plusTemporalEnemigo)
		
		if dañoTemporalEnemigo > 0:
			for i in temporalEnemigo.size():
				if temporalEnemigo[i-1]["daño"] > 0:
					temporalEnemigo[i-1]["ciclos"] -= 1
					daño(false,temporalEnemigo[i-1]["daño"])
					descripcion.text = "[color=red]Enemigo[/color] hace +"+str(temporalEnemigo[i-1]["daño"])+" de daño temporal al jugador"
					condicionJuego()
					await get_tree().create_timer(2.0).timeout
		if curaTemporalEnemigo > 0:
			for i in temporalEnemigo.size():
				if temporalEnemigo[i-1]["cura"] > 0:
					temporalEnemigo[i-1]["ciclos"] -= 1
					curar(false,temporalEnemigo[i-1]["cura"])
					descripcion.text = "[color=red]Enemigo[/color] se cura +"+str(temporalEnemigo[i-1]["cura"])+" temporal"
					await get_tree().create_timer(2.0).timeout
		if plusTemporalEnemigo > 0:
			bonusEnemigo = plusTemporalEnemigo
			for i in temporalEnemigo.size():
				if temporalEnemigo[i-1]["plus"] > 0:
					temporalEnemigo[i-1]["ciclos"] = 0
		for i in temporalEnemigo.size():
			if temporalEnemigo[i-1]["ciclos"] == 0:
				if temporalEnemigo.has(i-1):
					temporalEnemigo.remove_at(i-1)
	
	await get_tree().create_timer(2.0).timeout
	nuevaRonda()

func _on_timer_4_timeout() -> void:
	get_tree().quit()
