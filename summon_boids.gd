extends Node

func get_holder() -> Node2D:
	return get_tree().get_root().get_node("GAME/BOIDS")

func get_tower() -> Node2D:
	return get_tree().get_root().get_node("GAME/Tower")
	
func get_player() -> Node2D:
	return get_tree().get_root().get_node("GAME/Player")

func get_fx() -> Node2D:
	return get_tree().get_root().get_node("GAME/FX")
