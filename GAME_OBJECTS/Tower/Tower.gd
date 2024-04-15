@icon("res://Icons/pointy-hat.png")
class_name Tower extends StaticBody2D

@export var player:Player

@onready var Anim:AnimatedSprite2D = $AnimatedSprite2D
@export var AnimChargeBar:ChargeBar

var height = -172

var attacking = false

@export var close_delay := 2.23

@export var charge_speed := 23

func _ready():
	$AnimChargeSigil.visible = false

func attack():
	AnimChargeBar.add_charge(charge_speed)
	$TimerClose.start(close_delay)
	if !attacking:
		$AnimChargeSigil.visible = true
		$TimerFlash.stop()
		attacking = true
		$sfx_open.play()
		Anim.play("open")
	else:
		pass
	


func _on_animated_sprite_2d_animation_finished():
	if Anim.animation == "open":
		MusicHandler.set_EQ(3)
		Anim.play("attack")
		
	if Anim.animation == "close":
		AnimChargeBar.flash()
		$TimerFlash.start()
		$sfx_stop.play()
		MusicHandler.set_EQ(1)
		Anim.play("idle")
	pass # Replace with function body.


func _on_animated_sprite_2d_animation_looped():
	if Anim.animation == "attack":
	
		pass # Replace with function body.


func charge_up():
	if ElectronHandler.check_electrons_max():
		player.zap()
		ElectronHandler.update_electrons(1)
		AnimChargeBar.reset()
		if ElectronHandler.check_electrons_max():
			$sfx_charge.play()
		else:
			$sfx_fully_charged.play()


func _on_timer_close_timeout():
	$AnimChargeSigil.visible = false
	attacking = false
	$sfx_close.play()
	Anim.play("close")
	pass # Replace with function body.


func _on_increase_charge():
	charge_up()
	pass # Replace with function body.


func _on_timer_flash_timeout():
	AnimChargeBar.flash()
	pass # Replace with function body.
