extends Node2D

@onready var animation_player = $AnimationPlayer2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spindetection_2_body_entered(body):
	if body.name == "Player":
		animation_player.play("spinning")


func _on_spindetection_2_body_exited(body):
	animation_player.play("RESET")
