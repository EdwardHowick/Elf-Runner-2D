extends Node2D
@export var transitioner : Transitioner

# Called when the node enters the scene tree for the first time.
func _ready():
	transitioner.new_level_animation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
