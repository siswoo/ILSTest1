extends Node2D
@onready var texto: RichTextLabel = $CanvasLayer/Tuto1/Texto
@onready var siguiente_b: Button = $CanvasLayer/Tuto1/SiguienteB
@onready var atras_b: Button = $CanvasLayer/Tuto1/AtrasB
@onready var vidas_jugador: Node = $CanvasLayer/VidasJugador
@onready var vidas_enemigo: Node = $CanvasLayer/VidasEnemigo
@onready var icono_jugador: TextureRect = $CanvasLayer/IconoJugador
@onready var icono_enemigo: TextureRect = $CanvasLayer/IconoEnemigo
@onready var corazon_vacio: TextureRect = $CanvasLayer/CorazonVacio
@onready var corazon_rojo: TextureRect = $CanvasLayer/CorazonRojo
@onready var corazon_azul: TextureRect = $CanvasLayer/CorazonAzul
@onready var ejemplo_1: TextureRect = $CanvasLayer/ejemplo1
@onready var ejemplo_2: TextureRect = $CanvasLayer/ejemplo2
@onready var carta_da_o: TextureRect = $"CanvasLayer/cartaDaño"
@onready var carta_curar: TextureRect = $CanvasLayer/cartaCurar
@onready var carta_regeneracion: TextureRect = $CanvasLayer/cartaRegeneracion
@onready var carta_veneno: TextureRect = $CanvasLayer/cartaVeneno
@onready var carta_potencia: TextureRect = $CanvasLayer/cartaPotencia
@onready var ejemplo_3: TextureRect = $CanvasLayer/ejemplo3
@onready var ejemplo_4: TextureRect = $CanvasLayer/ejemplo4
@onready var ejemplo_5: TextureRect = $CanvasLayer/ejemplo5
@onready var ejemplo_6: TextureRect = $CanvasLayer/ejemplo6
@onready var temporales_jugador: Node = $CanvasLayer/temporalesJugador
@onready var temporales_enemigo: Node = $CanvasLayer/temporalesEnemigo
@onready var acciones_jugador: Node = $CanvasLayer/accionesJugador
@onready var iniciar_b: Button = $CanvasLayer/IniciarB
@onready var omitir_b: Button = $CanvasLayer/OmitirB
var corazonRojo = preload("res://Imagenes/vidaLlena.png")
var corazonVacio = preload("res://Imagenes/vidaVacia.png")
var nivel1 = preload("res://Escenas/principal.tscn")
var etapa = 1
var texto1 = "[center]Bienvenido
En este tutorial te explicare las funciones básicas del juego. [/center]"
var texto2 = "[center]Lo primero es la vida que se representan en forma de corazones, 
en el lado superior izquierdo estan las vidas del jugador junto con su icono,
mientras que en el lado superior derecho se representan las vidas del enemigo junto con su respectivo icono[/center]"
var texto3 = "[center]Las vidas se clasifican en tres tipos:
	* corazones grises: representan las vidas faltantes
	* corazones rojos: representan las vidas llenas
	* corazones azules: representan las vidas con armadura, es decir que estan protegidas por un punto de daño adicional[/center]"
var texto4 = "[center]Para hacer daño, recuperar vida o colocar armadura debes elegir cartas,
	tendrás 6 cartas disponibles por nivel, en donde solo podrás elegir 3 cartas por turno[/center]"
var texto5 = "[center]Para elegir alguna debes presionar la tecla de Espaciado, en el momento que la ruleta 
	esta de color verde debajo de dicha carta [/center]"
var texto6 = "[center]Existen varios tipos de cartas:
	[color=blue]*1_[/color] Carta de daño: con el icono de dos espadas cruzadas (hace 3 de daño)
	[color=blue]*2_[/color] Carta de curar: con el icono de pocima sellada (cura 2 corazones)
	[color=blue]*3_[/color] Carta de Regeneración: con el icono de poción sellada con liquido verde (cura 1 corazón por turno, dura 3 turnos)
	[color=blue]*4_[/color] Carta de Veneno: con el icono de poción con calaveras, (daña 1 corazon por turno, dura 3 turnos)
	[color=blue]*5_[/color] Carta de Potencia: con el icono de una espada (aumenta +1 el efecto de la carta de daño para el próximo turno)[/center]"
var texto7 = "[center]Al elegir una carta, tener en cuanta lo siguiente: 
	[color=blue]*1_[/color] Eliges tu acción (carta superior), también eliges la acción del enemigo (carta inferior)
	[color=blue]*2_[/color] Congelas dicha carta el tiempo de acciones establecidas (se reconocen por el azul oscuro)
	[color=blue]*3_[/color] Si la carta que eliges esta congelada, la acción solo ira al enemigo mientras que tu acción no se aplica[/center]"
var texto8 = "[center]Las cartas con efectos temporales se evidencian porque tienen números entre uno y tres en la parte superior derecha [/center]"
var texto9 = "[center]Los efectos temporales se organizan de la siguiente manera: 
		[color=blue]*1_[/color] Contador de daño restantes (1 de daño para el contrincante por turno)
		[color=blue]*2_[/color] Contador de recuperación restantes (recupera 1 corazón para el dueño de la acción por turno)
		[color=blue]*3_[/color] Contador de daño adicional para la carta de Daño en el siguiente inicio de turno (solo tiene duración de un turno) [/center]"
var texto10 = "[center]Tener en consideración: 
		[color=blue]*1_[/color] Si termina el tiempo (20 segundos) y no has elegido tres acciones, se te aplicara 1 de daño por cada acción faltante (ejemplo: -3 corazones)
		[color=blue]*2_[/color] Ganas si los corazones del enemigo estan todos vacios
		[color=blue]*3_[/color] Pierdes si tus corazones estan todos vacios [/center]"

func _ready() -> void:
	texto.text = texto1
	atras_b.visible = false
	corazon_vacio.visible = false
	corazon_rojo.visible = false
	corazon_azul.visible = false
	ejemplo_1.visible = false
	ejemplo_2.visible = false
	ubicacionFlechas()
	vistaHud()

func _on_siguiente_b_pressed() -> void:
	if etapa < 10:
		etapa += 1
		etapaTuto()

func _on_atras_b_pressed() -> void:
	if etapa > 1:
		etapa -= 1
		etapaTuto()

func etapaTuto() -> void:
	if etapa > 1:
		atras_b.visible = true
	
	if etapa == 1:
		atras_b.visible = false
		texto.text = texto1
	
	if etapa == 2:
		texto.text = texto2
	
	if etapa == 3:
		texto.text = texto3
	
	if etapa == 4:
		texto.text = texto4
	
	if etapa == 5:
		texto.text = texto5
	
	if etapa == 6:
		texto.text = texto6
		
	if etapa == 7:
		texto.text = texto7
	
	if etapa == 8:
		texto.text = texto8
	
	if etapa == 9:
		texto.text = texto9
		siguiente_b.visible = true
		iniciar_b.visible = false
	
	if etapa == 10:
		texto.text = texto10
		siguiente_b.visible = false
		iniciar_b.visible = true
	
	ubicacionFlechas()
	vistaHud()

func ubicacionFlechas() -> void:
	if etapa == 1:
		siguiente_b.position = Vector2(800,300)
		atras_b.position = Vector2(350,300)
	if etapa == 2:
		siguiente_b.position = Vector2(800,500)
		atras_b.position = Vector2(350,500)
	if etapa == 3:
		siguiente_b.position = Vector2(800,500)
		atras_b.position = Vector2(350,500)
	if etapa == 4:
		siguiente_b.position = Vector2(950,400)
		atras_b.position = Vector2(200,400)
	if etapa == 5:
		siguiente_b.position = Vector2(800,350)
		atras_b.position = Vector2(350,350)
	if etapa == 6 or etapa == 7:
		siguiente_b.position = Vector2(950,500)
		atras_b.position = Vector2(200,500)
	if etapa == 8:
		siguiente_b.position = Vector2(800,300)
		atras_b.position = Vector2(350,300)
	if etapa == 9 or etapa == 10:
		siguiente_b.position = Vector2(950,500)
		atras_b.position = Vector2(200,500)
	
func vistaHud() -> void:
	if etapa == 1:
		omitir_b.visible = true
		icono_jugador.visible = false
		icono_enemigo.visible = false
		for i in 6:
			if i != 0:
				vidas_jugador.get_node("co"+str(i)).visible = false
				vidas_enemigo.get_node("co"+str(i)).visible = false
				
	if etapa == 2:
		omitir_b.visible = false
		icono_jugador.visible = true
		icono_enemigo.visible = true
		corazon_vacio.visible = false
		corazon_rojo.visible = false
		corazon_azul.visible = false
		for i in 6:
			if i != 0:
				vidas_jugador.get_node("co"+str(i)).visible = true
				vidas_enemigo.get_node("co"+str(i)).visible = true
				
	if etapa == 3:
		corazon_vacio.visible = true
		corazon_rojo.visible = true
		corazon_azul.visible = true
		ejemplo_1.visible = false
	
	if etapa == 4:
		corazon_vacio.visible = false
		corazon_rojo.visible = false
		corazon_azul.visible = false
		ejemplo_1.visible = true
		ejemplo_2.visible = false
	
	if etapa == 5:
		corazon_vacio.visible = false
		corazon_rojo.visible = false
		corazon_azul.visible = false
		ejemplo_1.visible = false
		ejemplo_2.visible = true
		carta_da_o.visible = false
		carta_curar.visible = false
		carta_regeneracion.visible = false
		carta_veneno.visible = false
		carta_potencia.visible = false
		
	if etapa == 6:
		ejemplo_2.visible = false
		ejemplo_3.visible = false
		ejemplo_4.visible = false
		ejemplo_5.visible = false
		carta_da_o.visible = true
		carta_curar.visible = true
		carta_regeneracion.visible = true
		carta_veneno.visible = true
		carta_potencia.visible = true
	
	if etapa == 7:
		carta_da_o.visible = false
		carta_curar.visible = false
		carta_regeneracion.visible = false
		carta_veneno.visible = false
		carta_potencia.visible = false
		ejemplo_6.visible = false
		ejemplo_3.visible = true
		ejemplo_4.visible = true
		ejemplo_5.visible = true
	
	if etapa == 8:
		ejemplo_3.visible = false
		ejemplo_4.visible = false
		ejemplo_5.visible = false
		temporales_jugador.get_node("TemporalDaño").visible = false
		temporales_jugador.get_node("TemporalCura").visible = false
		temporales_jugador.get_node("TemporalBonus").visible = false
		temporales_enemigo.get_node("TemporalDaño").visible = false
		temporales_enemigo.get_node("TemporalCura").visible = false
		temporales_enemigo.get_node("TemporalBonus").visible = false
		ejemplo_6.visible = true
	
	if etapa == 9:
		ejemplo_6.visible = false
		temporales_jugador.get_node("TemporalDaño").visible = true
		temporales_jugador.get_node("TemporalCura").visible = true
		temporales_jugador.get_node("TemporalBonus").visible = true
		temporales_enemigo.get_node("TemporalDaño").visible = true
		temporales_enemigo.get_node("TemporalCura").visible = true
		temporales_enemigo.get_node("TemporalBonus").visible = true
		acciones_jugador.get_node("Accion0").visible = false
		acciones_jugador.get_node("Accion1").visible = false
		acciones_jugador.get_node("Accion2").visible = false
		acciones_jugador.get_node("Label").visible = false
		vidas_jugador.get_node("Label").visible = false
		vidas_enemigo.get_node("Label").visible = false
		for i in 6:
			if i != 0:
				vidas_jugador.get_node("co"+str(i)).texture = corazonRojo
				vidas_enemigo.get_node("co"+str(i)).texture = corazonRojo
	
	if etapa == 10:
		temporales_jugador.get_node("TemporalDaño").visible = false
		temporales_jugador.get_node("TemporalCura").visible = false
		temporales_jugador.get_node("TemporalBonus").visible = false
		temporales_enemigo.get_node("TemporalDaño").visible = false
		temporales_enemigo.get_node("TemporalCura").visible = false
		temporales_enemigo.get_node("TemporalBonus").visible = false
		acciones_jugador.get_node("Accion0").visible = true
		acciones_jugador.get_node("Accion1").visible = true
		acciones_jugador.get_node("Accion2").visible = true
		acciones_jugador.get_node("Label").visible = true
		vidas_jugador.get_node("Label").visible = true
		vidas_enemigo.get_node("Label").visible = true
		for i in 6:
			if i != 0:
				vidas_jugador.get_node("co"+str(i)).texture = corazonVacio
				vidas_enemigo.get_node("co"+str(i)).texture = corazonVacio

func _on_iniciar_b_pressed() -> void:
	get_tree().change_scene_to_packed(nivel1)

func _on_omitir_b_pressed() -> void:
	get_tree().change_scene_to_packed(nivel1)
