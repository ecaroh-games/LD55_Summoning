class_name Spark extends Node2D

var lifetime = randf_range(0.23, 1.23)
var life = lifetime

@onready var Anim:AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Anim.frame = randi_range(0, Anim.sprite_frames.get_frame_count(Anim.animation))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	life = lerp(life, 0.0, 1 - pow(0.5, delta))
	scale = Vector2.ONE * (life / lifetime)
	pass


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
