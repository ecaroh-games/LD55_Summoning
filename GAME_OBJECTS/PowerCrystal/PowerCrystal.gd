class_name PowerCrystal extends StaticBody2D

var powered = false
var charge = 0.5

var height = -95

var electron_instance = preload("res://GAME_OBJECTS/Boids/Electron.tscn")
var spark_instance = preload("res://GAME_OBJECTS/FX/Spark.tscn")

@onready var ElectronHolder = SummonBoids.get_holder()
@onready var tower:Tower = SummonBoids.get_tower()
@onready var FX = SummonBoids.get_fx()


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("unpowered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func power_up():
	TutorialTracker.crystals_charged += 1
	$sfx_charge.play()
	charge = 23
	powered = true
	$AnimatedSprite2D.play("powered")
	$AnimationPlayer.play("glow")
	$TimerCharge.start()
	charge_tower()

func charge_tower():
	var segments = 23
	var randomness = 2.3
	
	var d = tower.position - position
	var height_diff = tower.height - height
	
	#for i in segments:
		#var spark = spark_instance.instantiate() as Spark
		#spark.position = position + i * (d / segments) + Vector2.ONE * randf_range(-randomness, randomness)
		#spark.height = height + i * (height_diff / segments)
		#spark.set_life((float(i) / segments) * randf_range(0.23, 0.33))
		#FX.add_child(spark)
		
	tower.attack()
	
	pass


func _on_area_helper_body_entered(body):
	if body is Player:
		power_up()
	pass # Replace with function body.


func _on_timer_charge_timeout():
	var Area:Area2D = $AreaHelper as Area2D
	var overlap_bodies = Area.get_overlapping_bodies()
	var overlap_areas = Area.get_overlapping_areas()
	if overlap_bodies.size() > 0 or overlap_areas.size() > 0:
		power_up()
	else:
		powered = false
		charge = 2.3
		$AnimatedSprite2D.play("unpowered")
		$AnimationPlayer.play("idle")
	pass # Replace with function body.


func _on_area_helper_area_entered(area):
	if area.owner is Helper:
		var d = area.owner.position - position
		if d.length() < 69:
			area.owner.position = position + d.normalized() * 69
		power_up()
	
	pass # Replace with function body.
