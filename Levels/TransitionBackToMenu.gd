extends Button


@export var transitioner : Transitioner

func _on_pressed():
	hide()
	transitioner.fade_out_animation()
	
