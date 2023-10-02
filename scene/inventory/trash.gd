extends Node2D

var trash_open_sprite = preload("res://image/TrashOpen.png")
var trash_closed_sprite = preload("res://image/TrashClosed.png")


func _on_trash_area_area_entered(area):
	if area.name == "ItemArea":
		get_node("TrashLogo").texture = trash_open_sprite


func _on_trash_area_area_exited(area):
	if area.name == "ItemArea":	
		get_node("TrashLogo").texture = trash_closed_sprite
