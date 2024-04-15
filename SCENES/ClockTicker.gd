class_name Music extends AudioStreamPlayer

# very muffled low with some drum
var setting1 = [
	22, 8.1, -58.5, -60, -60, -60
]

# a bit more drum
var setting2 = [
	7.2, 11.6, -8.1, -23, 2.3, 2.3
]

# drum only
var setting3 = [
	11.3, -29, -51, -54.3, -60, 12.4
]

# bass
var setting4 = [
	23, -23, -23, 0, 0, -23
]

#func _process(delta):
	#if Input.is_action_just_pressed("debug1"):
		#set_EQ(1)
		#pitch_scale = 0.666
		#set_pitch(0.444)
	#if Input.is_action_just_pressed("debug2"):
		#set_EQ(2)
		#pitch_scale = 0.555
		#set_pitch(1.23)
	#if Input.is_action_just_pressed("debug3"):
		#set_EQ(3)
		#pitch_scale = 0.777
		#set_pitch(2.666)
	#if Input.is_action_just_pressed("debug4"):
		#set_EQ(4)
		#pitch_scale = 0.888
		#set_pitch(0.420)

func _ready():
	set_EQ(1)
	pitch_scale = 0.666
	set_pitch(0.444)

func set_pitch(amt:float):
	var effect = AudioServer.get_bus_effect(1, 0)
	effect.pitch_scale = amt

func set_EQ(num:int):
	var setting_choice:Array
	match num:
		1: setting_choice = setting1
		2: setting_choice = setting2
		3: setting_choice = setting3
		4: setting_choice = setting4
		_: setting_choice = setting1
		
	# assuming that effect 0 on bus 1 is AudioEffectPanner
	var effect = AudioServer.get_bus_effect(1, 1)
	for i in setting_choice.size():
		effect.set_band_gain_db(i, setting_choice[i])
	
