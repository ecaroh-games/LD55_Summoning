class_name Helper extends StaticBody2D
@onready var Anim:AnimatedSprite2D = $AnimatedSprite2D
var spark_instance = preload("res://GAME_OBJECTS/FX/Spark.tscn")
var Crystals:Node2D
var FX:Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animated_sprite_2d_animation_finished():
	match Anim.animation:
		"spawn": Anim.play("idle")
		"death": queue_free()
	pass # Replace with function body.


func _on_area_2d_body_entered(body):
	
	pass # Replace with function body.

func despawn():
	Anim.play("death")


func _on_timer_timeout():
	Anim.play("raise")
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_looped():
	if Anim.animation == "raise":
		zap()
		var Area:Area2D = $AreaCharge as Area2D
		var overlaps = Area.get_overlapping_bodies()
		for electron:Electron in overlaps:
			if electron.charge == -1:
				electron.charge_up()
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
