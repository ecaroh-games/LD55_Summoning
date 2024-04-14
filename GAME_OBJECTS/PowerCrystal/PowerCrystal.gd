class_name PowerCrystal extends StaticBody2D

var powered = false
var charge = 23.0

var electron_instance = preload("res://GAME_OBJECTS/Boids/Electron.tscn")

@onready var ElectronHolder = SummonBoids.get_holder()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.play("unpowered")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func power_up():
	powered = true
	$AnimatedSprite2D.play("powered")
	$Timer.start()
	$ElectronTimer.start()
	#spawn_electron()

func _on_timer_timeout():
	$AnimatedSprite2D.play("unpowered")
	powered = false
	pass # Replace with function body.


func _on_electron_timer_timeout():
	if powered:
		#spawn_electron()
		$ElectronTimer.start()
	pass # Replace with function body.

func spawn_electron():
	var electron = electron_instance.instantiate()
	electron.position = position
	ElectronHolder.add_child(electron)
