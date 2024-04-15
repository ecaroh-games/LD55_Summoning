class_name ElectronGolden extends State_Electron

#func Enter():
	#if !charged:
		#charge_up()
	#else:
		#electron.switch_anim("spawn")
#
#func on_anim_finished() -> void:
	#if electron.Anim.animation == "spawn":
		#electron.switch_anim("gold")
	#pass
