extends Node2D

@export var player:Player
@export var MonsterHolder:Node2D

var summon_instance = preload("res://GAME_OBJECTS/Enemies/Monster.tscn")

func _on_animated_sprite_2d_animation_finished():
	summon()

func summon():
	$AudioStreamPlayer2D.play()
	var monster = summon_instance.instantiate()
	monster.position = position
	monster.target = player
	MonsterHolder.add_child(monster)
	pass
