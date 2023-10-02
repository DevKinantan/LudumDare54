extends Node2D

@export var effect_type = "flame"

var moving: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	
	if effect_type == "bloom":
		clear_bloom_spot()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var shadow_area = get_parent().get_node_or_null("ShadowArea")
	if shadow_area != null:
		position = shadow_area.position


func clear_bloom_spot():
	for bloom_spot in get_node("BloomSpots").get_children():
		var bloom_spot_area = bloom_spot.get_node("BloomArea")
		bloom_spot_area.visible = false
		bloom_spot_area.monitorable = false


func check_colided_with_area(check_area, area_name: String):
	for area in check_area.get_overlapping_areas():
		if area.name == area_name and get_parent().get_parent() != area.get_parent().get_parent():
			return true
	return false


func spawn_bloom_spot():
	for bloom_spot in get_node("BloomSpots").get_children():
		var bloom_spot_area = bloom_spot.get_node("BloomArea")
		var in_inventory_area = check_colided_with_area(bloom_spot_area, "InventoryArea")
		var in_item_area = check_colided_with_area(bloom_spot_area, "ItemArea")
		if in_inventory_area and not in_item_area:
			bloom_spot_area.visible = true
			bloom_spot_area.monitorable = true


func _on_item_drag_mode(status):
	visible = status
	moving = true
	
	if effect_type == "bloom":
		visible = true
		$EffectArea.visible = status
	
		if status == false:
			spawn_bloom_spot()
		elif status == true:
			clear_bloom_spot()
