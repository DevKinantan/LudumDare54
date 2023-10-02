class_name Item extends Node2D

signal position_change(area_parent, source)
signal drag_mode(status)
signal set_effect(effect, status)

@export var lock_position: bool = false

var draggable = false
var sprite_width = null
var sprite_height = null
var last_pos = null

var check_inventory_area = true

func _ready():
	sprite_width = int($Sprite2D.texture.get_width() * $Sprite2D.scale.x)
	sprite_height = int($Sprite2D.texture.get_height() * $Sprite2D.scale.y)
	last_pos = global_position
	snap_position()


func _process(_delta):
	if draggable:
		global_position = get_global_mouse_position()
		
		if sprite_width % 128 == 0:
			$ShadowArea.global_position.x = (int((global_position.x-32)/64)) * 64 + 64
		else:
			$ShadowArea.global_position.x = (int((global_position.x)/64)) * 64 + 32
		
		if sprite_height % 128 == 0:
			$ShadowArea.global_position.y = (int((global_position.y-32)/64)) * 64 + 64
		else:
			$ShadowArea.global_position.y = (int((global_position.y)/64)) * 64 + 32


func is_colided(shadowArea):
	for area in shadowArea.get_overlapping_areas():
		if area.name == "ShadowArea" or area.name == "BloomArea":
			return true
	return false


func check_colided_with_area(shadowArea, area_name: String):
	for area in shadowArea.get_overlapping_areas():
		if area.name == area_name:
			return true
	return false


func get_inventory_area_parent(shadowArea):
	for area in shadowArea.get_overlapping_areas():
		if area.name == "InventoryArea":
			return area.get_parent()
	return null


func in_inventory_area(shadowArea):
	var in_inventory = check_colided_with_area(shadowArea, "InventoryArea")
	var in_outside = check_colided_with_area(shadowArea, "OutsideArea")

	return in_inventory and not in_outside


func snap_position():
	global_position = get_global_mouse_position()
	var colided = is_colided($ShadowArea)
	
	var in_area = true
	if check_inventory_area:
		in_area = in_inventory_area($ShadowArea)
	
	var in_trash_area = check_colided_with_area($ShadowArea, "TrashArea")
		
	if not colided and in_area:
		if sprite_width % 128 == 0:
			global_position.x = (int((global_position.x-32)/64)) * 64 + 64
		else:
			global_position.x = (int(global_position.x/64)) * 64 + 32
		
		if sprite_height % 128 == 0:
			global_position.y = (int((global_position.y-32)/64)) * 64 + 64
		else:
			global_position.y = (int(global_position.y/64)) * 64 + 32
		
		$ShadowArea.global_position = global_position
		last_pos = global_position
		
		var new_parent = get_inventory_area_parent($ShadowArea)
		
		# Check if area parent from extendable cargo
		if new_parent.name == "TopSlot" or new_parent.name == "BottomSlot":
			new_parent = new_parent.get_parent().get_node("ItemList")
		elif new_parent.get_parent().name == "ExtendedSlots":
			new_parent = new_parent.get_parent().get_parent().get_node("ItemList")
		emit_signal("position_change", new_parent , self)
	
	elif in_trash_area:
		get_parent().queue_free()
	
	else:
		snap_to_last_position()


func snap_to_last_position():
		global_position = last_pos
		$ShadowArea.global_position = last_pos


func set_drag_mode(drag_mode: bool):
	if not lock_position:
		draggable = drag_mode
		top_level = drag_mode
		emit_signal("drag_mode", draggable)
	
		if not drag_mode:
			snap_position()


@warning_ignore("native_method_override")
func get_class(): 
	return "Item"


@warning_ignore("native_method_override")
func is_class(value):
	return value == "Item"


func get_effect_area():
	var effect_list = []
	for area in $ShadowArea.get_overlapping_areas():
		if area.name == "EffectArea" and area.get_parent().get_parent() != get_parent().get_parent():
			var effect_type = area.get_parent().effect_type
			if effect_type not in effect_list:
				effect_list.append(effect_type)
	return effect_list


func _on_shadow_area_area_entered(area):
	if area.name == "EffectArea" and (area.get_parent().get_parent().get_parent() != get_parent()):
		emit_signal("set_effect", area.get_parent().effect_type, true)


func _on_shadow_area_area_exited(area):
	if area.name == "EffectArea" and (area.get_parent().get_parent().get_parent() != get_parent()):
		if area.get_parent().effect_type not in get_effect_area():
			emit_signal("set_effect", area.get_parent().effect_type, false)
		
