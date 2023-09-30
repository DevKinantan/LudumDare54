extends Node2D

var picked_item = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if event is InputEventMouseMotion:
		global_position = get_global_mouse_position()
	
	if event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_collision = $Area2D
			for area in mouse_collision.get_overlapping_areas():
				if area.get_parent().is_class("Item"):
					picked_item = area.get_parent()
					picked_item.draggable = true
					picked_item.get_node("ShadowSprite").visible = true
					break
		
		if event.is_released() and picked_item != null:
			picked_item.draggable = false
			picked_item.get_node("ShadowSprite").visible = false
			picked_item.global_position.x = (int(picked_item.global_position.x / 64)) * 64 + (picked_item.sprite_width/2)
			picked_item.global_position.y = (int(picked_item.global_position.y / 64)) * 64 + (picked_item.sprite_width/2)
			picked_item = null
