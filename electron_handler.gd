extends Node

func get_electron_ui() -> ElectronBar:
	return get_tree().get_root().get_node("GAME/UI/UI_Electron_Bar")
	
func update_electrons(amt:int):
	get_electron_ui().update_electrons(amt)

func check_electrons() -> bool:
	if get_electron_ui().current_electrons > 0:
		return true
	else:
		return false
		
func check_electrons_max() -> bool:
	if get_electron_ui().current_electrons < get_electron_ui().max_electrons:
		return true
	else:
		return false
		
func flash():
	get_electron_ui().flash()
