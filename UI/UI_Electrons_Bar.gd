class_name ElectronBar extends Node2D

var current_electrons := 5
var max_electrons := 23

var per_row = 10
var spacing = 23

@onready var electron_ui_instance = preload("res://UI/UI_Electron.tscn")
@onready var Icons:Node2D = $Icons

var flash_tween

func _ready():
	position = Vector2(spacing, 450 - spacing)
	for i in max_electrons:
		var electron = electron_ui_instance.instantiate()
		var x = i % per_row
		var y = floor( i / per_row )
		electron.position = Vector2(x, -y) * spacing
		Icons.add_child(electron)
		
	var final_i := max_electrons
	$Label.position = Vector2(final_i % per_row, -floor( final_i / per_row )) * spacing + Vector2(-6, -12)
	
	update_electrons(0)

func update_electrons(change:int):
	if change > 0 and current_electrons < max_electrons:
		current_electrons += change
	elif change < 0 and current_electrons > 0:
		current_electrons += change
	
	if current_electrons == max_electrons:
		$Label.visible = true
	else:
		$Label.visible = false
		
	for i in max_electrons:
		if i < current_electrons:
			var current_icon = Icons.get_child(i)
			current_icon.show_frame(0)
			current_icon.modulate = Color.WHITE
			
		else:
			var current_icon = Icons.get_child(i)
			current_icon.show_frame(1)
			current_icon.modulate = Color.GRAY * 0.23
			
func flash():
	if flash_tween:
		flash_tween.kill()
	flash_tween = create_tween()
	modulate = Color.RED * 4.23
	flash_tween.tween_property(self, "modulate", Color.WHITE, 0.23)
