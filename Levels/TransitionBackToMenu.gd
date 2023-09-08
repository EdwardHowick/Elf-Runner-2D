extends Button


@export var transitioner : Transitioner


func _on_pressed():
	hide()
	transitioner.set_next_animation()
	
