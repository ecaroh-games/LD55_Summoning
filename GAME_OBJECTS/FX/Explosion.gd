extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween().set_parallel()
	tween.tween_property($PointLight2D, "energy", 0, 0.5)
	tween.tween_property($PointLight2D, "texture_scale", 7, 0.23).set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property($Sprite2D, "scale", Vector2(1.0, 0.69) * 3, 0.23).set_ease(Tween.EASE_OUT)
	tween.tween_property($Sprite2D, "modulate", Color.TRANSPARENT, 0.23).set_ease(Tween.EASE_OUT)
	tween.tween_property($GPUParticles2D, "amount_ratio", 0, 0.44)
	tween.finished.connect(_on_tween_finished)
	$AudioStreamPlayer2D.play()
	$AudioStreamPlayer2D2.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_tween_finished():
	$Timer.start()


func _on_timer_timeout():
	#print("remove")
	#queue_free()
	pass # Replace with function body.
