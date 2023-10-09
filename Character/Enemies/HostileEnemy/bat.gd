extends CharacterBody2D

class_name Bat

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@export var hit_state : State
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var Player_chase = false
var Player = null
var rng = RandomNumberGenerator.new()
@export var SPEED : float = rng.randi_range(50,100)
func _ready():
	animation_tree.active = true

func _physics_process(delta):
	if state_machine.check_if_can_move():
		if Player_chase:
			position += (Player.position - position)/SPEED
			var leftorright : float = (position.x - Player.position.x)
			update_facing_direction(leftorright)
			
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func update_facing_direction(leftorright):
	if leftorright > 0:
		sprite.flip_h = true
	elif leftorright < 0:
		sprite.flip_h = false


func _on_detection_area_body_entered(body):
	Player = body
	Player_chase = true
func _on_detection_area_body_exited(body):
	Player_chase = false


