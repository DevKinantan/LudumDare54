extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_position_change(area_parent, source):
	if get_parent() != area_parent:
		get_parent().remove_child(self)
		area_parent.add_child(self)
		#position = position - area_parent.global_position
		#print(global_position)
		print(area_parent.name)
		source.snap_to_last_position()
