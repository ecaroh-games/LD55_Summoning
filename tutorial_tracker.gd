extends Node

#lvl 1
var distance_traveled := 0.0
var max_distance := 23.0

#lvl 2
var helpers_spawned:int = 0
var max_helpers:int = 3

#lvl 3
var crystals_charged:int = 0
var max_crystals:int = 1

#lvl 4
var electrons_spawned:int = 0
var max_electrons:int = 5

#lvl 5
var monsters_killed:int = 0
var max_monsters:int = 10
var win_kills:int = 123


var tutorial_level := 1
var tutorial_message:String
var max_level := 6


#extra
var helpers_lost = 0

var enabled_left_click = false
var enabled_right_click = false
var enabled_monsters = false
var questing := true

func _ready():
	#skip_tutorial()
	#next_level()
	pass
	
func restart_game():
	distance_traveled = 0.0
	helpers_spawned= 0
	crystals_charged = 0
	max_crystals = 1
	electrons_spawned = 0
	monsters_killed = 0
	tutorial_level = 1
	helpers_lost = 0
	enabled_left_click = false
	enabled_right_click = false
	enabled_monsters = false
	questing = true

func skip_tutorial():
	enabled_left_click = true
	enabled_right_click = true
	enabled_monsters = true
	questing = false
	get_tree().get_root().get_node("GAME/SummonSigil").start_monsters()
	tutorial_level = max_level
	get_dialogue().skip_tutorial()

func update_tutorial():
	match tutorial_level:
		1: 
			tutorial_message = "Meters traveled: " + str(floor(distance_traveled)) + " / " + str(floor(max_distance))
			if distance_traveled > max_distance:
				enabled_right_click = true
				next_level()
		2: 
			tutorial_message = "Helpers summoned: " + str(floor(helpers_spawned)) + " / " + str(floor(max_helpers))
			if helpers_spawned >= max_helpers:
				next_level()
		3: 
			tutorial_message = "Crystals powered: " + str(floor(crystals_charged)) + " / " + str(floor(max_crystals))
			if crystals_charged >= max_crystals:
				enabled_left_click = true
				next_level()
		4: 
			tutorial_message = "Electrons spawned: " + str(floor(electrons_spawned)) + " / " + str(floor(max_electrons))
			if electrons_spawned >= max_electrons:
				next_level()
		5: 
			max_crystals = 3
			tutorial_message = "Crystals powered: " + str(floor(crystals_charged)) + " / " + str(floor(max_crystals))
			if crystals_charged >= max_crystals:
				get_tree().get_root().get_node("GAME/SummonSigil").start_monsters()
				enabled_left_click = true
				next_level()
		6: 
			tutorial_message = "Monsters defeated: " + str(floor(monsters_killed)) + " / " + str(floor(max_monsters))
			if monsters_killed >= max_monsters:
				next_level()
		_: tutorial_message = ""

func next_level():
	get_dialogue().clear_tutorial()
	tutorial_level += 1
	if tutorial_level > max_level:
		questing = false
	get_dialogue().continue_tutorial()

func _process(delta):
	if get_tree().get_root().has_node("GAME"):
		if Input.is_action_just_pressed("ui_accept"):
			skip_tutorial()
		if questing:
			update_tutorial()
			get_dialogue().display_tutorial(str(tutorial_message))
		else:
			get_dialogue().display_win_condition("Monsters defeated: " + str(floor(mini(monsters_killed, win_kills))) + " / " + str(floor(win_kills)) )

func percent_complete() -> float:
	return float(monsters_killed) / win_kills

func message(msg:String):
	get_dialogue().add_message(str(msg))

func get_dialogue() -> Node2D:
	return get_tree().get_root().get_node("GAME/UI/Dialogue")
