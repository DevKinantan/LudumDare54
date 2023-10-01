extends CharacterBody2D
class_name EnemyParent

const MIN_SPEED = 60
const MAX_SPEED = 85
var speed = 100.0
#const JUMP_VELOCITY = -400.0
var health = 100

@onready var animatedSprite = get_node("AnimatedSprite2D")

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	animatedSprite.play("idle")
	
	var rng = RandomNumberGenerator.new()
	speed = rng.randi_range(MIN_SPEED, MAX_SPEED)

func takeDamage(damage):
	health -= damage
	print(str(health))
	
	if health <= 0:
		$CollisionShape2D.set_deferred("disabled", true)
		speed = 100
		animatedSprite.play("death")
		await animatedSprite.animation_finished
		queue_free()

func _process(delta):
	translate(Vector2.LEFT.normalized() * speed * delta)

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
