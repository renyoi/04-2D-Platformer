extends Node2D

onready var Enemy1 = load("res://Level2/Enemy1.tscn")

func _physics_process(_delta):
	if not has_node("Enemy1"):
		var enemy1 = Enemy1.instance()
		add_child(enemy1)
		enemy1.name = 'Enemy1'
