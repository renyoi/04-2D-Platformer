extends Area2D

func _on_Portal_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://UI/End.tscn")
