extends CharacterBody2D	
class_name Player
@export var transitioner : Transitioner
var enemy_attack_cooldown = true
var playerinattackrange = false
var batattackrangeplayer = false
var health = 100
@onready var animation_player = $AnimationPlayer
@export var speed : float = 200.0
@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : CharacterStateMachine = $CharacterStateMachine
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2 = Vector2.ZERO

signal facing_direction_changed(facing_right : bool)

func _ready():
	animation_tree.active = true
	
func _process(delta):
	if Input.is_action_pressed("escape"):
		transitioner.fade_out_animation()
		
func _physics_process(delta):
	update_health()
	enemy_attack()
	if health <= 0:
		animation_player.play("death")
		transitioner.death_fade_animation()
		
		
		
		
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("left", "right", "up", "down")
	
	# Control whether to move or not to move
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		

	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	
func update_animation_parameters():
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
		
	emit_signal("facing_direction_changed", !sprite.flip_h)
	
	
func _on_damage_area_body_entered(body):
		if body.is_in_group("Bat"):
			batattackrangeplayer = true
		if body.is_in_group("Ghost"):
			playerinattackrange = true
			
		


func _on_damage_area_body_exited(body):
	playerinattackrange = false
	batattackrangeplayer = false


func enemy_attack():
	if playerinattackrange and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$damage_area/attack_cooldown.start()
	if batattackrangeplayer and enemy_attack_cooldown == true:
		health = health - 10
		enemy_attack_cooldown = false
		$damage_area/attack_cooldown.start()
		


func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true


func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true
		
func _on_regen_timer_timeout():
	if health < 100:
		health = health + 10
	if health > 100:
		health = 100
	if health <= 0:
		health = 0

		
func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.name == "Fallzone1":
		transitioner.death_fade_animation()
	if area.name == "NextLevel":
		transitioner.next_level_animation()
	if area.name == "NextLevel1":
		transitioner.level_3_fade_out()
	if area.name == "gameend":
		transitioner.game_end()
