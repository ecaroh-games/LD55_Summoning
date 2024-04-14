extends Node

var explosion_instance = preload("res://GAME_OBJECTS/FX/Explosion.tscn")

func get_holder() -> Node2D:
	return get_tree().get_root().get_node("GAME/FX")
	

func explode(pos:Vector2):
	var explosion = explosion_instance.instantiate()
	explosion.position = pos
	get_holder().add_child(explosion)
