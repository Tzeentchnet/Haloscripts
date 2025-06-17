(script static void (monster_closet_door (ai spawned_squad)(device 
machine_door) (trigger_volume vol_name))
	(device_set_power machine_door 1)
	(sleep 5)
	(ai_place spawned_squad)
	(sleep 5)
	(device_set_position machine_door 1)
	(sleep 30)
	(sleep_until
			(and
				(not (volume_test_players vol_name))
				(not (volume_test_objects vol_name (ai_get_object 
				spawned_squad)))
			)
			5)
	(device_set_position machine_door 0)
	(sleep_until
		(begin
			(if (and
				(not (volume_test_players vol_name))
				(not (volume_test_objects vol_name (ai_get_object 
				spawned_squad)))
			 (= (device_get_position machine_door) 0))
			(device_set_power machine_door 0)		 
			)
		TRUE)
	1)

)


(script static void (tower_turrets (ai spawned_squad01) (ai 
spawned_squad02) (ai spawned_squad03) (object tower_name))
	(ai_place intro_turret_grunts)
	(sleep 5)
	
	(ai_vehicle_enter_immediate spawned_squad01 (object_get_turret 
	tower_name 0))
	(cs_run_command_script spawned_squad01 cs_stay_in_turret)

	(ai_vehicle_enter_immediate spawned_squad02 (object_get_turret 
	tower_name 1))
	(cs_run_command_script spawned_squad02 cs_stay_in_turret)
	
	(ai_vehicle_enter_immediate spawned_squad03 (object_get_turret 
	tower_name 2))
	(cs_run_command_script spawned_squad03 cs_stay_in_turret)
)

(script command_script cs_stay_in_turret
	(cs_shoot true)
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_abort_on_damage TRUE)	
	(cs_abort_on_alert FALSE)
	(sleep_forever)
)