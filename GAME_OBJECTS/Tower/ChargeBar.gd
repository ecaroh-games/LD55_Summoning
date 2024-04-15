class_name ChargeBar extends AnimatedSprite2D

var charge = 0.0
var max_charge = 100.0

@export var player:Player

signal increase_charge

var screenSize = Vector2(800, 450)
var border = 23

@onready var startPos:Vector2 = position

var flash_tween

func _process(delta):
	var screen_position = get_global_transform_with_canvas()
	var pos = screen_position.get_origin()
	
	var offset_correction := Vector2.ZERO
	
	if pos.x < border * 1.5:
		offset_correction.x = -pos.x + border * 1.5
	elif pos.x > screenSize.x - border * 1.5:
		offset_correction.x = -pos.x + screenSize.x - border * 1.5
		
	if pos.y < border:
		offset_correction.y = -pos.y + border
	elif pos.y > screenSize.y - border:
		offset_correction.y = -pos.y + screenSize.y - border
		
	offset = offset_correction
		
	
	


func add_charge(amt:float):
	if charge < max_charge:
		charge += amt
	if charge >= max_charge:
		play("charged")
	else:
		if animation != "charging":
			play("charging", 0.0)
		frame = floor(sprite_frames.get_frame_count("charging") * charge/max_charge)
	pass
	
func reset():
	charge = 0
	play("charging", 0.0)


func _on_animation_looped():
	if animation == "charged":
		increase_charge.emit()
	pass # Replace with function body.
	
func flash():
	if flash_tween:
		flash_tween.kill()
	flash_tween = create_tween()
	modulate = Color.RED * 4.23
	flash_tween.tween_property(self, "modulate", Color.WHITE, 0.23)
