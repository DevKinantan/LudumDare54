class_name Item extends Node2D

var draggable = false
var colided = false
var sprite_width = null
var last_pos = null

func _ready():
	sprite_width = int($Sprite2D.texture.get_width() * scale.x)
	last_pos = global_position


func _process(delta):
	if colided:
		print("Kokoro ILY")

	if draggable:
		global_position = get_global_mouse_position()
		
		if sprite_width % 128 == 0:
			$ShadowArea.global_position.x = (int((global_position.x-32)/64)) * 64 + 64
			$ShadowArea.global_position.y = (int((global_position.y-32)/64)) * 64 + 64
		else:
			$ShadowArea.global_position.x = (int((global_position.x)/64)) * 64 + 32
			$ShadowArea.global_position.y = (int((global_position.y)/64)) * 64 + 32


func snap_position():
	if not colided:
		if sprite_width % 128 == 0:
			global_position.x = (int((global_position.x-32)/64)) * 64 + 64
			global_position.y = (int((global_position.y-32)/64)) * 64 + 64
		else:
			global_position.x = (int(global_position.x/64)) * 64 + 32
			global_position.y = (int(global_position.y/64)) * 64 + 32
		
		$ShadowArea.global_position = global_position
		last_pos = global_position
	
	elif colided:
		global_position = last_pos
		$ShadowArea.global_position = last_pos


@warning_ignore("native_method_override")
func get_class(): 
	return "Item"


@warning_ignore("native_method_override")
func is_class(value):
	return value == "Item"


func _on_shadow_area_area_entered(area):
	if area.name == "ShadowArea":
		colided = true


func _on_shadow_area_area_exited(area):
	if area.name == "ShadowArea":
		colided = false
