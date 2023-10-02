extends Node2D

var curr_page = 0
var tutorial_sprite = [
	"res://image/Tutorial/Tutorial 1.png",
	"res://image/Tutorial/Tutorial2.png",	
	"res://image/Tutorial/Tutorial3.png",	
	"res://image/Tutorial/Tutorial4.png",	
	"res://image/Tutorial/Tutorial5.png",	
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_next_pressed():
	if curr_page < 4:
		curr_page += 1
	$Tutorial/SpriteHelp.texture = load(tutorial_sprite[curr_page])


func _on_previos_pressed():
	if curr_page > 0:
		curr_page -= 1
	$Tutorial/SpriteHelp.texture = load(tutorial_sprite[curr_page])


func _on_close_pressed():
	$Tutorial.visible = false


func _on_help_button_pressed():
	$Tutorial.visible = true
