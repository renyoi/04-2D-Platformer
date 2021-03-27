extends Node2D

onready var Alien = load("res://Level2/Enemy1.tscn")

func _physics_process(_delta):
	if not has_node("Alien"):
		var alien = Alien.instance()
		add_child(alien)
		alien.name = 'Alien'
