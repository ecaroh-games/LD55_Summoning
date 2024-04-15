@icon("res://Icons/ecaroh_icon3.png")
class_name Player extends CharacterBody2D

const ACCEL:float = 23.0
const SPEED:float = 123.0

@export var BoidHolder:Node2D
@export var HelperHolder:Node2D
@export var Crystals:Node2D
@export var tower:Tower
@export var FX:Node2D

@export var charge = 6.9

var height = -33

var boid_instance = preload("res://GAME_OBJECTS/Boids/Electron.tscn")
var spark_instance = preload("res://GAME_OBJECTS/FX/Spark.tscn")
var electron_instance = preload("res://GAME_OBJECTS/Boids/Electron.tscn")
var deny_instance = preload("res://GAME_OBJECTS/Boids/Deny.tscn")
var helper_instance = preload("res://GAME_OBJECTS/Helper/Helper.tscn")

@onready var Anim:AnimatedSprite2D = $AnimatedSprite2D
@onready var ElectronHolder = SummonBoids.get_holder()

var max_helpers = 3

var hp = 23.0

signal player_died()
var died := false

func _ready():
	$PlusOne.visible = false
	pass

func _physics_process(delta):
	if died:
		return
		
	if Input.is_action_just_pressed("leftclick") and TutorialTracker.enabled_left_click:
		if ElectronHandler.check_electrons():
			ElectronHandler.update_electrons(-1)
			spawn_electron(-1)
			TutorialTracker.electrons_spawned += 1
		else:
			ElectronHandler.flash()
			$sfx_deny.play()
			spawn_deny()
	elif Input.is_action_just_pressed("rightclick") and TutorialTracker.enabled_right_click:
		spawn_helper()
	
	velocity = velocity.limit_length(SPEED * (1.0 + 0.33 * TutorialTracker.percent_complete()))
	move_and_slide()
	
func accel_ratio() -> float:
	return 2.3 + (velocity.length() / SPEED) * ACCEL 

func friction(delta):
	velocity = lerp(velocity, Vector2.ZERO, 1 - pow(0.1 / 23, delta))

func summon_boid():
	BoidHolder.a

func switch_anim(new_anim:String):
	Anim.play(new_anim)

func zap():
	$PlusOne.visible = true
	$PlusOne.modulate = Color.TRANSPARENT
	$PlusOne.scale = Vector2.ONE
	var tween = create_tween().set_parallel()
	tween.tween_property($PlusOne, "scale", Vector2.ZERO, 1.53).set_ease(Tween.EASE_IN)
	tween.tween_property($PlusOne, "modulate", Color.WHITE, 0.23)
	var segments = 23
	var randomness = 2.3
	
	var d = tower.position - position

	var height_diff = tower.height - height
	
	for i in segments:
		var spark = spark_instance.instantiate() as Spark
		spark.position = position + i * (d / segments) + Vector2.ONE * randf_range(-randomness, randomness)
		spark.height = height + i * (height_diff / segments)
		spark.set_life((1.0 - (float(i) / segments)) * randf_range(0.23, 0.33))
		FX.add_child(spark)
	
	pass
	
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

func spawn_electron(charge:int):
	var electron = electron_instance.instantiate()
	electron.charge = charge
	electron.position = get_global_mouse_position()
	ElectronHolder.add_child(electron)

func spawn_deny():
	var deny = deny_instance.instantiate()
	deny.position = get_global_mouse_position()
	FX.add_child(deny)

func spawn_helper():
	var helper:Helper = helper_instance.instantiate()
	helper.Crystals = Crystals
	helper.FX = FX
	helper.position = get_global_mouse_position()
	HelperHolder.add_child(helper)
	
	if HelperHolder.get_child_count() > max_helpers:
		for i in HelperHolder.get_child_count() - max_helpers:
			HelperHolder.get_child(i).despawn()

func _on_timer_timeout():
	#zap()
	pass # Replace with function body.


func _on_hurt_area_area_entered(area):
	if died:
		return
		
	var body = area.owner
	if body is Monster:
		hp -= 1.23
		if hp <= 0:
			player_died.emit()
			died = true
			visible = false
			DeathEffects.explode(position)
		body.cooldown()
		var d = body.position - position
		velocity -= d.normalized() * 123
		$sfx_hurt.play()
		$sfx_hurt2.play()
		var flash = $FlashFrames as FlashFrames
		flash.flash(0.5, 12, Color.RED * 2.3, Color.WHITE *0.8)
		pass # Replace with function body.
