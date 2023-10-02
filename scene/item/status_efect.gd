extends Node2D

@export var have_flame: bool = false
@export var have_toxic: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$LogoFlame.visible = have_flame
	$LogoToxic.visible = have_toxic


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_set_effect(effect, status):
	if effect == "flame":
		have_flame = status
		$LogoFlame.visible = status
	elif effect == "toxic":
		have_toxic = status
		$LogoToxic.visible = status
		get_parent().get_parent().cant_sell = status
		
	
	if not get_parent().draggable:
		trigger_effect()


func trigger_effect():
	get_parent().lock_position = have_flame


func _on_item_position_change(area_parent, source):
	trigger_effect()
	if have_flame:
		get_parent().get_parent().destroy_item_if_possible()
	
	var flameable_area = get_parent().get_node_or_null("Flameable/EffectArea")
	if flameable_area != null:
		for area in flameable_area.get_overlapping_areas():
			if area.name == "ItemArea":
				pass
				#print(area.get_parent().get_node("StatusEffect").have_flame)
				
			if area.name == "ItemArea" and area.get_parent().get_node("StatusEffect").have_flame:
				area.get_parent().get_parent().destroy_item_if_possible()
