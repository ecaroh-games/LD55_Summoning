extends Node

func get_music() -> Music:
	return get_tree().get_root().get_node("GAME/MUSIC")
	
func set_EQ(num:int):
	get_music().set_EQ(num)
