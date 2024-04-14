class_name State extends Node

@export var player:Player 

var prev_state:String
var prev_state_REF:State

signal Transitioned

func Enter() -> void:
	pass

func Update(_delta: float) -> void:
	pass

func Physics_Update(_delta: float) -> void:
	pass

func Exit() -> void:
	pass

func input_key(_event):
	pass

func input_mouse(_event):
	pass

func on_anim_finished() -> void:
	pass

func on_frame_change() -> void:
	#match player.Anim.frame:
		#0: pass
		#_: pass
	pass
	
func play_sfx(sfx:AudioStreamPlayer):
	if sfx:
		sfx.play()
