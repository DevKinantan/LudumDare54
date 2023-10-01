extends Node2D

var enemy_scene = preload("res://scene/enemy.tscn")

func spawnEnemy():
	var enemy = enemy_scene.instantiate()
	
	var rng = RandomNumberGenerator.new()
	var ranint = rng.randi_range(1, 2)
	
	var ranX = rng.randi_range(1160, 1300)
	var ranY = 0
	
	if ranint == 1:
		ranY = rng.randi_range(250, 325)
	else:
		ranY = rng.randf_range(475, 625)
	
	enemy.position = Vector2(ranX, ranY)
	get_tree().get_root().add_child(enemy)
	
	$EnemySpawn.start(rng.randf_range(.2, 2))


func _on_enemy_spawn_timeout():
	spawnEnemy()
