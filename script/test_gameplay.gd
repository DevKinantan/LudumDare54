extends Node2D

var enemy_scene = preload("res://scene/enemy.tscn")
var enemyJet_scene = preload("res://scene/enemy_jet.tscn")

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
	spawnEnemy()
