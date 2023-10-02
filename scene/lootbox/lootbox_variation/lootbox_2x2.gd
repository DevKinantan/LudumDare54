extends Node2D

var item = [
	"res://scene/item/normal_1x1/amber.tscn",
	"res://scene/item/normal_1x1/hidden_blade.tscn",
	"res://scene/item/normal_1x1/jerrycan.tscn",
	"res://scene/item/normal_1x1/nokia3310.tscn",
	
	"res://scene/item/batu_bara/batu_bara.tscn",
	"res://scene/item/beker_kimia/beker_kimia.tscn",
	"res://scene/item/bloom_diamod/bloom_diamond.tscn",
	"res://scene/item/flame_diamond/flame_diamond.tscn",
	"res://scene/item/pot/pot.tscn",
	"res://scene/item/toxic_diamond/toxic_diamond.tscn"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var item_node = load(item[randi_range(0, len(item)-1)]).instantiate()
	item_node.position = Vector2(-32, 32)
	$Lootbox.add_child(item_node)
