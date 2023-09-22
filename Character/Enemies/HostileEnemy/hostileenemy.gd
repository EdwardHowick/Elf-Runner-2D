extends CharacterBody2D

class_name HostileEnemy
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@export var starting_move_direction : Vector2 = Vector2.LEFT
@export var hit_state : State
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var Player_chase = false
var Player = null
var rng = RandomNumberGenerator.new()
@export var SPEED : float = rng.randi_range(20,70)
func _ready():
	animation_tree.active = true

func _physics_process(delta):
	var direction : Vector2 = starting_move_direction
	if direction && state_machine.check_if_can_move():
		if Player_chase:
			position.x += (Player.position.x - position.x)/SPEED
			var leftorright : float = (position.x - Player.position.x)
			update_facing_direction(leftorright)
			
	if not is_on_floor():
		velocity.y += gravity * delta
	elif state_machine.current_state != hit_state:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()

func update_facing_direction(leftorright):
	if leftorright > 0:
		sprite.flip_h = false
	elif leftorright < 0:
		sprite.flip_h = true


func _on_detection_area_body_entered(body):
	Player = body
	Player_chase = true

func _on_detection_area_body_exited(body):
	Player_chase = false


