extends Control


class_name Transitioner

@export var scene_switch_anim : String = "fade_out"
#@export var scene_to_load : PackedScene

@onready var animation_tex : TextureRect = $TextureRect
@onready var animation_player : AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tex.visible = false

func set_next_animation():
	animation_player.queue("fade_out")


func _on_animation_player_animation_finished(anim_name):
	get_tree().change_scene_to_file("res://UI/menu.tscn")   
