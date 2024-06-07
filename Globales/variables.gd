extends Node
var vidaJugador: int = 10
var vidaEnemigo: int = 10
var saludJugador: int = 10
var saludEnemigo: int = 10
var proteccionJugador: int = 0
var proteccionEnemigo: int = 0
var regeneracionesJugador: int = 0
var regeneracionesEnemigo: int = 0
var venenosJugador: int = 0
var venenosEnemigo: int = 0
var cartasBase = {}
var cartasJugador = {}
var cartasEnemigo = {}
var temporalesJugador = {}
var aleatorioJugador
var aleatorioEnemigo

func _ready() -> void:
	repartirCartas()

func repartirCartas() -> void:
	var cuentaDañoJugador: int = 0
	var cuentaDañoEnemigo: int = 0
	var maximoDaño: int = 3
	var accionJugador1 = {}
	var accionEnemigo1 = {}
	var accionJugador2 = {}
	var accionEnemigo2 = {}
	var accionJugador3 = {}
	var accionEnemigo3 = {}
	var accionJugador4 = {}
	var accionEnemigo4 = {}
	var accionJugador5 = {}
	var accionEnemigo5 = {}
	var accionJugador6 = {}
	var accionEnemigo6 = {}
	
	cartasBase = {
		0: {
			"nombre" = "Ataque",
			"daño" = 3,
			"cura" = 0,
			"proteccion" = 0,
			"plus" = 0,
			"ciclos" = 0,
			"tiempo" = 0,
			"congelado" = 0,
		},
		1: {
			"nombre" = "Curar",
			"daño" = 0,
			"cura" = 2,
			"proteccion" = 0,
			"plus" = 0,
			"ciclos" = 0,
			"tiempo" = 0,
			"congelado" = 0,
		},
		2: {
			"nombre" = "Regeneración",
			"daño" = 0,
			"cura" = 1,
			"proteccion" = 0,
			"plus" = 0,
			"ciclos" = 3,
			"tiempo" = 0,
			"congelado" = 0,
		},
		3: {
			"nombre" = "Defender",
			"daño" = 0,
			"cura" = 0,
			"proteccion" = 1,
			"plus" = 0,
			"ciclos" = 0,
			"tiempo" = 0,
			"congelado" = 0,
		},
		4: {
			"nombre" = "Aumentar Daño",
			"daño" = 0,
			"cura" = 0,
			"proteccion" = 0,
			"plus" = 1,
			"ciclos" = 3,
			"tiempo" = 0,
			"congelado" = 0,
		},
		5: {
			"nombre" = "Envenenar",
			"daño" = 1,
			"cura" = 0,
			"proteccion" = 0,
			"plus" = 0,
			"ciclos" = 3,
			"tiempo" = 0,
			"congelado" = 0,
		},
	}
	
	for i in 6:
		aleatorioJugador = randi_range(0,5)
		aleatorioEnemigo = randi_range(0,5)
		
		if aleatorioJugador == 0:
			cuentaDañoJugador += 1
		if cuentaDañoJugador >= maximoDaño:
			aleatorioJugador = randi_range(1,5)
		if i == 4 && cuentaDañoJugador < 1:
			aleatorioJugador = 0
		if i == 5 && cuentaDañoJugador < 2:
			aleatorioJugador = 0
		
		if aleatorioEnemigo == 0:
			cuentaDañoEnemigo += 1
		if cuentaDañoEnemigo >= maximoDaño:
			aleatorioEnemigo = randi_range(1,5)
		if i == 5 && cuentaDañoEnemigo < 1:
			aleatorioEnemigo = 0
		
		if i == 0:
			accionJugador1 = cartasBase[aleatorioJugador]
			accionEnemigo1 = cartasBase[aleatorioEnemigo]
		if i == 1:
			accionJugador2 = cartasBase[aleatorioJugador]
			accionEnemigo2 = cartasBase[aleatorioEnemigo]
		if i == 2:
			accionJugador3 = cartasBase[aleatorioJugador]
			accionEnemigo3 = cartasBase[aleatorioEnemigo]
		if i == 3:
			accionJugador4 = cartasBase[aleatorioJugador]
			accionEnemigo4 = cartasBase[aleatorioEnemigo]
		if i == 4:
			accionJugador5 = cartasBase[aleatorioJugador]
			accionEnemigo5 = cartasBase[aleatorioEnemigo]
		if i == 5:
			accionJugador6 = cartasBase[aleatorioJugador]
			accionEnemigo6 = cartasBase[aleatorioEnemigo]
		
	cartasJugador = {
		0: {
			"nombre": accionJugador1["nombre"],
			"daño": accionJugador1["daño"],
			"cura": accionJugador1["cura"],
			"proteccion": accionJugador1["proteccion"],
			"plus": accionJugador1["plus"],
			"ciclos": accionJugador1["ciclos"],
			"tiempo": accionJugador1["tiempo"],
			"congelado": accionJugador1["congelado"],
		},
		1: {
			"nombre": accionJugador2["nombre"],
			"daño": accionJugador2["daño"],
			"cura": accionJugador2["cura"],
			"proteccion": accionJugador2["proteccion"],
			"plus": accionJugador2["plus"],
			"ciclos": accionJugador2["ciclos"],
			"tiempo": accionJugador2["tiempo"],
			"congelado": accionJugador2["congelado"],
		},
		2: {
			"nombre": accionJugador3["nombre"],
			"daño": accionJugador3["daño"],
			"cura": accionJugador3["cura"],
			"proteccion": accionJugador3["proteccion"],
			"plus": accionJugador3["plus"],
			"ciclos": accionJugador3["ciclos"],
			"tiempo": accionJugador3["tiempo"],
			"congelado": accionJugador3["congelado"],
		},
		3: {
			"nombre": accionJugador4["nombre"],
			"daño": accionJugador4["daño"],
			"cura": accionJugador4["cura"],
			"proteccion": accionJugador4["proteccion"],
			"plus": accionJugador4["plus"],
			"ciclos": accionJugador4["ciclos"],
			"tiempo": accionJugador4["tiempo"],
			"congelado": accionJugador4["congelado"],
		},
		4: {
			"nombre": accionJugador5["nombre"],
			"daño": accionJugador5["daño"],
			"cura": accionJugador5["cura"],
			"proteccion": accionJugador5["proteccion"],
			"plus": accionJugador5["plus"],
			"ciclos": accionJugador5["ciclos"],
			"tiempo": accionJugador5["tiempo"],
			"congelado": accionJugador5["congelado"],
		},
		5: {
			"nombre": accionJugador6["nombre"],
			"daño": accionJugador6["daño"],
			"cura": accionJugador6["cura"],
			"proteccion": accionJugador6["proteccion"],
			"plus": accionJugador6["plus"],
			"ciclos": accionJugador6["ciclos"],
			"tiempo": accionJugador6["tiempo"],
			"congelado": accionJugador6["congelado"],
		}
	}
	
	cartasEnemigo = {
		0: {
			"nombre": accionEnemigo1["nombre"],
			"daño": accionEnemigo1["daño"],
			"cura": accionEnemigo1["cura"],
			"proteccion": accionEnemigo1["proteccion"],
			"plus": accionEnemigo1["plus"],
			"ciclos": accionEnemigo1["ciclos"],
			"tiempo": accionEnemigo1["tiempo"],
			"congelado": accionEnemigo1["congelado"],
		},
		1: {
			"nombre": accionEnemigo2["nombre"],
			"daño": accionEnemigo2["daño"],
			"cura": accionEnemigo2["cura"],
			"proteccion": accionEnemigo2["proteccion"],
			"plus": accionEnemigo2["plus"],
			"ciclos": accionEnemigo2["ciclos"],
			"tiempo": accionEnemigo2["tiempo"],
			"congelado": accionEnemigo2["congelado"],
		},
		2: {
			"nombre": accionEnemigo3["nombre"],
			"daño": accionEnemigo3["daño"],
			"cura": accionEnemigo3["cura"],
			"proteccion": accionEnemigo3["proteccion"],
			"plus": accionEnemigo3["plus"],
			"ciclos": accionEnemigo3["ciclos"],
			"tiempo": accionEnemigo3["tiempo"],
			"congelado": accionEnemigo3["congelado"],
		},
		3: {
			"nombre": accionEnemigo4["nombre"],
			"daño": accionEnemigo4["daño"],
			"cura": accionEnemigo4["cura"],
			"proteccion": accionEnemigo4["proteccion"],
			"plus": accionEnemigo4["plus"],
			"ciclos": accionEnemigo4["ciclos"],
			"tiempo": accionEnemigo4["tiempo"],
			"congelado": accionEnemigo4["congelado"],
		},
		4: {
			"nombre": accionEnemigo5["nombre"],
			"daño": accionEnemigo5["daño"],
			"cura": accionEnemigo5["cura"],
			"proteccion": accionEnemigo5["proteccion"],
			"plus": accionEnemigo5["plus"],
			"ciclos": accionEnemigo5["ciclos"],
			"tiempo": accionEnemigo5["tiempo"],
			"congelado": accionEnemigo5["congelado"],
		},
		5: {
			"nombre": accionEnemigo6["nombre"],
			"daño": accionEnemigo6["daño"],
			"cura": accionEnemigo6["cura"],
			"proteccion": accionEnemigo6["proteccion"],
			"plus": accionEnemigo6["plus"],
			"ciclos": accionEnemigo6["ciclos"],
			"tiempo": accionEnemigo6["tiempo"],
			"congelado": accionEnemigo6["congelado"],
		}
	}
