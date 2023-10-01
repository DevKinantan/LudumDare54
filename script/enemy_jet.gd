extends EnemyParent

var direction = Vector2.RIGHT

func _process(delta):
	if health <= 0:
		direction = Vector2.LEFT
	translate(direction.normalized() * speed * delta)
