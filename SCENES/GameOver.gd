extends Node2D

var message = ""
var current_message = 0
var messages = [
	"Helpers summoned : " + str(TutorialTracker.helpers_spawned),
	"Helpers lost : " + str(TutorialTracker.helpers_lost),
	"Electrons spawned : " + str(TutorialTracker.electrons_spawned),
	"Thanks for playing!",
	"\nMade in 48 hrs",
	"for Ludum Dare 55",
	"by ecaroh.games"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	var title:String
	if TutorialTracker.monsters_killed < TutorialTracker.win_kills:
		title = "Game Over"
	else:
		title = "You Win!"
	var centertag = "[center]"
	var wavetag = "[wave  freq=2.3 amp=23 connected=0]"
	var wavetag_close = "[/wave]"
	var centertag_close = "[/center]"
	$TextTitle.text = centertag + wavetag + title + wavetag_close + centertag_close
	$Timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var centertag = "[center]"
	var wavetag = "[wave  freq=2.3 amp=12 connected=0]"
	var wavetag_close = "[/wave]"
	var centertag_close = "[/center]"
	$TextWin.text = centertag + wavetag + message + wavetag_close + centertag_close


func _on_timer_timeout():
	if current_message < messages.size():
		$AudioStreamPlayer.play()
		message += "\n"
		message += messages[current_message]
		current_message += 1
		$Timer.start(0.23)
	pass # Replace with function body.


func _on_button_pressed():
	TutorialTracker.restart_game()
	get_tree().change_scene_to_file("res://SCENES/GAME.tscn")
	pass # Replace with function body.
