class_name Player extends CharacterBody2D

const ACCEL:float = 23.0
const SPEED:float = 123.0

@export var BoidHolder:Node2D
@export var HelperHolder:Node2D
@export var Crystals:Node2D
@export var FX:Node2D

var boid_instance = preload("res://GAME_OBJECTS/Boids/Electron.tscn")
var spark_instance = preload("res://GAME_OBJECTS/FX/Spark.tscn")
var electron_instance = preload("res://GAME_OBJECTS/Boids/Electron.tscn")
var helper_instance = preload("res://GAME_OBJECTS/Helper/Helper.tscn")

@onready var Anim:AnimatedSprite2D = $AnimatedSprite2D
@onready var ElectronHolder = SummonBoids.get_holder()

var max_helpers = 1

func _physics_process(delta):
	
	if Input.is_action_just_pressed("leftclick"):
		spawn_electron(-1)
	elif Input.is_action_just_pressed("rightclick"):
		spawn_helper()
	
	velocity = velocity.limit_length(SPEED)
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
	
func spawn_helper():
	var helper:Helper = helper_instance.instantiate()
	helper.Crystals = Crystals
	helper.FX = FX
	helper.position = get_global_mouse_position()
	HelperHolder.add_child(helper)
	
	if HelperHolder.get_child_count() > max_helpers:
		for i in HelperHolder.get_child_count() - 1:
			HelperHolder.get_child(i).despawn()

func _on_timer_timeout():
	zap()
	pass # Replace with function body.
