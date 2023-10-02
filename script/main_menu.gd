extends Node2D


func _on_start_button_mouse_entered():
	$StartButton.self_modulate = Color.DARK_GRAY


func _on_start_button_mouse_exited():
	$StartButton.self_modulate = Color.WHITE


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://scene/test_gameplay.tscn")
