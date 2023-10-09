extends CharacterBody2D
@onready var turntimer = $TurnTimer
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var sprite : Sprite2D = $Sprite2D
@export var starting_move_direction : Vector2 = Vector2.LEFT
var rng = RandomNumberGenerator.new()
var movement_speed : float = rng.randi_range(10,100)
@export var hit_state : State
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	turntimer.wait_time = rng.randi_range(3,10)
	animation_tree.active = true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction : Vector2 = starting_move_direction
	if direction && state_machine.check_if_can_move():
		velocity.x = direction.x * movement_speed
	elif state_machine.current_state != hit_state:
		#velocity.x = move_toward(velocity.x, 0, movement_speed)
		pass
		

	move_and_slide()


func _on_turn_timer_timeout():
	movement_speed = rng.randi_range(-100,100)
	if movement_speed > 0:
		sprite.flip_h = true
	if movement_speed < 0:
		sprite.flip_h = false





func _on_turn_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "turnaround":
		movement_speed = -60
		sprite.flip_h = false
	if area.name == "turnaround2":
		movement_speed = 60
		sprite.flip_h = true
