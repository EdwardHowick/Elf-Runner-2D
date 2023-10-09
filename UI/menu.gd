extends Node2D

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://Levels/level_1.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_play_again_button_pressed():
	get_tree().change_scene_to_file("res://UI/menu.tscn")
