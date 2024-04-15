class_name Spark extends Node2D

var lifetime:float
var life:float

@onready var Anim:AnimatedSprite2D = $AnimatedSprite2D

var height:float = 0.0

var start_scale:Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	Anim.frame = randi_range(0, Anim.sprite_frames.get_frame_count(Anim.animation))
	Anim.position.y = height
	Anim.scale = start_scale * (life / lifetime)
	pass # Replace with function body.

func set_life(amt:float):
	lifetime = amt + 0.123
	start_scale = Vector2.ONE * (1.0 + lifetime)
	life = lifetime

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Anim.position.y = height
	life -= delta
	if life < 0.05:
		queue_free()
	Anim.scale = start_scale * (life / lifetime)
	pass


func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.
