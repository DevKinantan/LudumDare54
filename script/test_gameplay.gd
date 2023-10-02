extends Node2D

var enemy_scene = preload("res://scene/enemy.tscn")
var enemyJet_scene = preload("res://scene/enemy_jet.tscn")
var garage_scene = preload("res://scene/garage.tscn")
var shop_scene = preload("res://scene/shop.tscn")

@onready var continueBtn = get_node("ContinueBtn")
@onready var shopBtn = get_node("ShopBtn")

@onready var progressBar = get_node("ProgressBar")

var isEnemySpawning = true

func spawnEnemy():
	var rng = RandomNumberGenerator.new()
	$EnemySpawn.start(rng.randf_range(.2, 2))
	
	var ranint = rng.randi_range(1, 5)
	
	var enemy = null
	var ranX = 0
	var ranY = 0
	
	if ranint <= 4:
		enemy = enemy_scene.instantiate()
		ranX = rng.randi_range(1160, 1300)
	else:
		enemy = enemyJet_scene.instantiate()
		ranX = rng.randi_range(-80, -20)
	
	ranint = rng.randi_range(1, 2)
	
	if ranint == 1:
		ranY = rng.randi_range(250, 315)
	else:
		ranY = rng.randf_range(475, 625)
	
	enemy.position = Vector2(ranX, ranY)
	get_tree().get_root().add_child(enemy)
	

func _on_enemy_spawn_timeout():
	if isEnemySpawning:
		spawnEnemy()


func _on_checkpoint_timer_timeout():
	isEnemySpawning = false
	
	var garage = garage_scene.instantiate()
	garage.position = Vector2(2500, 275)
	get_tree().get_root().add_child(garage)
	
	print("Checkpoint Reached")


func _on_player_checkpoint_reached():
	$Background.changeTruckCondition(true)
	$Player.get_node("Particle1").emitting = false
	$Player.get_node("Particle2").emitting = false	
	continueBtn.visible = true
	shopBtn.visible = true

	print("Stopping truck")


func _on_texture_button_mouse_entered():
	continueBtn.self_modulate = Color.GRAY


func _on_texture_button_mouse_exited():
	continueBtn.self_modulate = Color.WHITE


func _on_texture_button_pressed():
	$Background.changeTruckCondition(false)
	$Player.get_node("Particle1").emitting = true
	$Player.get_node("Particle2").emitting = true
	continueBtn.visible = false
	shopBtn.visible = false
	get_tree().get_root().get_node("Garage").changeTruckCond(false)
	progressBar.value = 0
	$StartCooldown.start()


func _on_start_cooldown_timeout():
	isEnemySpawning = true
	spawnEnemy()
	$CheckpointTimer.start()
	$CountdownTimer.start()


func _on_countdown_timer_timeout():
	if(progressBar.value <= 130):
		progressBar.value += 1
	else:
		$CountdownTimer.stop()


func _on_shop_btn_mouse_entered():
	shopBtn.self_modulate = Color.GRAY	


func _on_shop_btn_mouse_exited():
	shopBtn.self_modulate = Color.WHITE


func _on_shop_btn_pressed():
	var shop = shop_scene.instantiate()
	get_tree().get_root().add_child(shop)
