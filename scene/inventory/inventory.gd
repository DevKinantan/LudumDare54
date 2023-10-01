extends Node2D

@export var is_open = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$ExtendableCargoSlot.visible = is_open
	$ExtendableCargoSlot.set_slot_monitorable(is_open)
	$UserPointer.can_drag = is_open


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	is_open = not is_open
	$ExtendableCargoSlot.visible = is_open
	$ExtendableCargoSlot.set_slot_monitorable(is_open)
	$UserPointer.can_drag = is_open
