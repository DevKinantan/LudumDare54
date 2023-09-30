class_name Item extends Node2D

var draggable = false
var sprite_width = null

func _ready():
	sprite_width = int($Sprite2D.texture.get_width() * scale.x)
	print(sprite_width)


func _process(delta):
	if draggable:
		global_position = get_global_mouse_position()
		
		if sprite_width % 128 == 0:
			$ShadowSprite.global_position.x = (int((global_position.x-32)/64)) * 64 + 64
			$ShadowSprite.global_position.y = (int((global_position.y-32)/64)) * 64 + 64
		else:
			$ShadowSprite.global_position.x = (int((global_position.x)/64)) * 64 + 32
			$ShadowSprite.global_position.y = (int((global_position.y)/64)) * 64 + 32


func floor_or_ceil(n):
	print(n)
	if n < 0.5:
		return floor(n)
	else:
		return ceil(n)

func snap_position():
	if sprite_width % 128 == 0:
		global_position.x = (int((global_position.x-32)/64)) * 64 + 64
		global_position.y = (int((global_position.y-32)/64)) * 64 + 64
	else:
		global_position.x = (int(global_position.x/64)) * 64 + 32
		global_position.y = (int(global_position.y/64)) * 64 + 32


@warning_ignore("native_method_override")
func get_class(): 
	return "Item"


@warning_ignore("native_method_override")
func is_class(value):
	return value == "Item"
