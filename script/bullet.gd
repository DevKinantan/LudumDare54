extends Area2D


var direction = Vector2.RIGHT
var speed = 400


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(direction.normalized() * speed * delta)


func _on_body_entered(body):
	# do damage script here
	print("hit " + body.name)
	
	if body.is_in_group("Enemy"):
		body.takeDamage(20)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
