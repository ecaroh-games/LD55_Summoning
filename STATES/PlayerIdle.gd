class_name PlayerIdle extends State

func Enter() -> void:
	player.switch_anim("idle")
	pass

func Physics_Update(delta):
	if Input.is_action_just_pressed("ui_accept"):
		return

	#var d = (player.get_global_mouse_position() - player.global_position)
	var d = input_key(Input)
	if d != Vector2.ZERO:
		player.velocity += d.normalized() * player.accel_ratio()
		if player.velocity.length() > 23:
			Transitioned.emit(self, "Walk")
			return
		
	else:
		player.friction(delta)


func Exit() -> void:
	pass

func on_frame_change() -> void:
	pass

func input_key(_event) -> Vector2:
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	return Vector2(direction_x, direction_y)
