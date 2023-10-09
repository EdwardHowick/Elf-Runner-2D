extends CharacterBody2D

var Player_chase = false
var Player = null
var rng = RandomNumberGenerator.new()
@export var SPEED : float = rng.randi_range(100,150)
@onready var sprite : Sprite2D = $Sprite2D

	
func _physics_process(delta):
	if Player_chase:
			position += (Player.position - position)/SPEED
			var leftorright : float = (position.x - Player.position.x)
			position.y -= 0.3
			update_facing_direction(leftorright)
			
	move_and_slide()


func update_facing_direction(leftorright):
	if leftorright > 0:
		sprite.flip_h = false
	elif leftorright < 0:
		sprite.flip_h = true
	


func _on_area_2d_body_entered(body):
	Player = body
	Player_chase = true


func _on_area_2d_body_exited(body):
	Player_chase = false
