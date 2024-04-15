class_name Helper extends StaticBody2D

@onready var Anim:AnimatedSprite2D = $AnimatedSprite2D
@onready var toggle_area:CollisionShape2D = $AreaCharge/CollisionShape2D
@onready var toggle_area_hurtbox:CollisionShape2D = $AreaHurtbox/CollisionShape2D

var spark_instance = preload("res://GAME_OBJECTS/FX/Spark.tscn")
var electron_instance = preload("res://GAME_OBJECTS/Boids/Electron.tscn")

@onready var ElectronHolder = SummonBoids.get_holder()

var Crystals:Node2D
var FX:Node2D

var dying := false
var spawned := false


# Called when the node enters the scene tree for the first time.
func _ready():
	Anim.visible = false
	Anim.stop()
	$AnimSigil.play("sigil")
	$AnimChargeSigil.visible = false
	$sfx_sigil.play()
	#$CollisionShape2D.set_deferred("disabled", false)
	
	#set_physics_process(false)
	#set_physics_process(true)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#position.x += 123 * delta
	#set_collision_layer_value(3, !get_collision_layer_value(3))
	#visible = get_collision_layer_value(3)
	pass


func _on_animated_sprite_2d_animation_finished():
	match Anim.animation:
		"spawn": 
			Anim.play("idle")
			toggle_area.set_deferred("disabled", false)
			toggle_area_hurtbox.set_deferred("disabled", false)
			$Timer.start()
		"death": 
			TutorialTracker.helpers_lost += 1
			queue_free()
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	die()
	pass # Replace with function body.

func despawn():
	dying = true
	$TimerDeath.start()
	

func die():
	if spawned:
		var tween = create_tween()
		tween.tween_property($AnimChargeSigil, "modulate", Color.TRANSPARENT, 0.23)
		dying = true
		$sfx_death.play()
		Anim.play("death")
		toggle_area.set_deferred("disabled", true)
		toggle_area_hurtbox.set_deferred("disabled", true)
	else:
		queue_free()

func _on_timer_timeout():
	if !dying:
		Anim.play("raise")
		$AnimChargeSigil.visible = true
		$AnimChargeSigil.modulate = Color.TRANSPARENT
		$AnimChargeSigil.scale = Vector2.ZERO
		var tween = create_tween().set_parallel()
		tween.tween_property($AnimChargeSigil, "modulate", Color.WHITE, 1.23)
		tween.tween_property($AnimChargeSigil, "scale", Vector2(1.5, 1.0), 1.23)
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_looped():
	if Anim.animation == "raise":
		spawn_electron(1)
		#zap()
		#var Area:Area2D = $AreaCharge as Area2D
		#var overlaps = Area.get_overlapping_bodies()
		#for electron:Electron in overlaps:
			#if electron.charge == -1:
				#electron.charge_up()
	pass # Replace with function body.

func zap():
	var segments = 23
	var randomness = 2.3
	var crystal = get_nearest_crystal()
	crystal.power_up()
	
	var d = crystal.position - position
	
	for i in segments:
		var spark = spark_instance.instantiate()
		spark.position = position + i * (d / segments) + Vector2.ONE * randf_range(-randomness, randomness)
		FX.add_child(spark)
	
	pass
	
func spawn_electron(charge:int):
	var electron = electron_instance.instantiate()
	electron.golden = true
	electron.charge = charge
	electron.position = position + Vector2(10, 0)
	electron.height = -40
	ElectronHolder.add_child(electron)
	
func get_nearest_crystal() -> PowerCrystal:
	var nearestCrystal:PowerCrystal
	var nearest_distance:float
	for child in Crystals.get_children():
		var d = child.position - position
		if nearestCrystal == null or d.length() < nearest_distance:
			nearest_distance = d.length()
			nearestCrystal = child
			
	return nearestCrystal
	pass


func _on_timer_death_timeout():
	die()
	pass # Replace with function body.


func _on_anim_sigil_animation_finished():
	
	$sfx_sigil_end.play()
	var tween = create_tween()
	tween.tween_property($AnimSigil, "modulate", Color.WHITE * 23.23, 0.23)
	#tween.tween_property($AnimSigil, "modulate", Color.TRANSPARENT, 0.53)
	tween.tween_property($AnimSigil, "scale", Vector2.ZERO, 0.23)
	await tween.finished
	$AnimSigil.visible = false
	pass # Replace with function body.


func _on_anim_sigil_frame_changed():
	match $AnimSigil.frame:
		11: 
			if !dying:
				TutorialTracker.helpers_spawned += 1
				spawned = true
				Anim.visible = true
				Anim.frame = 0
				Anim.play("spawn")
				$sfx_spawn.play()
	pass # Replace with function body.


func _on_area_hurtbox_body_entered(body):
	if body is Monster:
		if !dying:
			die()
	pass # Replace with function body.
