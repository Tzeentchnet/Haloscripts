(global boolean SpawnGhost FALSE)		; Encounter has been activated?
(global short VarSpawner 0)
(global boolean ScarabBool TRUE)

(script startup mission
	(wake Start_Battle_limit)
	(wake Covenant_Reinforcements)
)

(script dormant Start_Battle_limit
	(print "FIGHT!")
	(ai_place Ghost01 3)
	(ai_place Ghost02 3)
	(ai_place Ghost03 3)
	(ai_place Ghost04 3)
	(ai_place Wraith01)
	(ai_place Wraith02)			
	(ai_place Wraith03)		
	(ai_place warthog01)
	(ai_place warthog02)
	(ai_place warthog04)
	(ai_place warthog03)
	(ai_place scorpion01 1)	
	(ai_place spectre01)
	(ai_place spectre02)
	(if ScarabBool
		(begin
			(ai_place scarab01)
			(ai_set_objective scarab01 scarab_objective)
		)
	)

	(ai_set_objective warthog01 marine_warthog)	
	(ai_set_objective warthog02 marine_warthog)
	(ai_set_objective warthog03 marine_warthog)	
	(ai_set_objective scorpion01 marine_warthog)
	(ai_set_objective Wraith01 covenant_vehicles)
	(ai_set_objective Wraith02 covenant_vehicles)
	(ai_set_objective Wraith03 covenant_vehicles)		
	(ai_set_objective spectre01 covenant_vehicles)
	(ai_set_objective spectre02 covenant_vehicles)	
	(ai_set_objective Ghost03 covenant_vehicles)
	(ai_set_objective Ghost04 covenant_vehicles)		
	(ai_set_objective Ghost02 covenant_vehicles)
	(ai_set_objective Ghost01 covenant_vehicles)
	
	(sleep_until (<= (ai_living_count Ghost_Initial) 0))
	
	(set SpawnGhost TRUE)
	(print "setting SpawnGhost to TRUE!")

)

(script dormant Covenant_Reinforcements
	(wake Phantom01Delivery)
	(wake Phantom02Delivery)
	(wake GhostSpawner)
	
	(wake Marine_Rein01)
)
;	(or (sleep_until (volume_test_objects_all fall_back_vol01 (players))))


(script dormant GhostSpawner
	(sleep_until (<= (ai_living_count Ghost_Initial ) 6))
		
	(sleep_until
		(begin
			(sleep 30)
					
			(if (and (= VarSpawner 1) (< (ai_living_count Total_Ghosts) 9))
				(begin		
					(ai_place Ghost06)
					(ai_set_objective Ghost06 covenant_vehicles)
				(print "SPAWNERMACHINE!!")
					
				)
			)
			(if (and (= VarSpawner 2) (< (ai_living_count Total_Ghosts) 9))
				(begin
					(ai_place Ghost07)
					(ai_set_objective Ghost07 covenant_vehicles)
				(print "SPAWNERMACHINE!!")
					
				)
			)
			(if (and (= VarSpawner 3) (< (ai_living_count Total_Ghosts) 9))
				(begin
					(ai_place Ghost08)
					(ai_set_objective Ghost08 covenant_vehicles)
					(set VarSpawner 0)
					(print "SPAWNERMACHINE!!")
					
				)
			)		
				(set VarSpawner (+ VarSpawner 1))
		(>= (ai_spawn_count Total_Ghosts) 40)
		)			
	)
)

(script dormant Phantom01Delivery
	(sleep_until (<= (ai_living_count Ghost_Initial ) 6))
	(print "send in Phantom 1")
	(ai_place Phantom01)
	(ai_place Ghost05 2)
	
	(vehicle_load_magic (ai_vehicle_get_from_starting_location Phantom01/pilot) "phantom_sc01" (ai_vehicle_get_from_starting_location Ghost05/vehicle01))
	(vehicle_load_magic (ai_vehicle_get_from_starting_location Phantom01/pilot) "phantom_sc02" (ai_vehicle_get_from_starting_location Ghost05/vehicle02))
	
	(cs_run_command_script Phantom01 Phantom01Path)
)
(script dormant Phantom02Delivery


	(sleep_until (< (ai_living_count Spectre_Initial ) 2))
	(print "send in Phantom 2")

	(ai_place Phantom02)
	(ai_place Specter03)
	
	(vehicle_load_magic (ai_vehicle_get_from_starting_location Phantom02/pilot) "phantom_lc" (ai_vehicle_get_from_starting_location specter03/vehicle01))
	
	(cs_run_command_script Phantom02 Phantom02Path)
)	

(script command_script Phantom01Path
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_by Phantom01PS/p1)
	(cs_fly_to Phantom01PS/p2)
	
	(wake Phantom01Drop)

	(sleep_until (< (ai_living_count Phantom01) 2) 30 900)

	(cs_vehicle_speed 0.3)

	
	(cs_fly_by Phantom01PS/p3)
	(cs_vehicle_boost TRUE)
	(cs_fly_to Phantom01PS/p4)
	(ai_erase Phantom01)
	
)

(script static boolean Mid_Field
	(NOT (volume_test_objects fall_back_vol01 (players)))
)

(script static boolean Back_Field
	(NOT (volume_test_objects fall_back_vol02 (players)))
)

(script static boolean Ghost_Front
	(AND 
		(AND (< (ai_body_count covenant_vehicles/ghost_front_r) 2) (< (ai_body_count covenant_vehicles/ghost_front_l) 2))
		(NOT (volume_test_objects fall_back_vol01 (players)))
	)
)

(script static boolean Ghost_Mid
	(AND 
		(AND (< (ai_body_count covenant_vehicles/ghost_mid_r) 3) (< (ai_body_count covenant_vehicles/ghost_mid_l) 3))
		(NOT (volume_test_objects fall_back_vol02 (players)))
	)
)

(script static boolean Warthog_Beg_Left
	(AND 
		(< (ai_body_count covenant_vehicles/ghost_front_r) 2)
		(NOT (volume_test_objects fall_back_vol01 (players)))
	)
)

(script static boolean Warthog_Beg_Right
	(AND 
		(< (ai_body_count covenant_vehicles/ghost_front_l) 2)
		(NOT (volume_test_objects fall_back_vol01 (players)))
	)
)

(script static boolean Warthog_Mid_Left
	(AND 
		(< (ai_body_count covenant_vehicles/ghost_mid_r) 3)
		(NOT (volume_test_objects fall_back_vol02 (players)))
	)
)

(script static boolean Warthog_Mid_Right
	(AND 
		(< (ai_body_count covenant_vehicles/ghost_mid_l) 3)
		(NOT (volume_test_objects fall_back_vol02 (players)))
	)
)

(script dormant Phantom01Drop
	(object_set_phantom_power (ai_vehicle_get_from_starting_location Phantom01/pilot) TRUE)
;	(vehicle_unload (ai_vehicle_get_from_starting_location Phantom01/pilot) "phantom_p_a01")
	(print "UNLOAD")
	(vehicle_unload (ai_vehicle_get_from_starting_location Phantom01/pilot) "phantom_sc01")
	(vehicle_unload (ai_vehicle_get_from_starting_location Phantom01/pilot) "phantom_sc02")
	(ai_set_objective Ghost05 covenant_vehicles)			
	(sleep 30)
	(object_set_phantom_power (ai_vehicle_get_from_starting_location Phantom01/pilot) FALSE)
	
)

(script command_script Phantom02Path
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_by Phantom02PS/p0)
	(cs_fly_to Phantom02PS/p1)
	
	(wake Phantom02Drop)

	(sleep_until (< (ai_living_count Phantom02) 2) 30 900)

	(cs_vehicle_speed 0.3)

	
	(cs_fly_to Phantom02PS/p2)
	(cs_vehicle_boost TRUE)
	(cs_fly_to Phantom02PS/p3)
	(ai_erase Phantom02)
	
)

(script dormant Phantom02Drop
	(object_set_phantom_power (ai_vehicle_get_from_starting_location Phantom02/pilot) TRUE)
	(vehicle_unload (ai_vehicle_get_from_starting_location Phantom02/pilot) "phantom_lc")
	(print "UNLOAD")
;	(vehicle_unload (ai_vehicle_get_from_starting_location Phantom01/pilot) "phantom_sc01")
;	(vehicle_unload (ai_vehicle_get_from_starting_location Phantom01/pilot) "phantom_sc02")
	(ai_set_objective Specter03 covenant_vehicles)			
	(sleep 30)
	(object_set_phantom_power (ai_vehicle_get_from_starting_location Phantom02/pilot) FALSE)
	
)

(script dormant Marine_Rein01
;	(sleep_until (<= (ai_living_count Warthog_Initial ) 2))
	(print "send in Pelican 1")
)
