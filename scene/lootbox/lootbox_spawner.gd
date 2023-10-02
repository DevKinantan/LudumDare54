extends Node2D

var lootbox = [
	"res://scene/lootbox/lootbox_variation/lootbox_1x1.tscn",
	"res://scene/lootbox/lootbox_variation/lootbox_2x2.tscn"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#spawn_lootbox()


func spawn_lootbox():
	var lootbox_node = load(lootbox[randi_range(0, len(lootbox)-1)]).instantiate()
	lootbox_node.position = Vector2(512, 512)
	add_child(lootbox_node)
