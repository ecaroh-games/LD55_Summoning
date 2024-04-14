class_name PlayerWalk extends State

func Enter() -> void:
	player.switch_anim("walk")
	pass

func Physics_Update(delta):
	if Input.is_action_just_pressed("ui_accept"):
		return

	var d = input_key(Input)
	if d != Vector2.ZERO:
		player.velocity += d.normalized() * player.accel_ratio()
	else:
		player.friction(delta)
		if player.velocity.length() < 23:
			Transitioned.emit(self, "Idle")
			return


func Exit() -> void:
	$AudioStreamPlayer.stop()
	pass

func on_frame_change() -> void:
	match player.Anim.frame:
		1: $AudioStreamPlayer.play()
	pass

func input_key(_event) -> Vector2:
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	return Vector2(direction_x, direction_y)
