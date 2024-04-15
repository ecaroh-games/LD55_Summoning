extends Node2D

@export var PowerCrystals:Node2D
@export var player:Player

@export var multiplier:float = 1000
var k:float = 8.987551787

func _physics_process(delta):
	if get_child_count() > 32:
		get_child(0).queue_free()
	
	for e1 in get_children():
		if e1 is Electron:
			
			for e2 in get_children():
				if e2 is Electron and e1 != e2:
					coulombs_law(e1, e2)
					
			for crystal in PowerCrystals.get_children():
				attract_repel(e1, crystal)
				
			gravitate_to_player(e1)
					
	for e in get_children():
		if e is Electron:
			e.physics_update(delta)
		
func attract_repel(electron1:Electron, source:PowerCrystal):
	var m = 1
	if source.powered:
		m = -1
	var q1 = electron1.charge * electron1.power
	var q2 = source.charge * m
	var d = electron1.position - source.position
	var f = multiplier * k * ( (q1 * q2) / ( d.length() * d.length() ) )
	electron1.velocity -= f * d.normalized()
	
func gravitate_to_player(electron1:Electron):
	var m = 1
	var q1 = electron1.charge * electron1.power
	var q2 = player.charge
	var d = electron1.position - player.position
	var f = multiplier * k * ( (q1 * q2) / ( d.length() * d.length() ) )
	electron1.velocity -= f * d.normalized()

func coulombs_law(electron1:Electron, electron2:Electron) -> void:
	var q1 = electron1.charge * electron1.power
	var q2 = electron2.charge * electron2.power
	var d = electron1.position - electron2.position
	var f = multiplier * k * ( (q1 * q2) / ( d.length() * d.length() ) )
	electron1.velocity += f * d.normalized()
	electron2.velocity -= f * d.normalized()
		
