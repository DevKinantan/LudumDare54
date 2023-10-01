extends Node2D


func _on_increate_slot_button_pressed():
	var extendable_slot = $ExtendableCargoSlot
	$ExtendableCargoSlot.set_slot(extendable_slot.slot+1)


func _on_decrease_slot_button_pressed():
	var extendable_slot = $ExtendableCargoSlot
	$ExtendableCargoSlot.set_slot(extendable_slot.slot-1)
