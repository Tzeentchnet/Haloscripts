;====================================================================================================================================================================================================
;================================== GLOBAL VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
(global boolean editor FALSE)

(global boolean g_play_cinematics FALSE)
(global boolean g_player_training TRUE)

(global boolean debug TRUE)
(global boolean dialogue TRUE)
(global boolean music TRUE)

; insertion point index 
(global short g_insertion_index 0)

(global real g_nav_offset 0.55)

(global short g_intro_obj_control 0)
(global short g_cell01_obj_control 0)
(global short g_cell02_obj_control 0)
(global short g_cell03_obj_control 0)
(global short g_cell04_obj_control 0)
(global short g_cell05_obj_control 0)
(global short g_cell06_obj_control 0)
(global short g_cell07_obj_control 0)
(global short g_cell08_obj_control 0)
(global short g_cell09_obj_control 0)
(global short g_cell10_obj_control 0)
(global short g_cell11_obj_control 0)
(global short g_cell12_obj_control 0)
(global short g_cell13_obj_control 0)

(global vehicle v_end_phantom none)
 (global object obj_olifaunt none)

;====================================================================================================================================================================================================
;================================== GAME PROGRESSION VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
;*
these variables are defined in the .game_progression tag in \globals 


====== INTEGERS ======

g_scenario_location 

- set the scene transition integer equal to the scene number
- when transitioning from sc120 set g_scene_transition = 120 

====== BOOLEANS ======
g_l100_complete 

g_h100_complete 

g_sc100_complete 
g_sc110_complete 
g_sc120_complete 
g_sc130_complete 
g_sc140_complete 
g_sc150_complete 
g_sc160_complete 

g_l200_complete 

g_h200_complete 

g_sc200_complete 
g_sc210_complete 
g_sc220_complete 
g_sc230_complete 

g_l300_complete 

*;

;====================================================================================================================================================================================================
;====================================================================================================================================================================================================
;=============================== SCENE l300 MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================

(script startup l300_startup
	(if debug (print "l300 mission script") (print "NO DEBUG"))
	(ai_allegiance human player)
	(ai_allegiance player human)
	(wake ambient_overhead_cruiser01)
	(wake ambient_overhead_cruiser02)	
	(wake ambient_overhead_cruiser03)
	; fade out 
	(fade_out 0 0 0 0)

	;if survival_mode switch to appropriate scripts
	;*(if (campaign_survival_enabled)
		(begin 
			(launch_survival_mode)
			(sleep_forever)
		)
	)*;
	
		; === PLAYER IN WORLD TEST =====================================================
		(if	(and
				(not editor)
				(> (player_count) 0)
			)
			; if game is allowed to start 
			(start)
			
			(fade_in 0 0 0 0)
			
		)

	(if (not (game_is_cooperative))
		(begin
			(print "placing Starting AIs")
		)
	)
		
		; === PLAYER IN WORLD TEST =====================================================

			(sleep_until (>= g_insertion_index 1) 1)
			
			(if (= g_insertion_index 1) (wake enc_intro))

			(sleep_until	(or
							(volume_test_players 
							enc_cell01_vol)
							(>= g_insertion_index 2)
						)
			1)
			(if (<= g_insertion_index 2) (wake enc_cell01))
			(sleep_until	(or
							(volume_test_players 
							enc_cell02_vol)
							(>= g_insertion_index 3)
						)
			1)
			
			(if (<= g_insertion_index 3) (wake enc_cell02))	

			(sleep_until	(or
							(volume_test_players 
							enc_cell03_vol)
							(>= g_insertion_index 4)
						)
			1)
			
			(if (<= g_insertion_index 4) (wake enc_cell03))

			(sleep_until	(or
							(volume_test_players 
							enc_cell04_vol)
							(>= g_insertion_index 5)
						)
			1)
			
			(if (<= g_insertion_index 5) (wake enc_cell04))				

			(sleep_until	(or
							(volume_test_players 
							enc_cell05_vol)
							(>= g_insertion_index 6)
						)
			1)
			
			(if (<= g_insertion_index 6) (wake enc_cell05))	

			(sleep_until	(or
							(volume_test_players 
							enc_cell06_vol)
							(>= g_insertion_index 7)
						)
			1)
			
			(if (<= g_insertion_index 7) (wake enc_cell06))
			
			(sleep_until	(or
							(volume_test_players enc_cell07_vol)
							(>= g_insertion_index 8)
						)
			1)
			(if (<= g_insertion_index 8) (wake enc_cell07))
			
			(sleep_until	(or
							(volume_test_players enc_cell08_vol)
							(>= g_insertion_index 9)
						)
			1)

			(if (<= g_insertion_index 9) (wake enc_cell08))
			
			(sleep_until	(or
							(volume_test_players enc_cell09_vol)
							(>= g_insertion_index 10)
						)
			1)

			(if (<= g_insertion_index 10) (wake enc_cell09))
			(sleep_until	(or
							(volume_test_players enc_cell10_vol)
							(>= g_insertion_index 11)
						)
			1)

			(if (<= g_insertion_index 11) (wake enc_cell10))
			(sleep_until	(or
							(volume_test_players enc_cell11_vol)
							(>= g_insertion_index 12)
						)
			1)

			(if (<= g_insertion_index 12) (wake enc_cell11))
			(sleep_until	(or
							(volume_test_players enc_cell12_vol)
							(>= g_insertion_index 13)
						)
			1)

			(if (<= g_insertion_index 13) (wake enc_cell12))
			(sleep_until	(or
							(volume_test_players enc_cell13_vol)
							(>= g_insertion_index 14)
						)
			1)

			(if (<= g_insertion_index 14) (wake enc_cell13))
																
)

(script static void start
	(print "starting")

	; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						;fade to black
						(cinematic_snap_to_black)
						(if debug (print "sc100_in_sc"))	
							(sleep 60)	
						(cinematic_set_title title_1)
							(sleep 60)
						(cinematic_set_title title_2)
						(sleep (* 30 5))
						;(sc100_in_sc)
					)
				)
				(cinematic_skip_stop)
			)
		)
	(sleep 1)
	(cinematic_fade_to_gameplay)

	(ins_level_start)


)

(script static void highway_start
	(print "starting")

	; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						;fade to black
						(cinematic_snap_to_black)
						(if debug (print "sc100_highway_sc"))	
						(sleep (* 30 5))
						;(sc100_in_sc)
					)
				)
				(cinematic_skip_stop)
			)
		)
	(sleep 1)

	
	(object_create_folder crates_cell1)
	(ai_place troop_hog)
	(wake olifaunt_cell1_setup)	
	(cinematic_fade_to_gameplay)

)

(script dormant olifaunt_cell1_setup
	(ai_place olifaunt/cell01) (print "PLACING OLIFAUNT ONCE")
	(set v_olifaunt olifaunt/cell01)
	(set obj_olifaunt (ai_vehicle_get_from_starting_location 
	olifaunt/cell01))
	; this static script needed to be in a seperate dormant script so 
	; so it doesn't block anything.
	(olifaunt_timeout)
)

(script dormant enc_intro
	(print "enc_intro")
	(ai_place intro_chief)
	(ai_place intro_right_brutes)
	(ai_place intro_right_grunts)
	(ai_place intro_left_brutes)
	(ai_place intro_left_jackals)
	
	(wake intro_tower_turrets)
	(wake enc_intro_reinforcements)
	
	(sleep 1)
	(game_save)
	
	(sleep_until (volume_test_players intro_oc_10_vol)1)
	(set g_intro_obj_control 10)
	(print "g_intro_obj_control 10")

	(sleep_until (volume_test_players intro_oc_20_vol)1)
	(set g_intro_obj_control 20)
	(print "g_intro_obj_control 20")

	(sleep_until (volume_test_players intro_oc_30_vol)1)
	(set g_intro_obj_control 30)
	(print "g_intro_obj_control 30")

	(sleep_until (volume_test_players intro_oc_40_vol)1)
	(set g_intro_obj_control 40)
	(print "g_intro_obj_control 40")
	
	(sleep_until (volume_test_players intro_oc_50_vol)1)
	(set g_intro_obj_control 50)
	(print "g_intro_obj_control 50")

	(sleep_until (volume_test_players intro_oc_60_vol)1)
	(set g_intro_obj_control 60)
	(print "g_intro_obj_control 60")

	(sleep_until (volume_test_players intro_oc_70_vol)1)
	(set g_intro_obj_control 70)
	(print "g_intro_obj_control 70")

	(sleep_until (volume_test_players intro_oc_80_vol)1)
	(set g_intro_obj_control 80)
	(print "g_intro_obj_control 80")	

)

(script dormant enc_intro_reinforcements
	(sleep_until (or (< (ai_strength intro_gr) 0.75) 
	(volume_test_players enc_intro_01_vol)) 5)
	(ai_place intro_jetpack_gr)
)	

(script dormant intro_tower_turrets
	(ai_place intro_turret_grunts)
	(sleep 5)
	
	(ai_vehicle_enter_immediate intro_turret_grunts/0 (object_get_turret 
	cov_watch_tower_a 0))
	(cs_run_command_script intro_turret_grunts/0 cs_stay_in_turret)

	(ai_vehicle_enter_immediate intro_turret_grunts/1 (object_get_turret 
	cov_watch_tower_a 1))
	(cs_run_command_script intro_turret_grunts/1 cs_stay_in_turret)
	
	(ai_vehicle_enter_immediate intro_turret_grunts/2 (object_get_turret 
	cov_watch_tower_a 2))
	(cs_run_command_script intro_turret_grunts/2 cs_stay_in_turret)
)


(script command_script cs_stay_in_turret
	(cs_shoot true)
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_abort_on_damage TRUE)	
	(cs_abort_on_alert FALSE)
	(sleep_forever)
)

(script dormant enc_cell01
	; placing allies...		
	(highway_start)
	(sleep 1)
	(ai_place cell1_gr)
	(game_save)
	
	(cs_run_command_script v_olifaunt olifaunt_run01)
	(print "enc_cell01")
	(sleep_until (volume_test_players cell01_oc_10_vol)1)
	(set g_cell01_obj_control 10)
	(print "g_cell01_obj_control 10")

	(sleep_until (volume_test_players cell01_oc_20_vol)1)
	(set g_cell01_obj_control 20)
	(print "g_cell01_obj_control 20")

	(sleep_until (volume_test_players cell01_oc_30_vol)1)
	(set g_cell01_obj_control 30)
	(print "g_cell01_obj_control 30")

	(sleep_until (volume_test_players cell01_oc_40_vol)1)
	(set g_cell01_obj_control 40)
	(print "g_cell01_obj_control 40")
	
	(sleep_until (volume_test_players cell01_oc_50_vol)1)
	(set g_cell01_obj_control 50)
	(print "g_cell01_obj_control 50")

	(sleep_until (volume_test_players cell01_oc_60_vol)1)
	(set g_cell01_obj_control 60)
	(print "g_cell01_obj_control 60")
)

(script dormant enc_cell02
	(device_set_position highway_door_03 1)

	(object_create_folder crates_cell2)
	(ai_place cell2_gr)
	
	(sleep 1)
	(game_save)
	
	(sleep_until (= (device_get_position highway_door_03) 1)5)	
	(sleep 1)
	(cs_run_command_script v_olifaunt olifaunt_run02)
	(print "enc_cell02 hi")	
	(sleep_until (volume_test_players cell02_oc_10_vol)1)
	(set g_cell02_obj_control 10)
	(print "g_cell02_obj_control 10")

	(sleep_until (volume_test_players cell02_oc_20_vol)1)
	(set g_cell02_obj_control 20)
	(print "g_cell02_obj_control 20")

	(sleep_until (volume_test_players cell02_oc_30_vol)1)
	(set g_cell02_obj_control 30)
	(print "g_cell02_obj_control 30")

	(sleep_until (volume_test_players cell02_oc_40_vol)1)
	(set g_cell02_obj_control 40)
	(print "g_cell02_obj_control 40")
	
	(sleep_until (volume_test_players cell02_oc_50_vol)1)
	(set g_cell02_obj_control 50)
	(print "g_cell02_obj_control 50")
)
(script dormant enc_cell03
	(print "enc_cell03")

	(object_create_folder crates_cell3)
	
	(sleep_until (volume_test_players cell03_oc_10_vol)1)
	(set g_cell03_obj_control 10)
	(print "g_cell03_obj_control 10")

	(sleep_until (volume_test_players cell03_oc_20_vol)1)
	(set g_cell03_obj_control 20)
	(print "g_cell03_obj_control 20")

	(sleep_until (volume_test_players cell03_oc_30_vol)1)
	(set g_cell03_obj_control 30)
	(print "g_cell03_obj_control 30")

	(sleep_until (volume_test_players cell03_oc_40_vol)1)
	(set g_cell03_obj_control 40)
	(print "g_cell03_obj_control 40")
	
	(sleep_until (volume_test_players cell03_oc_50_vol)1)
	(set g_cell03_obj_control 50)
	(print "g_cell03_obj_control 50")

	(sleep_until (volume_test_players cell03_oc_60_vol)1)
	(set g_cell03_obj_control 60)
	(print "g_cell03_obj_control 60")		
)
(script dormant enc_cell04

	(object_create_folder crates_cell4)

	(sleep 1)
	(game_save)
	
	(print "enc_cell04")
	(sleep_until (volume_test_players cell04_oc_10_vol)1)
	(set g_cell04_obj_control 10)
	(print "g_cell04_obj_control 10")

	(sleep_until (volume_test_players cell04_oc_20_vol)1)
	(set g_cell04_obj_control 20)
	(print "g_cell04_obj_control 20")

	(sleep_until (volume_test_players cell04_oc_30_vol)1)
	(set g_cell04_obj_control 30)
	(print "g_cell04_obj_control 30")

	(sleep_until (volume_test_players cell04_oc_40_vol)1)
	(set g_cell04_obj_control 40)
	(print "g_cell04_obj_control 40")	
)
(script dormant enc_cell05

	(object_create_folder crates_cell5)

	(print "enc_cell05")
	(sleep_until (volume_test_players cell05_oc_10_vol)1)
	(set g_cell05_obj_control 10)
	(print "g_cell05_obj_control 10")

	(sleep_until (volume_test_players cell05_oc_20_vol)1)
	(set g_cell05_obj_control 20)
	(print "g_cell05_obj_control 20")

	(sleep_until (volume_test_players cell05_oc_30_vol)1)
	(set g_cell05_obj_control 30)
	(print "g_cell05_obj_control 30")

	(sleep_until (volume_test_players cell05_oc_40_vol)1)
	(set g_cell05_obj_control 40)
	(print "g_cell05_obj_control 40")		
)
(script dormant enc_cell06

	(object_create_folder crates_cell6)

	(print "enc_cell06")
	(sleep_until (volume_test_players cell06_oc_10_vol)1)
	(set g_cell06_obj_control 10)
	(print "g_cell06_obj_control 10")

	(sleep_until (volume_test_players cell06_oc_20_vol)1)
	(set g_cell06_obj_control 20)
	(print "g_cell06_obj_control 20")

	(sleep_until (volume_test_players cell06_oc_30_vol)1)
	(set g_cell06_obj_control 30)
	(print "g_cell06_obj_control 30")

	(sleep_until (volume_test_players cell06_oc_40_vol)1)
	(set g_cell06_obj_control 40)
	(print "g_cell06_obj_control 40")		
)
(script dormant enc_cell07

	(object_create_folder crates_cell7)

	(print "enc_cell07")
	(sleep_until (volume_test_players cell07_oc_10_vol)1)
	(set g_cell07_obj_control 10)
	(print "g_cell07_obj_control 10")

	(sleep_until (volume_test_players cell07_oc_20_vol)1)
	(set g_cell07_obj_control 20)
	(print "g_cell07_obj_control 20")

	(sleep_until (volume_test_players cell07_oc_30_vol)1)
	(set g_cell07_obj_control 30)
	(print "g_cell07_obj_control 30")

	(sleep_until (volume_test_players cell07_oc_40_vol)1)
	(set g_cell07_obj_control 40)
	(print "g_cell07_obj_control 40")		
)
(script dormant enc_cell08

	(object_create_folder crates_cell8)

	(print "enc_cell08")
	(sleep_until (volume_test_players cell08_oc_10_vol)1)
	(set g_cell08_obj_control 10)
	(print "g_cell08_obj_control 10")

	(sleep_until (volume_test_players cell08_oc_20_vol)1)
	(set g_cell08_obj_control 20)
	(print "g_cell08_obj_control 20")

	(sleep_until (volume_test_players cell08_oc_30_vol)1)
	(set g_cell08_obj_control 30)
	(print "g_cell08_obj_control 30")

	(sleep_until (volume_test_players cell08_oc_40_vol)1)
	(set g_cell08_obj_control 40)
	(print "g_cell08_obj_control 40")		
)
(script dormant enc_cell09
	(print "enc_cell09")

	(object_create_folder crates_cell9)
	
	(sleep_until (volume_test_players cell09_oc_10_vol)1)
	(set g_cell09_obj_control 10)
	(print "g_cell09_obj_control 10")

	(sleep_until (volume_test_players cell09_oc_20_vol)1)
	(set g_cell09_obj_control 20)
	(print "g_cell09_obj_control 20")

	(sleep_until (volume_test_players cell09_oc_30_vol)1)
	(set g_cell09_obj_control 30)
	(print "g_cell09_obj_control 30")

	(sleep_until (volume_test_players cell09_oc_40_vol)1)
	(set g_cell09_obj_control 40)
	(print "g_cell09_obj_control 40")
	
	(sleep_until (volume_test_players cell09_oc_50_vol)1)
	(set g_cell09_obj_control 50)
	(print "g_cell09_obj_control 50")	
)
(script dormant enc_cell10
	(print "enc_cell10")

	(object_create_folder crates_cell10)
	
	(sleep_until (volume_test_players cell10_oc_10_vol)1)
	(set g_cell10_obj_control 10)
	(print "g_cell10_obj_control 10")

	(sleep_until (volume_test_players cell10_oc_20_vol)1)
	(set g_cell10_obj_control 20)
	(print "g_cell10_obj_control 20")

	(sleep_until (volume_test_players cell10_oc_30_vol)1)
	(set g_cell10_obj_control 30)
	(print "g_cell10_obj_control 30")

	(sleep_until (volume_test_players cell10_oc_40_vol)1)
	(set g_cell10_obj_control 40)
	(print "g_cell10_obj_control 40")
	
	(sleep_until (volume_test_players cell10_oc_50_vol)1)
	(set g_cell10_obj_control 50)
	(print "g_cell10_obj_control 50")	
)
(script dormant enc_cell11
	(print "enc_cell11")

	(object_create_folder crates_cell11)
	
	(sleep_until (volume_test_players cell11_oc_10_vol)1)
	(set g_cell11_obj_control 10)
	(print "g_cell11_obj_control 10")

	(sleep_until (volume_test_players cell11_oc_20_vol)1)
	(set g_cell11_obj_control 20)
	(print "g_cell11_obj_control 20")

	(sleep_until (volume_test_players cell11_oc_30_vol)1)
	(set g_cell11_obj_control 30)
	(print "g_cell11_obj_control 30")	
)
(script dormant enc_cell12
	(print "enc_cell12")

	(object_create_folder crates_cell12)
	
	(sleep_until (volume_test_players cell12_oc_10_vol)1)
	(set g_cell12_obj_control 10)
	(print "g_cell12_obj_control 10")

	(sleep_until (volume_test_players cell12_oc_20_vol)1)
	(set g_cell12_obj_control 20)
	(print "g_cell12_obj_control 20")

	(sleep_until (volume_test_players cell12_oc_30_vol)1)
	(set g_cell12_obj_control 30)
	(print "g_cell12_obj_control 30")	
)
(script dormant enc_cell13
	(print "enc_cell13")

	(object_create_folder crates_cell13)
	
	(sleep_until (volume_test_players cell13_oc_10_vol)1)
	(set g_cell13_obj_control 10)
	(print "g_cell13_obj_control 10")

	(sleep_until (volume_test_players cell13_oc_20_vol)1)
	(set g_cell13_obj_control 20)
	(print "g_cell13_obj_control 20")

)

(script command_script olifaunt_run01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed .75)
	(object_set_phantom_power obj_olifaunt true)	
	(f_time_out 10 olifaunt01/p0)	
	(cs_go_by olifaunt01/p0 olifaunt01/p8 10)
	(f_time_out 20 olifaunt01/p1)	
	(cs_go_by olifaunt01/p1 olifaunt01/p8 10)
	(f_time_out 20 olifaunt01/p2)		
	(cs_go_by olifaunt01/p2 olifaunt01/p8 10)
	(f_time_out 20 olifaunt01/p3)			
	(cs_go_by olifaunt01/p3 olifaunt01/p8 10)
	(f_time_out 20 olifaunt01/p4)			
	(cs_go_by olifaunt01/p4 olifaunt01/p8 10)
	(f_time_out 30 olifaunt01/p5)			
	(cs_go_by olifaunt01/p5 olifaunt01/p8 10)
	(f_time_out 20 olifaunt01/p6)			
	(cs_go_by olifaunt01/p6 olifaunt01/p8 10)
	(f_time_out 20 olifaunt01/p7)			
	(cs_go_by olifaunt01/p7 olifaunt01/p8 10)
	(device_set_position highway_door_00 1)
	(f_time_out 30 olifaunt01/p8)			
	(cs_go_by olifaunt01/p8 olifaunt01/p9 10)
	(f_time_out_stop)			
)

(script command_script olifaunt_run02
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_vehicle_speed .75)
	(f_time_out 10 olifaunt02/p0)			
	(cs_go_by olifaunt02/p0 olifaunt02/p1 10)
	(f_time_out 20 olifaunt02/p1)		
	(cs_go_by olifaunt02/p1 olifaunt02/p2 10)
	(f_time_out 20 olifaunt02/p2)			
	(cs_go_by olifaunt02/p2 olifaunt02/p3 10)
	(f_time_out 20 olifaunt02/p3)			
	(cs_go_by olifaunt02/p3 olifaunt02/p4 10)
	(f_time_out 20 olifaunt02/p4)			
	(cs_go_by olifaunt02/p4 olifaunt02/p5 10)
	(f_time_out 20 olifaunt02/p5)			
	(cs_go_by olifaunt02/p5 olifaunt02/p6 10)
	(f_time_out 20 olifaunt02/p6)			
	(cs_go_by olifaunt02/p6 olifaunt02/p7 10)
	(f_time_out 20 olifaunt02/p7)			
	(cs_go_by olifaunt02/p7 olifaunt02/p8 10)
	(f_time_out 20 olifaunt02/p8)			
	(cs_go_by olifaunt02/p8 olifaunt02/p9 10)
	(f_time_out 20 olifaunt02/p9)								
	(cs_go_by olifaunt02/p9 olifaunt02/p10 10)					
	(f_time_out_stop)								
)
;*
(script command_script olifaunt_run03
	(cs_go_to olifaunt03/p0)
	(cs_go_to olifaunt03/p1)
	(cs_go_to olifaunt03/p2)
	(cs_go_to olifaunt03/p3)
	(cs_go_to olifaunt03/p4)
	(cs_go_to olifaunt03/p5)
	(cs_go_to olifaunt03/p6)
	(cs_go_to olifaunt03/p7)
	(cs_go_to olifaunt03/p8)
	(cs_go_to olifaunt03/p9)
	(cs_go_to olifaunt03/p10)
	(cs_go_to olifaunt03/p11)
	(cs_go_to olifaunt03/p12)
	(cs_go_to olifaunt03/p13)
	(cs_go_to olifaunt03/p14)
	(cs_go_to olifaunt03/p15)
	(cs_go_to olifaunt03/p16)
	(cs_go_to olifaunt03/p17)
	(cs_go_to olifaunt03/p18)
	(cs_go_to olifaunt03/p19)
	(cs_go_to olifaunt03/p20)
)
*;

(global short temp_timer 0)
(global short time_out 0)
(global point_reference previous_point olifaunt01/p0)

; The following script resets the countdown, sets a new maximum time 
; and sets a previous point reference
(script static void (f_time_out (short total_time) (point_reference 
current_point))
	(set temp_timer 0)
	(sleep 1)
	(set time_out total_time)
	(set previous_point current_point)
	
)
; The Olifaunt is coming to a stop, we need to stop the countdown!
(script static void f_time_out_stop
	(sleep_forever olifaunt_timeout)
	(set time_out 0)
	(set temp_timer 0)
)
; This is a timer. The timer limit is constantly changing via the time_out
; script. If the timer expires, it means that the olifaunt did NOT make
; it to it's destination. It will then check to see if the olifaunt 
; fell off the bridge and teleport it back to the previous point.
(script static void olifaunt_timeout
	(sleep_until
		(begin
			(sleep_until (> time_out 0)1)
			(sleep_until
				(begin
					(sleep 30)
					(print "RUNNING....")
					(set temp_timer (+ temp_timer 1))
				(= time_out temp_timer))
			1)
			(print "is the olifaunt in trouble?")		
				(if (volume_test_objects olifaunt_safe_vol obj_olifaunt)
					(begin
						(print "PUSH OLIFAUNT UP TO CURRENT POINT")
						(object_teleport_to_ai_point obj_olifaunt previous_point)
						(set temp_timer 0)				
					)
					(begin
						(print "TELEPORT OLIFAUNT TO PREVIOUS POINT")
						(object_teleport_to_ai_point obj_olifaunt previous_point)
						(set temp_timer 0)
					)		
				)
		)
	1)
)

(script command_script cs_end_phantom_path
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path/p0 5)
	(cs_fly_to end_phantom_path/p1 2)	
	(cs_vehicle_speed 0.4)
	
	(cs_fly_to_and_face end_phantom_path/p2 end_phantom_path/p3 1)
	(vehicle_hover v_end_phantom true)	
	(sleep 150)	
	(unit_open v_end_phantom)
)

(script static void end_phantom
	(ai_place end_phantom)
	(set v_end_phantom (ai_vehicle_get_from_starting_location end_phantom/pilot))
	
	(cs_run_command_script end_phantom/pilot cs_end_phantom_path)
)
(script static void test_all_doors_open
	(device_set_position_immediate highway_door_00 1)
	(device_set_position_immediate highway_door_01 1)
	(device_set_position_immediate highway_door_02 1)
	(device_set_position_immediate highway_door_03 1)
	(device_set_position_immediate highway_door_04 1)
	(device_set_position_immediate highway_door_05 1)
	(device_set_position_immediate highway_door_06 1)
	(device_set_position_immediate highway_door_07 1)
	(device_set_position_immediate highway_door_08 1)
	(device_set_position_immediate highway_door_09 1)
	(device_set_position_immediate highway_door_10 1)
	(device_set_position_immediate highway_door_11 1)
	(device_set_position_immediate highway_door_12 1)
	(device_set_position_immediate highway_door_13 1)
	(device_set_position_immediate highway_door_14 1)
	(device_set_position_immediate highway_door_15 1)
	(device_set_position_immediate highway_door_16 1)
	(device_set_position_immediate highway_door_17 1)
	(device_set_position_immediate highway_door_18 1)
	(device_set_position_immediate highway_door_19 1)
	(device_set_position_immediate highway_door_20 1)
	(device_set_position_immediate highway_door_21 1)
	(device_set_position_immediate highway_door_22 1)
	(device_set_position_immediate highway_door_23 1)
	(device_set_position_immediate highway_door_24 1)
	(device_set_position_immediate highway_door_25 1)
	(device_set_position_immediate highway_door_26 1)
	(device_set_position_immediate highway_door_27 1)
	(device_set_position_immediate highway_door_28 1)	
)

