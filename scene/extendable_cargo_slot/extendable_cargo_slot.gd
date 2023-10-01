extends Node2D

@export var slot: int = 0

var extended_slot_trs  = preload("res://scene/extendable_cargo_slot/extended_slot.tscn")

func _ready():
	create_slot()


func create_slot():
	if is_instance_valid($ExtendedSlots):
		remove_child($ExtendedSlots)

	var extended_slots = Node2D.new()
	extended_slots.name = "ExtendedSlots"
	extended_slots.position.y = -64
	add_child(extended_slots)

	for i in range(slot):
		var extended_slot = extended_slot_trs.instantiate()
		extended_slot.position.y = -64 * i
		extended_slots.add_child(extended_slot)
	
	$TopSlot.position.y = -64 * (slot+1)


func set_slot(num_slot: int):
	slot = num_slot
	create_slot()
