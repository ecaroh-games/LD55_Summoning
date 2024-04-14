class_name Monster extends CharacterBody2D

var speed = randf_range(23, 69)

var target:Node2D

func _physics_process(delta):
	var d = target.position - position
	velocity = d.normalized() * speed
	move_and_slide()
	pass
