extends Node2D

var won = false

# Called when the node enters the scene tree for the first time.
func _ready():
	TutorialTracker.restart_game()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("reboot"):
		get_tree().reload_current_scene()
		
	if TutorialTracker.monsters_killed >= TutorialTracker.win_kills and !won:
		won = true
		$SummonSigil.stop_monsters()
		$TimerTransition.start()
		


func _on_timer_transition_timeout():
	get_tree().change_scene_to_file("res://SCENES/GameOver.tscn")
	pass # Replace with function body.


func _on_player_player_died():
	$SummonSigil.stop_monsters()
	$TimerTransition.start()
	pass # Replace with function body.
