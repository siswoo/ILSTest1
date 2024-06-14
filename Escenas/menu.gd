extends Node2D
var tutorial = preload("res://Escenas/tutorial.tscn")

func _on_jugar_b_pressed() -> void:
	get_tree().change_scene_to_packed(tutorial)

func _on_salir_b_pressed() -> void:
	get_tree().quit()
