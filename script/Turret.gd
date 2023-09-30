extends Node2D

var bullet_scene = preload("res://scene/bullet.tscn")

func fire():
	var bullet = bullet_scene.instantiate()
	bullet.direction = $Marker2D.global_position - global_position
	bullet.global_position =  $Marker2D.global_position
	get_tree().get_root().add_child(bullet)


func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("ui_select"):
		fire()
