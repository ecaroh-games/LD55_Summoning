@icon("res://Icons/elec_icon.png")
class_name Electron extends CharacterBody2D


const SPEED_START = 323.0
const SPEED_END = 23.0

var speed  = 123

var ang = randf_range(0, 360)

var power:float = 2.3
var charge:int

var height:float = 0.0
var fall_speed:float = 0.0
var grav:float = 2.3

@onready var Anim:AnimatedSprite2D = $AnimatedSprite2D

var golden:bool = false

var charge_time:float = 4.23


func _ready():
	velocity = Vector2.ONE.from_angle( deg_to_rad(ang) ) * speed
	
	# negative charge = uncharged
	if charge < 0:
		$sfx_summon.play()
		Anim.play("negative")
	else:
		$sfx_summon_charged.play()
		charge_up(false)
	Anim.offset.y = height
	$Timer.start(charge_time)

func physics_update(delta):
	
	if height < 0:
		fall_speed += grav
		height = minf(height + fall_speed * delta, 0.0)
		Anim.offset.y = height
		
	velocity = velocity.limit_length(666)
	#ang += randf_range(-23, 23)
	#speed = move_toward(speed, SPEED_END, delta * 323)
	#velocity = Vector2.ONE.from_angle( deg_to_rad(ang) ) * speed
	move_and_slide()
	
	friction(delta)

func friction(delta):
	velocity = lerp(velocity, Vector2.ZERO, 1 - pow(0.1 / 666, delta))

func _on_timer_timeout():
	#DeathEffects.explode(position)
	queue_free()
	pass # Replace with function body.

func charge_up(sound:bool = true):
	if golden:
		Anim.play("spawn")
	else:
		Anim.play("idle")
	if sound:
		$sfx_chargeup.play()
	charge = 1
	power = 23
	
	$Timer.start(charge_time)
	
	$AreaAttack.body_entered.connect(_on_area_attack_body_entered)
	check_nearby_electrons()
	
func check_nearby_electrons() -> void:
	var Area:Area2D = $AreaCharge as Area2D
	var overlaps = Area.get_overlapping_bodies()
	for body in overlaps as Array[Electron]:
		if body is Electron:
			if body.charge == -1:
				body.charge_up()
	
func _on_area_charge_body_entered(body):
	if body is Electron:
		if body.charge == 1 and charge != 1:
			charge_up()
	elif body is PowerCrystal:
		if body.powered and charge == -1:
			charge_up()
		#elif charge == 1 and !body.powered and golden:
			#body.power_up()
	pass # Replace with function body.


func _on_area_attack_body_entered(body):
	var Area:Area2D = $AreaAOE as Area2D
	var overlaps = Area.get_overlapping_bodies()
	for monster:Monster in overlaps:
		monster.die()
	DeathEffects.explode(position)
	queue_free()
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_finished():
	if Anim.animation == "spawn":
		Anim.play("idle")
	pass # Replace with function body.
