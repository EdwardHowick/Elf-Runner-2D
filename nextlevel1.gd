extends Area2D


func _on_body_entered(body):
	if body.name == "Player":
		print_debug("die")
		get_tree().change_scene_to_file("res://Levels/level_2.tscn")
