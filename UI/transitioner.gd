extends Control

class_name Transitioner

@export var scene_switch_anim : String = "fade_out"
#@export var scene_to_load : PackedScene

@onready var animation_tex : TextureRect = $TextureRect
@onready var animation_player : AnimationPlayer = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tex.visible = false
func fade_out_animation():
	animation_player.play("fade_out")
func death_fade_animation():
	animation_player.play("fade_out_death")
func fade_in_animation():
	animation_player.play("fade_in")
func next_level_animation():
	animation_player.play("fade_out_next_level")
func new_level_animation():
	animation_player.play("fade_in_new_level")
func level_3_fade_out():
	animation_player.play("fade_out_level_3")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "fade_out":
		get_tree().change_scene_to_file("res://UI/menu.tscn")
	if anim_name == "fade_out_death":
		get_tree().change_scene_to_file("res://UI/death_screen.tscn")
	if anim_name == "fade_out_next_level":
		get_tree().change_scene_to_file("res://Levels/level_2.tscn")
	if anim_name == "fade_out_level_3":
		get_tree().change_scene_to_file("res://Levels/level_3.tscn")
			
