extends Area2D

var score = 10

func _on_Coin_body_entered(body):
	if body.name == "Player":
		if Global.level == 1:
			Global.update_score(score)
			queue_free()
		if Global.level == 2:
			body.die()
var speed = .5
var velocity = Vector2.ZERO

func _physics_process(_delta):
	if Global.level == 2:
		position += velocity 
		if position.y <= 100:
			velocity.y += speed
		else:
			velocity.y -= speed
		if position.x <= 200:
			velocity.x += speed
		else:
			velocity.x -= speed
