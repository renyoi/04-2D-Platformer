extends Control

onready var global = get_node("/root/Global")

func _on_quit_pressed():
	get_tree().quit()
