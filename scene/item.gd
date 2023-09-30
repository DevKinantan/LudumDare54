class_name Item extends Node2D

var draggable = false
var sprite_width = null

func _ready():
	sprite_width = $Sprite2D.texture.get_width() * scale.x
	print(sprite_width)

func _process(delta):
	if draggable:
		global_position = get_global_mouse_position()
		
		$ShadowSprite.global_position.x = (int(global_position.x/64)) * 64 + (sprite_width/2)
		$ShadowSprite.global_position.y = (int(global_position.y/64)) * 64 + (sprite_width/2)


@warning_ignore("native_method_override")
func get_class(): 
	return "Item"


@warning_ignore("native_method_override")
func is_class(value):
	return value == "Item"
