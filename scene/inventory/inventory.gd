extends Node2D

signal inventory_sold(total)

@export var is_open = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$ExtendableCargoSlot.visible = is_open
	$ExtendableCargoSlot.set_slot_monitorable(is_open)
	$UserPointer.can_drag = is_open
	
	$Trash.visible = is_open
	$Trash/TrashArea.monitorable = is_open
	
	$SalesPanel.visible = false


func _on_button_pressed():
	is_open = not is_open
	$ExtendableCargoSlot.visible = is_open
	$ExtendableCargoSlot.set_slot_monitorable(is_open)
	$UserPointer.can_drag = is_open

	$Trash.visible = is_open
	$Trash/TrashArea.monitorable = is_open


func get_total_inventory():
	var sum = 0
	var item_list = get_node("ExtendableCargoSlot/ItemList").get_children()
	for item in item_list:
		if not item.cant_sell:
			sum += item.price
	return sum


func sell_inventory_items():
	var sum = 0
	var item_sold = ""
	var item_list = get_node("ExtendableCargoSlot/ItemList").get_children()
	for item in item_list:
		if not item.cant_sell:
			sum += item.price
			item_sold += (item.item_name + " = " + str(item.price) + "\n")
		elif item.cant_sell:
			item_sold += (item.item_name + "(toxic) = 0\n")
			
		item.queue_free()
	
	get_node("SalesPanel/Item").text = item_sold
	get_node("SalesPanel/Footer").text = ("Total: " + str(sum))
	emit_signal("inventory_sold", sum)
	
	$SalesPanel.visible = true


func _on_sell_button_pressed():
	sell_inventory_items()
