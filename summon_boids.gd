extends Node

func get_holder() -> Node2D:
	return get_tree().get_root().get_node("GAME/BOIDS")
