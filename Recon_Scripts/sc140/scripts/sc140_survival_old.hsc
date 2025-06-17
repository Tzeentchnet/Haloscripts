;Global Variable for what survival round the player is on
(global short g_survival_round 1)
(global vehicle v_end_phantom_survival NONE)
(global vehicle v_end_phantom_survival02 NONE)
(global short g_skull 0)
(global short squad_placed 0)

(script static void launch_survival_mode
	(ins_survival)
	(wake start_survival)
)

(script dormant start_survival
	;placing survival mode objects
	(object_create_folder survival_mode_crates)
	(object_create_folder survival_mode_weapons)
	(object_destroy_folder campaign_weapons)
	(device_set_power sc140_door_02 1)
	(device_set_power sc140_door_04 1)
	(device_set_power sc140_door_05 1)
	(device_set_power sc140_door_07 1)
	(device_set_power sc140_door_08 0)
	(device_set_power sc140_door_14 0)
	(game_save)
	;(round_announce)
	(wake survival_mode_round)
	(wake respawn_safe_1)
	(wake respawn_safe_2)
	(wake respawn_safe_3)
	(wake respawn_safe_4)
	(sleep_forever)
)

(script dormant players_alive
	(sleep_until
		(AND
			(<= (unit_get_health (player0)) 0)
			(<= (unit_get_health (player1)) 0)
			(<= (unit_get_health (player2)) 0)
			(<= (unit_get_health (player3)) 0)
		)
	)
	(print "you died")
	(sleep 90)
	(game_won)
)

(script dormant players_alive_round8
	(sleep_until
		(OR
			(<= (unit_get_health (player0)) 0)
			(if (>= (game_coop_player_count) 2) (<= (unit_get_health (player1)) 0))
			(if (>= (game_coop_player_count) 3) (<= (unit_get_health (player2)) 0))
			(if (>= (game_coop_player_count) 4) (<= (unit_get_health (player3)) 0))
		)
	)
	(print "you died")
	(sleep 90)
	(game_won)
)
			

(script dormant survival_mode_round
	(sleep_until
		(begin
			(game_save)
			(cinematic_set_chud_objective begin_round)
				(round1_script)
				(sleep_until (= g_survival_round 2))
				(garbage_collect_now)
				(game_save)
			(cinematic_set_chud_objective wave_complete)
				(round2_script)
				(sleep_until (= g_survival_round 3))
				(garbage_collect_now)
				(game_save)
			(cinematic_set_chud_objective wave_complete)
				(round3_script)
				(sleep_until (= g_survival_round 4))
				(garbage_collect_now)
				(game_save)
			(cinematic_set_chud_objective wave_complete)	
				(round4_script)
				(sleep_until (= g_survival_round 5))
				(garbage_collect_now)
				(game_save)
			(cinematic_set_chud_objective wave_complete)	
				(round5_script)
				(sleep_until (= g_survival_round 6))
				(garbage_collect_now)
				(game_save)
			(cinematic_set_chud_objective round_complete)
			(sleep 120)
			(cond
				((= g_skull 0)
					(begin
						(skull_primary_enable skull_catch 1)
						(cinematic_set_chud_objective skull_catch)
						(wake players_alive)
					)
				)
				((= g_skull 1)
					(begin
						(skull_primary_enable skull_tough_luck 1)
						(skull_primary_enable skull_catch 0)
						(cinematic_set_chud_objective skull_tough)
					)
				)
				((= g_skull 2)
					(begin
						(skull_primary_enable skull_mythic 1)
						(skull_primary_enable skull_tough_luck 0)
						(cinematic_set_chud_objective skull_mythic)
					)
				)
				((= g_skull 3)
					(begin
						(skull_primary_enable skull_famine 1)
						(skull_primary_enable skull_mythic 0)
						(cinematic_set_chud_objective skull_famine)
					)
				)
				((= g_skull 4)
					(begin
						(skull_primary_enable skull_thunderstorm 1)
						(skull_primary_enable skull_famine 0)
						(cinematic_set_chud_objective skull_thunderstorm)
					)
				)
				((= g_skull 5)
					(begin
						(skull_primary_enable skull_tilt 1)
						(skull_primary_enable skull_thunderstorm 0)
						(cinematic_set_chud_objective skull_tilt)
					)
				)
				((= g_skull 6)
					(begin
						(skull_primary_enable skull_tough_luck 1)
						(skull_primary_enable skull_thunderstorm 1)
						(skull_primary_enable skull_tilt 0)
						(cinematic_set_chud_objective skull_tough_thunder)
					)
				)
				((= g_skull 7)
					(begin
						(skull_primary_enable skull_tough_luck 0)
						(skull_primary_enable skull_thunderstorm 0)
						(skull_primary_enable skull_mythic 1)
						(skull_primary_enable skull_catch 1)
						(cinematic_set_chud_objective skull_mythic_catch)
					)
				)
				((= g_skull 8)
					(begin
						(skull_primary_enable skull_iron 1)
						(cinematic_set_chud_objective skull_iron)
						(wake players_alive_round8)
					)
				)
			)
			(sleep 120)
			(set g_survival_round 1)
			(set g_skull (+ g_skull 1))
		FALSE)
	1)
)

(script static void round1_script
	(sleep_until (<= (unit_get_health survival_mode_phantom01) 0))
	(ai_place survival_mode_phantom01)
	(ai_cannot_die survival_mode_phantom01 true)
;	(ai_place round1)
	(set v_end_phantom_survival (ai_vehicle_get_from_starting_location survival_mode_phantom01/pilot))
	(ai_cannot_die survival_mode_phantom01/pilot true)
;	(ai_vehicle_enter_immediate round1 v_end_phantom_survival "phantom_p")
;	(unit_open v_end_phantom_survival)
	(cs_run_command_script survival_mode_phantom01/pilot cs_survival_phantom_round1)
	(sleep_until (= squad_placed 1))
	(sleep_until 
		(begin
			;(print "waiting for living count to go to 0")
			(AND
				(= (ai_living_count round1_grunt01) 0)
				(= (ai_living_count round1_grunt02) 0)
			)
		)
	)
	(set g_survival_round (+ g_survival_round 1))
	(set squad_placed 0)

)

(script static void round2_script
	(sleep_until (<= (unit_get_health survival_mode_phantom02) 0))
	(ai_place survival_mode_phantom02)
	(ai_cannot_die survival_mode_phantom02 true)
	(set v_end_phantom_survival02 (ai_vehicle_get_from_starting_location survival_mode_phantom02/pilot))
	(ai_cannot_die survival_mode_phantom02/pilot true)	
;	(unit_open v_end_phantom_survival02)
	(cs_run_command_script survival_mode_phantom02/pilot cs_survival_phantom_round2)
	(sleep_until (= squad_placed 1))
	(sleep_until 
		(begin
			;(print "waiting for living count to go to 0")
			(AND
				(= (ai_living_count round2_grunt01) 0)
				(= (ai_living_count round2_brute01) 0)
			)
		)
	)
	(set g_survival_round (+ g_survival_round 1))
	(set squad_placed 0)
)

(script static void round4_script
	(ai_place round4_brute01)
	(ai_place round4_brute02)
	(ai_place round4_brute03)
	(ai_place round4_brute04)
	(sleep_until 
		(begin
			;(print "waiting for living count to go to 0")
			(AND
				(= (ai_living_count round4_brute01) 0)
				(= (ai_living_count round4_brute02) 0)
				(= (ai_living_count round4_brute03) 0)
				(= (ai_living_count round4_brute04) 0)
			)
		)
	)
	(set g_survival_round (+ g_survival_round 1))
	(set squad_placed 0)
)

(script static void round3_script
	(sleep_until (<= (unit_get_health survival_mode_phantom01) 0))
	(sleep_until (<= (unit_get_health survival_mode_phantom02) 0))	
	(ai_place survival_mode_phantom01)
	(ai_cannot_die survival_mode_phantom01 true)
	(ai_place survival_mode_phantom02)
	(ai_cannot_die survival_mode_phantom02 true)
	(set v_end_phantom_survival (ai_vehicle_get_from_starting_location survival_mode_phantom01/pilot))
	(ai_cannot_die survival_mode_phantom01/pilot true)
	(set v_end_phantom_survival02 (ai_vehicle_get_from_starting_location survival_mode_phantom02/pilot))
	(ai_cannot_die survival_mode_phantom02/pilot true)
;	(unit_open v_end_phantom_survival)
;	(unit_open v_end_phantom_survival02)
	(cs_run_command_script survival_mode_phantom01/pilot cs_survival_phantom_round3a)
	(sleep 90)
	(cs_run_command_script survival_mode_phantom02/pilot cs_survival_phantom_round3b)
	(sleep_until (= squad_placed 2))
	(sleep_until 
		(begin
			;(print "waiting for living count to go to 0")
			(AND
				(= (ai_living_count round1_grunt01) 0)
				(= (ai_living_count round3_jackal01) 0)
				(= (ai_living_count round3_jackal02) 0)
				(= (ai_living_count round2_brute01) 0)
			)
		)
	)
	(set g_survival_round (+ g_survival_round 1))
	(set squad_placed 0)
)

(script static void round5_script
	(sleep_until (<= (unit_get_health survival_mode_phantom01) 0))
	(sleep_until (<= (unit_get_health survival_mode_phantom02) 0))	
	(ai_place survival_mode_phantom01)
	(ai_cannot_die survival_mode_phantom01 true)
	(ai_place survival_mode_phantom02)
	(ai_cannot_die survival_mode_phantom02 true)
	(set v_end_phantom_survival (ai_vehicle_get_from_starting_location survival_mode_phantom01/pilot))
	(ai_cannot_die survival_mode_phantom01/pilot true)
	(set v_end_phantom_survival02 (ai_vehicle_get_from_starting_location survival_mode_phantom02/pilot))
	(ai_cannot_die survival_mode_phantom02/pilot true)
;	(unit_open v_end_phantom_survival)
;	(unit_open v_end_phantom_survival02)
	(cs_run_command_script survival_mode_phantom01/pilot cs_survival_phantom_round5_1)
	(sleep 90)
	(cs_run_command_script survival_mode_phantom02/pilot cs_survival_phantom_round5_2)
	(sleep_until (= squad_placed 2))
	(sleep_until 
		(begin
			;(print "waiting for living count to go to 0")
			(AND
				(= (ai_living_count round5_hunter01) 0)
				(= (ai_living_count round5_hunter02) 0)
			)
		)
	)
	(set g_survival_round (+ g_survival_round 1))
	(set squad_placed 0)
)



;(script static void round_announce
;	(print g_survival_round)

;)


(script command_script cs_survival_phantom_round1
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_vehicle_boost FALSE)
	(cs_fly_to survival_phantom_path/p0 5)
	(cs_fly_by survival_phantom_path/p1 5)
	(cs_fly_by survival_phantom_path/p2 5)	
	(cs_vehicle_boost FALSE)
	(cs_vehicle_speed 1)

	(cs_fly_to_and_face survival_phantom_path/p3 survival_phantom_path/p6)

;	(vehicle_hover v_end_phantom03 TRUE)

	(ai_trickle_via_phantom survival_mode_phantom01/pilot round1_grunt01)
	(ai_trickle_via_phantom survival_mode_phantom01/pilot round1_grunt02)
	(set squad_placed (+ squad_placed 1))
	


	(cs_vehicle_speed 1)
	(cs_vehicle_boost FALSE)		
	(cs_fly_to survival_phantom_path/p4 2)	
	(cs_fly_to survival_phantom_path/p5 2)	
	(cs_vehicle_boost FALSE)
	(ai_erase survival_mode_phantom01)
	
)

(script command_script cs_survival_phantom_round2
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_vehicle_boost FALSE)
	(cs_fly_to survival_phantom_path/p0 5)
	(cs_fly_by survival_phantom_path/p1 5)
	(cs_fly_by survival_phantom_path/p2 5)	
	(cs_vehicle_boost FALSE)
	(cs_fly_by survival_phantom_path/p7 5)	
	(cs_vehicle_speed 1)	

	(cs_fly_to_and_face survival_phantom_path/p8 survival_phantom_path/p9)


	(ai_trickle_via_phantom survival_mode_phantom02/pilot round2_grunt01)
	(ai_trickle_via_phantom survival_mode_phantom02/pilot round2_brute01)
	(set squad_placed (+ squad_placed 1))
	
	(cs_vehicle_speed 1)
	(cs_vehicle_boost FALSE)		
	(cs_fly_to survival_phantom_path/p4 2)	
	(cs_fly_to survival_phantom_path/p5 2)	
	(cs_vehicle_boost FALSE)
	(ai_erase survival_mode_phantom02)
)

(script command_script cs_survival_phantom_round3a
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_vehicle_boost FALSE)
	(cs_fly_to survival_phantom_path/p0 5)
	(cs_fly_by survival_phantom_path/p1 5)
	(cs_fly_by survival_phantom_path/p2 5)	
	(cs_vehicle_boost FALSE)
	(cs_vehicle_speed 1)

	(cs_fly_to_and_face survival_phantom_path/p3 survival_phantom_path/p6)

;	(vehicle_hover v_end_phantom03 TRUE)

	(ai_trickle_via_phantom survival_mode_phantom01/pilot round1_grunt01)
	(ai_trickle_via_phantom survival_mode_phantom01/pilot round3_jackal01)
	(set squad_placed (+ squad_placed 1))
	


	(cs_vehicle_speed 1)
	(cs_vehicle_boost FALSE)		
	(cs_fly_to survival_phantom_path/p4 2)	
	(cs_fly_to survival_phantom_path/p5 2)	
	(cs_vehicle_boost FALSE)
	(ai_erase survival_mode_phantom01)
	
)


(script command_script cs_survival_phantom_round3b
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_vehicle_boost FALSE)
	(cs_fly_to survival_phantom_path/p0 5)
	(cs_fly_by survival_phantom_path/p1 5)
	(cs_fly_by survival_phantom_path/p2 5)	
	(cs_vehicle_boost FALSE)
	(cs_fly_by survival_phantom_path/p7 5)	
	(cs_vehicle_speed 1)	

	(cs_fly_to_and_face survival_phantom_path/p8 survival_phantom_path/p9)


	(ai_trickle_via_phantom survival_mode_phantom02/pilot round3_jackal02)
	(ai_trickle_via_phantom survival_mode_phantom02/pilot round2_brute01)
	(set squad_placed (+ squad_placed 1))
	
	(cs_vehicle_speed 1)
	(cs_vehicle_boost FALSE)		
	(cs_fly_to survival_phantom_path/p4 2)	
	(cs_fly_to survival_phantom_path/p5 2)	
	(cs_vehicle_boost FALSE)
	(ai_erase survival_mode_phantom02)
)

(script command_script cs_survival_phantom_round5_1
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_vehicle_boost FALSE)
	(cs_fly_to survival_phantom_path/p0 5)
	(cs_fly_by survival_phantom_path/p1 5)
	(cs_fly_by survival_phantom_path/p2 5)	
	(cs_vehicle_boost FALSE)
	(cs_vehicle_speed 1)

	(cs_fly_to_and_face survival_phantom_path/p3 survival_phantom_path/p6)

;	(vehicle_hover v_end_phantom03 TRUE)

	(ai_trickle_via_phantom survival_mode_phantom01/pilot round5_hunter01)
	(set squad_placed (+ squad_placed 1))

	(cs_vehicle_speed 1)
	(cs_vehicle_boost FALSE)		
	(cs_fly_to survival_phantom_path/p4 2)	
	(cs_fly_to survival_phantom_path/p5 2)	
	(cs_vehicle_boost FALSE)
	(ai_erase survival_mode_phantom01)
	
)

(script command_script cs_survival_phantom_round5_2
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_vehicle_boost FALSE)
	(cs_fly_to survival_phantom_path/p0 5)
	(cs_fly_by survival_phantom_path/p1 5)
	(cs_fly_by survival_phantom_path/p2 5)	
	(cs_vehicle_boost FALSE)
	(cs_fly_by survival_phantom_path/p7 5)	
	(cs_vehicle_speed 1)
	(cs_fly_to_and_face survival_phantom_path/p8 survival_phantom_path/p9)
	(ai_trickle_via_phantom survival_mode_phantom02/pilot round5_hunter02)
	(set squad_placed (+ squad_placed 1))
	(cs_vehicle_speed 1)
	(cs_vehicle_boost FALSE)		
	(cs_fly_to survival_phantom_path/p4 2)	
	(cs_fly_to survival_phantom_path/p5 2)	
	(cs_vehicle_boost FALSE)
	(ai_erase survival_mode_phantom02)
)


(script dormant respawn_safe_1
	(sleep_until
		(begin
			(sleep_until (<= (unit_get_health (player0)) 0))
			(sleep_until (> (unit_get_health (player0)) 0))
			(object_teleport (player0) survival_player0)
		FALSE)
	1)
)

(script dormant respawn_safe_2
	(sleep_until
		(begin
			(sleep_until (<= (unit_get_health (player1)) 0))
			(sleep_until (> (unit_get_health (player1)) 0))
			(object_teleport (player1) survival_player1)
		FALSE)
	1)
)

(script dormant respawn_safe_3
	(sleep_until
		(begin
			(sleep_until (<= (unit_get_health (player2)) 0))
			(sleep_until (> (unit_get_health (player2)) 0))
			(object_teleport (player2) survival_player2)
		FALSE)
	1)
)

(script dormant respawn_safe_4
	(sleep_until
		(begin
			(sleep_until (<= (unit_get_health (player3)) 0))
			(sleep_until (> (unit_get_health (player3)) 0))
			(object_teleport (player3) survival_player3)
		FALSE)
	1)
)
