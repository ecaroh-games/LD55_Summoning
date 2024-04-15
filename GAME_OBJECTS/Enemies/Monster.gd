class_name Monster extends CharacterBody2D

var speed = randf_range(23, 69)

var target:Node2D

@onready var Anim:AnimatedSprite2D = $AnimatedSprite2D

func _ready():
	Anim.play("spawn")
	set_physics_process(false)

func _physics_process(delta):
	if target == null:
		target = SummonBoids.get_player()
	var d = target.position - position
	velocity = d.normalized() * speed
	move_and_slide()
	pass


func _on_animated_sprite_2d_animation_finished():
	if Anim.animation == "spawn":
		set_physics_process(true)
		Anim.play("walk")
	elif Anim.animation == "death":
		queue_free()
	pass # Replace with function body.

func die(points:bool = true):
	if points:
		TutorialTracker.monsters_killed += 1
	Anim.play("death")
	set_physics_process(false)
	$CollisionShape2D.set_deferred("disabled", true)

func cooldown():
	$AreaAttack/CollisionShape2D.set_deferred("disabled", true)
	$TimerCooldown.start()

func _on_area_2d_body_entered(body):
	if target is Player:
		if body is Helper:
			target = body
	elif !(target is Player):
		if body is Player:
			target = body
	pass # Replace with function body.


func _on_timer_cooldown_timeout():
	$AreaAttack/CollisionShape2D.set_deferred("disabled", false)
	pass # Replace with function body.
