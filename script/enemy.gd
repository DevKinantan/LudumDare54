extends CharacterBody2D
class_name EnemyParent

@export var direction = Vector2.LEFT
@export var MIN_SPEED = 60
@export var MAX_SPEED = 85
var speed = 100.

@export var health = 100

@export var dropRarity = 35

@onready var animatedSprite = get_node("AnimatedSprite2D")
var rng = RandomNumberGenerator.new()

var loot_scene = preload("res://scene/enemy_loot.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animatedSprite.play("idle")
	speed = rng.randi_range(MIN_SPEED, MAX_SPEED)

func takeDamage(damage):
	health -= damage
	modulate = Color("ff6a58")
	$HitCooldown.start()
	print(str(health))
	
	if health <= 0:
		death()

func death():
	$CollisionShape2D.set_deferred("disabled", true)
	speed = 100
	
	animatedSprite.play("death")
	await animatedSprite.animation_finished
	
	var ranint = rng.randi_range(1, 100)
	
	if(ranint <= dropRarity):
		var loot = loot_scene.instantiate()
		loot.position = position
		get_tree().get_root().add_child(loot)
	
	queue_free()

func _process(delta):
	if health <= 0:
		direction = Vector2.LEFT 
	translate(direction.normalized() * speed * delta)

#func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
	#velocity.x = -1 * speed
	#else:
	#	velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hit_cooldown_timeout():
	modulate = Color("ffffff")
