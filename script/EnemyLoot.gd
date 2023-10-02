extends Area2D

var rng = RandomNumberGenerator.new()

func getLoot():
	#var ranint = rng.randi_range(1, 100)
	
	#if ranint <= 60:
	#	print("Got Common Loot")
	#elif ranint <= 90:
	#	print("Got Rare Loot")
	#else:
	#	print("Got Legendary Loot")
	
	get_parent().get_node("TestGameplay/LootboxSpawner").spawn_lootbox()
	
	queue_free()

func _on_mouse_entered():
	$Sprite2D.self_modulate = Color.GRAY


func _on_mouse_exited():
	$Sprite2D.self_modulate = Color.WHITE


func _process(delta):
	translate(Vector2.LEFT.normalized() * 100 * delta)


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
