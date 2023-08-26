extends Node

class_name Damageable

signal on_hit(node : Node, Damage_taken : int, knockback_direction : Vector2)

@export var health : float = 20 : 
	get:
		return health
	set(value):
		SignalBus.emit_signal("on_health_changed", get_parent(), value - health)
		health = value
		
@export var dead_animation_name : String = "dead"
	
func hit(damage : int, knockback_direction : Vector2):
	health -= damage
	
	emit_signal("on_hit", get_parent(), damage, knockback_direction)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_tree_animation_finished(anim_name):
	if(anim_name == dead_animation_name):
		# character is finished dying, remove from game
		get_parent().queue_free()
