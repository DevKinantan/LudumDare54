class_name ItemObject extends Node2D

@export var cant_sell: bool = false
@export var destroy_by_flame: bool = false
@export var price: int = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_position_change(area_parent, source):
	print(area_parent)
	if get_parent() != area_parent:
		get_parent().remove_child(self)
		area_parent.add_child(self)
		source.snap_to_last_position()


func destroy_item_if_possible():
	if destroy_by_flame:
		queue_free()


@warning_ignore("native_method_override")
func get_class(): 
	return "ItemObject"


#@warning_ignore("native_method_override")
#func is_class(value):
#	return value == "ItemObject"
