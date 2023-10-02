extends Node2D

var isTruckStop = false

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		body.checkpointReached()
		isTruckStop = true
		

func _process(delta):
	if !isTruckStop:
		translate(Vector2.LEFT.normalized() * 100 * delta)

func changeTruckCond(isStop):
	isTruckStop = isStop

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
