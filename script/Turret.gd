extends Node2D

var bullet_scene = preload("res://scene/bullet.tscn")
var canFire = true
var bulletBurst = 1
var fireRate = .8
var shotsFired = 0
var animPlaying = ""

var currentTurretLevel = 1

@onready var animatedSprite = get_node("../TurretSprite")

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
		$CooldownTimer.start(fireRate)
		fire()


func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	
	if rotation_degrees <= -360:
		rotation_degrees = 360
	elif rotation_degrees >= 360:
		rotation_degrees = -360
		
	var rdg = rotation_degrees
	### --- ###
	if (rdg >= 22.5 and rdg < 67.5) or (rdg >= -337.5 and rdg < -292.5) and animPlaying != "kananBawah":
		animatedSprite.play("kananBawah")
		animPlaying = "kananBawah"
		
	elif (rdg >= 67.5 and rdg < 112.5) or (rdg >= -292.5 and rdg < -247.5) and animPlaying != "bawah":
		animatedSprite.play("bawah")
		animPlaying = "bawah"		
		
	elif (rdg >= 112.5 and rdg < 157.5) or (rdg >= -247.5 and rdg < -202.5) and animPlaying != "kiriBawah":
		animatedSprite.play("kiriBawah")
		animPlaying = "kiriBawah"		
		
	elif (rdg >= 157.5 and rdg < 202.5) or (rdg >= -202.5 and rdg < -157.5) and animPlaying != "kiri":
		animatedSprite.play("kiri")
		animPlaying = "kiri"
		
	elif (rdg >= 202.5 and rdg < 247.5) or (rdg >= -157.5 and rdg < -112.5) and animPlaying != "kiriAtas":
		animatedSprite.play("kiriAtas")
		animPlaying = "kiriAtas"
		
	elif (rdg >= 247.5 and rdg < 292.5) or (rdg >= -112.5 and rdg < -67.5) and animPlaying != "atas":
		animatedSprite.play("atas")
		animPlaying = "atas"
		
	elif (rdg >= 292.5 and rdg < 337.5) or (rdg >= -67.5 and rdg < -22.5) and animPlaying != "kananAtas":
		animatedSprite.play("kananAtas")
		animPlaying = "kananAtas"
		
	#elif (rdg >= 337.5 or rdg < 22.5) or (rdg >= 22.5 and rdg < 67.5):
	elif (rdg >= -22.5 and rdg < 22.5) or rdg < -337.5 or rdg >= 337.5 and animPlaying != "kanan":
		animatedSprite.play("kanan")
		animPlaying = "kanan"		
	### --- ###
	if Input.is_action_pressed("fire"):
		isFireable()


func upgradeTurret(level):
	currentTurretLevel = level
	
	if level == 1:
		fireRate = .8
	elif level == 2:
		fireRate = .5
	elif level == 3:
		bulletBurst = 2


func _on_cooldown_timer_timeout():
	canFire = true
	shotsFired = 0


func _on_burst_timer_timeout():
	fire()
