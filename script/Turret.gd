extends Node2D

var bullet_scene = preload("res://scene/bullet.tscn")
var canFire = true
var bulletBurst = 2
var shotsFired = 0

func fire():
	shotsFired += 1
	
	if shotsFired <= bulletBurst:
		var bullet = bullet_scene.instantiate()
		bullet.direction = $Marker2D.global_position - global_position
		bullet.global_position =  $Marker2D.global_position
		get_tree().get_root().add_child(bullet)
		$BurstTimer.start()

func isFireable():
	if canFire:
		canFire = false
		$CooldownTimer.start()
		fire()


func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("ui_select"):
		isFireable()


func upgradeTurret():
	bulletBurst += 1


func _on_cooldown_timer_timeout():
	canFire = true
	shotsFired = 0


func _on_burst_timer_timeout():
	fire()
