class_name Electron extends CharacterBody2D


const SPEED_START = 323.0
const SPEED_END = 23.0

var speed  = 123

var ang = randf_range(0, 360)

var power:float = 2.3
var charge:int

func _ready():
	velocity = Vector2.ONE.from_angle( deg_to_rad(ang) ) * speed
	$AudioStreamPlayer.play()
	$Label.text = str( snapped(charge, 0.25))
	$Label2.text = str( snapped(velocity.length(), 0.25))
	if charge < 0:
		$AnimatedSprite2D.play("negative")

func physics_update(delta):
	velocity = velocity.limit_length(666)
	#ang += randf_range(-23, 23)
	#speed = move_toward(speed, SPEED_END, delta * 323)
	#velocity = Vector2.ONE.from_angle( deg_to_rad(ang) ) * speed
	move_and_slide()
	
	friction(delta)

func friction(delta):
	velocity = lerp(velocity, Vector2.ZERO, 1 - pow(0.1 / 666, delta))

func _on_timer_timeout():
	queue_free()
	pass # Replace with function body.

func charge_up():
	if charge != 1:
		$AudioStreamPlayer2D.play()
		charge = 1
		power = 23
		$AnimatedSprite2D.play("idle")
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
		if body.charge == 1:
			charge_up()
	elif body is PowerCrystal:
		if body.powered:
			charge_up()
	pass # Replace with function body.


func _on_area_attack_body_entered(body):
	var Area:Area2D = $AreaAttack as Area2D
	var overlaps = Area.get_overlapping_bodies()
	for monster:Monster in overlaps:
		monster.queue_free()
	DeathEffects.explode(position)
	queue_free()
	pass # Replace with function body.
