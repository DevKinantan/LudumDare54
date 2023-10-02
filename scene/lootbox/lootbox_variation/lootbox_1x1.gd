extends Node2D

var item = [
	"res://scene/item/normal_2x2/galoon_water.tscn",
	"res://scene/item/normal_2x2/gold.tscn",
	"res://scene/item/normal_2x2/nuke_reactor.tscn",
	"res://scene/item/normal_2x2/sapi.tscn"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var item_node = load(item[randi_range(0, len(item)-1)]).instantiate()
	#item_node.position = Vector2(-32, 32)
	$Lootbox.add_child(item_node)
