extends Node2D

@export var can_drag = true

var picked_item = null

func _input(event):
	if event is InputEventMouseMotion:
		global_position = get_global_mouse_position()
	
	if can_drag and event is InputEventMouseButton:
		if event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_collision = $Area2D
			for area in mouse_collision.get_overlapping_areas():
				if area.get_parent().is_class("Item"):
					picked_item = area.get_parent()
					picked_item.set_drag_mode(true)
					break
		
		if event.is_released() and picked_item != null:
			picked_item.set_drag_mode(false)
			picked_item = null
