extends Node2D

@export var player:Player
@export var MonsterHolder:Node2D

var summon_instance = preload("res://GAME_OBJECTS/Enemies/Monster.tscn")

var summon_count = 0



func _ready():
	stop_monsters()

func stop_monsters():
	kill_monsters()
	$AnimatedSprite2D.stop()
	$AnimatedSprite2D.visible = false
	
func kill_monsters():
	for child in MonsterHolder.get_children():
		child.die(false)

func start_monsters():
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.play()

func _on_animated_sprite_2d_animation_finished():
	summon()

func summon():
	$AnimatedSprite2D.speed_scale = 0.88 + 2.3 * (float(TutorialTracker.monsters_killed) / TutorialTracker.win_kills)
	$AudioStreamPlayer2D.play()
	var monster = summon_instance.instantiate()
	monster.position = position
	monster.target = player
	MonsterHolder.add_child(monster)
	
	if player.velocity != Vector2.ZERO:
		position = player.position + player.velocity.normalized() * randf_range(169, 269)
	else:
		position = player.position + Vector2.from_angle( deg_to_rad(randf_range(0, 360))) * randf_range(123, 222)
	pass
