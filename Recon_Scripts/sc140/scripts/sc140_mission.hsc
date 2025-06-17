;====================================================================================================================================================================================================
;================================== GLOBAL VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
(global boolean editor FALSE)

(global boolean g_play_cinematics TRUE)
(global boolean g_player_training TRUE)

(global boolean debug TRUE)
(global boolean dialogue TRUE)
(global boolean music TRUE)

; insertion point index 
(global short g_insertion_index 0)

; objective control global shorts
(global short g_intro_obj_control 0)
(global short g_1a_obj_control 0)
(global short g_1b_obj_control 0)
(global short g_bridge_obj_control 0)
(global short g_2a_obj_control 0)
(global short g_2b_obj_control 0)
(global short g_wave_control 0)

; random variables
(global short wave04_rand_short 0)
(global short wave04_count_short 0)
(global short tempbanshee 0)
(global short banshee_rand_short 0)
(global short banshee_rand_wave 0)

(global short random_point_a 0)

; ai_group_counts
(global short v_1a_group_num 0)
(global short v_2a_group_num 0)
; starting player pitch 
(global short g_player_start_pitch -16)

(global boolean g_null FALSE)
(global boolean wave04_inf00_bool FALSE)
(global boolean wave04_inf01_bool FALSE)
(global boolean wave04_inf02_bool FALSE)
(global boolean wave04_inf03_bool FALSE)
(global boolean wave04_inf04_bool FALSE)
(global boolean wave04_inf05_bool FALSE)

(global real g_nav_offset 0.55)

(global vehicle v_cell_1b_phantom01 NONE)
(global vehicle v_end_phantom01 NONE)
(global vehicle v_end_phantom01_5 NONE)
(global vehicle v_end_phantom02 NONE)
(global vehicle v_end_phantom02_5 NONE)
(global vehicle v_end_phantom03 NONE)
(global vehicle v_end_phantom03_5 NONE)
(global vehicle v_end_phantom04 NONE)
(global vehicle v_end_phantom04_5 NONE)
(global vehicle v_end_phantom05 NONE)
(global vehicle v_end_phantom05_5 NONE)
(global vehicle v_end_phantom06 NONE)
(global vehicle v_1a_phantom01 NONE)
(global vehicle v_2a_phantom01 NONE)
(global vehicle v_ambient_air01 NONE)
(global vehicle v_ambient_air02 NONE)

(global object obj_buck none)


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
;=============================== SCENE 140 MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================
(script startup sc140_startup
	(if debug (print "sc140 mission script") (print "NO DEBUG"))
	(ai_allegiance human player)
	(ai_allegiance player human)
	; fade out 
	(fade_out 0 0 0 0)

	;if survival_mode switch to appropriate scripts
	(if (campaign_survival_enabled)
		(begin 
			(launch_survival_mode)
			(sleep_forever)
		)
	)
	; global variable for the hub
	(gp_integer_set gp_current_scene 140)
	(wake object_management)
	(wake save_game)
		; === PLAYER IN WORLD TEST =====================================================
		(if	(and
				(not editor)
				(> (player_count) 0)
			)
			; if game is allowed to start 
			(start)
			
			(fade_in 0 0 0 0)
			
		)
		
		; === PLAYER IN WORLD TEST =====================================================

			(sleep_until (>= g_insertion_index 1) 1)
		;==== begin cell_1_a (insertion 1) 
			
			(if (= g_insertion_index 1) (wake enc_intro))
			(sleep_until	(or
							(volume_test_players 
							enc_cell_1a_vol)
							(>= g_insertion_index 2)
						)
			1)
			
			(if (<= g_insertion_index 2) (wake enc_cell_1a))	

			(sleep_until	(or
							(volume_test_players 
							enc_cell_1b_vol)
							(>= g_insertion_index 3)
						)
			1)
			
			(if (<= g_insertion_index 3) (wake enc_cell_1b))

			(sleep_until	(or
							(volume_test_players 
							enc_cell_bridge_vol)
							(>= g_insertion_index 4)
						)
			1)
			
			(if (<= g_insertion_index 4) (wake enc_cell_bridge))				
		;==== begin cell_2_a (insertion 2) 

			(sleep_until	(or
							(volume_test_players 
							enc_cell_2a_vol)
							(>= g_insertion_index 5)
						)
			1)
			
			(if (<= g_insertion_index 5) (wake enc_cell_2a))	

			(sleep_until	(or
							(volume_test_players 
							enc_cell_2b_vol)
							(>= g_insertion_index 6)
						)
			1)
			
			(if (<= g_insertion_index 6) (wake enc_cell_2b))
			
			(sleep_until	(or
							(volume_test_players enc_banshee_a_vol)
							(>= g_insertion_index 7)
						)
			1)

			(if (<= g_insertion_index 7) (wake enc_banshee))
							
)

(script static void start
	
	(cond
		((= (game_insertion_point_get) 0) (ins_level_start))
		((= (game_insertion_point_get) 1) (ins_cell_1b))
		((= (game_insertion_point_get) 2) (ins_bridge))
		((= (game_insertion_point_get) 3) (ins_cell_2b))		
		((= (game_insertion_point_get) 4) (ins_banshee_fight))			
	)	
)

(script dormant enc_intro
	(print "starting")

	; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						;fade to black
						(cinematic_snap_to_black)
						(if debug (print "sc140_in_sc"))	
							(sleep 60)	
						(cinematic_set_title title_1)
							(sleep 60)
						(cinematic_set_title title_2)
						(sleep (* 30 5))
						(sc140_int_sc)
					)
				)
				(cinematic_skip_stop)
			)
		)
	(sleep 1)
	(flock_create banshee01_flock)
	(flock_create banshee02_flock)	
	(flock_start banshee01_flock)
	(flock_start banshee02_flock)		

	(print "placing BUCK01")
	(ai_place buck/actor01)
	(set obj_buck (ai_get_object buck/actor01))
	(ai_force_active buck/actor01 TRUE)	
		
	(cinematic_fade_to_gameplay)
		; place AI
		; wake global scripts 		
		; wake navigation point scripts 
		; wake mission dialogue scripts 
		(wake md_010_first_pad)
		; wake music scripts 

			(sleep_until (volume_test_players cell_intro_oc_01_vol) 1)
			(if debug (print "set objective control 1"))
			(set g_intro_obj_control 1)
		
			(sleep_until (volume_test_players cell_intro_oc_02_vol) 1)
			(if debug (print "set objective control 2"))
			(set g_intro_obj_control 2)

			(sleep_until (volume_test_players cell_intro_oc_03_vol) 1)
			(if debug (print "set objective control 2"))
			(set g_intro_obj_control 3)			
			(game_save)
			(sleep_forever md_010_first_pad_reminder)
)

(script dormant enc_cell_1a
	; place AI
	(ai_place 1a_squad01)
	(ai_place 1a_squad02)
	(ai_place 1a_turret01)	
	(ai_place 1a_phantom01)
	(set v_1a_phantom01 (ai_vehicle_get_from_starting_location 1a_phantom01/pilot))
	(ai_place 1a_squad03)
	(ai_place 1a_squad04)
	(ai_place 1a_squad05)		
	(wake ambient_air_cell1); this script is located in 140_ambient
	(ai_vehicle_enter_immediate 1a_squad03 v_1a_phantom01 "phantom_p_rb")
	(ai_vehicle_enter_immediate 1a_squad04 v_1a_phantom01 "phantom_p_rf")
	(ai_vehicle_enter_immediate 1a_squad05 v_1a_phantom01 "phantom_p_rb")		
	
	(wake enc_cell_1a_reinf)
	; wake global scripts 		
	; wake navigation point scripts 
	; wake mission dialogue scripts
	(wake md_020_cell_1a)
	; wake music scripts 
	
	(sleep_until (volume_test_players cell_1a_oc_01_vol) 1)
	(if debug (print "set objective control 1"))
	(set g_1a_obj_control 1)

	(sleep_until (volume_test_players cell_1a_oc_02_vol) 1)
	(if debug (print "set objective control 2"))
	(set g_1a_obj_control 2)

	(sleep_until (volume_test_players cell_1a_oc_03_vol) 1)
	(if debug (print "set objective control 3"))
	(set g_1a_obj_control 3)

	(sleep_until (volume_test_players cell_1a_oc_04_vol) 1)
	(if debug (print "set objective control 4"))
	(set g_1a_obj_control 4)
	(ai_set_objective buck marine01b_obj)	
	(sleep_forever md_020_cell_1a)
	(sleep_forever md_020_cell_1a_turret)	
)

(script dormant enc_cell_1a_reinf
	(set v_1a_group_num (- (ai_living_count 
	cell1a_group)(ai_living_count cell1a_group_reinf)))

	(sleep_until 
		(or
			(< (ai_living_count cell1a_group) (* v_1a_group_num 0.5))
			(= g_1a_obj_control 2)
		)5)
	(sleep_forever md_020_cell_1a_turret)			
	(cs_run_command_script 1a_phantom01/pilot cs_1a_phantom_path_a)

)

(script dormant enc_cell_1b
	; place AI
		
;	(ai_place 1b_turret01)
;	(ai_place 1b_turret02)
;	(ai_place 1b_turret03)
	(ai_place 1b_phantom)
	(ai_place 1b_squad04)
	(ai_place 1b_squad05)
	(wake enc_cell_1b_reinf)
	(ai_place 1b_squad02)
	(set v_cell_1b_phantom01 (ai_vehicle_get_from_starting_location 1b_phantom/pilot))
	(cs_run_command_script 1b_phantom/pilot cs_1b_phantom_path_a)		
	
	; wake global scripts 		
	; wake navigation point scripts 
	; wake mission dialogue scripts 
	(wake md_030_cell_1b)
	; wake music scripts 
	
	(sleep_until (volume_test_players cell_1b_oc_01_vol) 1)
	(if debug (print "set objective control 1"))
	(set g_1b_obj_control 1)
	(game_insertion_point_unlock 1)

	(ai_bring_forward obj_buck 20)
	
	(sleep_until (volume_test_players cell_1b_oc_02_vol) 1)
	(if debug (print "set objective control 2"))
	(set g_1b_obj_control 2)
	
	(sleep_until (volume_test_players cell_1b_oc_03_vol) 1)
	(if debug (print "set objective control 3"))
	(set g_1b_obj_control 3)		
)

(script dormant enc_cell_1b_reinf
	(sleep_until (volume_test_players enc_cell_1b_vol02) 5)
	(ai_place 1b_squad03)	
)

(script dormant enc_cell_bridge
		; place allies
		; wake global scripts 		
		; wake navigation point scripts 
		; wake mission dialogue scripts
		(wake md_040_cell_lobby)
		; wake music scripts
	(game_insertion_point_unlock 2)

	(sleep_until (volume_test_players cell_bridge_oc_01_vol) 1)
	(if debug (print "set objective control 1"))
	(set g_bridge_obj_control 1)
	(sleep 1)

	(ai_bring_forward obj_buck 20)
	
;	(object_teleport obj_buck buck_teleport)
	(ai_set_objective buck marinelobby_obj)
	(game_save)


	(sleep_until (volume_test_players cell_bridge_oc_02_vol) 1)
	(if debug (print "set objective control 2"))
	(set g_bridge_obj_control 2)
)
(script dormant enc_cell_2a
	; place AI
	(ai_place 2a_turret01)		
	(ai_place 2a_squad01)		
	(ai_place 2a_squad03)
;	(ai_place 2a_squad02)			
	(ai_place 2a_phantom01)
	(wake enc_cell_2a_reinf)
	(set v_2a_phantom01 (ai_vehicle_get_from_starting_location 
	2a_phantom01/pilot))
	(ai_set_objective buck marine02a_obj)
	
	(vehicle_hover 2a_phantom01 TRUE)
	(game_save)
		
	; wake global scripts 		
	; wake navigation point scripts 
	; wake mission dialogue scripts 
	(sleep_forever md_040_cell_lobby)
	(wake md_050_cell_2a)
	(wake md_050_cell_2a_post)
	; wake music scripts 
	
	(sleep_until (volume_test_players cell_2a_oc_01_vol) 1)
	(if debug (print "set objective control 1"))
	(set g_2a_obj_control 1)
	(ai_bring_forward obj_buck 20)

	(sleep_until (volume_test_players cell_2a_oc_02_vol) 1)
	(if debug (print "set objective control 2"))
	(set g_2a_obj_control 2)
	
	(sleep_until (volume_test_players cell_2a_oc_03_vol) 1)
	(if debug (print "set objective control 3"))
	(set g_2a_obj_control 3)

	(sleep_until (volume_test_players cell_2a_oc_04_vol) 1)
	(if debug (print "set objective control 4"))
	(set g_2a_obj_control 4)
	(ai_set_objective buck marine02b_obj)

)
(script dormant enc_cell_2a_reinf
	(set v_2a_group_num (ai_living_count cell2a_jackals))

	(sleep_until 
		(or
			(< (ai_living_count cell2a_jackals) (* v_2a_group_num 0.6))
			(= g_2a_obj_control 1)
		)5)
	(ai_trickle_via_phantom 2a_phantom01/pilot 2a_squad06)
	(ai_set_objective 2a_squad06 cell_2a_obj)
	(sleep_until 
		(or 
			(< (ai_living_count 2a_squad06) 3)
			(>= g_2a_obj_control 2)
		)5)
	(ai_trickle_via_phantom 2a_phantom01/pilot 2a_squad07)
	(ai_set_objective 2a_squad07 cell_2a_obj)
	(sleep 120)
	(vehicle_hover 2a_phantom01 FALSE)	
	(cs_run_command_script 2a_phantom01/pilot cs_2a_phantom_path_a)
)


(script dormant enc_cell_2b
		; place AI

;		(ai_place 2b_turret01)
		
		; wake global scripts 		
		; wake navigation point scripts 
		; wake mission dialogue scripts 
		(wake md_060_cell_2b)
		(wake md_050_cell_2b_post)

		; wake music scripts 
	(sleep_until (volume_test_players cell_2b_oc_01_vol) 1)
		(ai_place 2b_hunter01)
		(ai_place 2b_hunter02)
	(ai_bring_forward obj_buck 20)
	(game_insertion_point_unlock 3)
			
	(if debug (print "set objective control 1"))
	(set g_2b_obj_control 1)
	(game_save)
	(sleep_until (volume_test_players cell_2b_oc_02_vol) 1)
	(if debug (print "set objective control 2"))
	(set g_2b_obj_control 2)	

	(sleep_until (volume_test_players cell_2b_oc_03_vol) 1)
	(if debug (print "set objective control 3"))
	(set g_2b_obj_control 3)

	(sleep_until (volume_test_players cell_2b_oc_04_vol) 1)
	(if debug (print "set objective control 4"))
	(set g_2b_obj_control 4)

	(sleep_until (volume_test_players cell_2b_oc_05_vol) 1)
	(if debug (print "set objective control 5"))
	(set g_2b_obj_control 5)
	(ai_bring_forward obj_buck 10)


	(sleep_until (volume_test_players cell_2b_oc_06_vol) 1)
	(if debug (print "set objective control 6"))
	(set g_2b_obj_control 6)				
)

(script dormant enc_banshee
		; place AI

	(ai_place Missile00)
	(ai_place Missile01)
	(ai_place Missile02)
	(ai_place Missile03)
	(ai_place Chain_Gun01)
	(ai_place Chain_Gun02)

	(wake md_070_cell_banshee_platform)
	(wake md_070_cell_banshee_plat_end)
		
	; wake global scripts 		
	; wake navigation point scripts 
	; wake mission dialogue scripts 
	(wake md_080_cell_construction_site) 	; end_phantom_battle is called here
	(game_insertion_point_unlock 4)
	
	(flock_stop banshee01_flock)
	(flock_stop banshee02_flock)		
	(flock_delete banshee01_flock)
	(flock_delete banshee02_flock)	
	
	(wake banshee_flyby)
	(sleep_until (volume_test_players enc_crane_vol)5)
;	(ai_set_objective buck marine_banshee_obj)
	(ai_bring_forward obj_buck 20)	
	(f_banshee_spawns 3)
	(sleep_until (script_finished md_080_cell_construction_site)5)
	(wake end_phantom_battle)

)

(script static void (f_banshee_spawns (short gNumber))
	(set tempbanshee 0)
		(sleep_until
			(begin
				(set banshee_rand_short (random_range 0 6))				
				(cond
					((and 
					(= banshee_rand_short 0)
					(< (ai_living_count banshee01) 1) 
					(< tempbanshee gNumber))
						(begin
							(sleep 90)
							(ai_place banshee01)
							(set tempbanshee (+ tempbanshee 1))										
						)
					)
					((and 
					(= banshee_rand_short 1)
					(< (ai_living_count banshee02) 1) 
					(< tempbanshee gNumber))
						(begin
							(sleep 90)
							(ai_place banshee02)
							(set tempbanshee (+ tempbanshee 1))										
						)
					)
					((and 
					(= banshee_rand_short 2)
					(< (ai_living_count banshee03) 1) 
					(< tempbanshee gNumber))
						(begin
							(sleep 90)
							(ai_place banshee03)
							(set tempbanshee (+ tempbanshee 1))										
						)
					)
					((and 
					(= banshee_rand_short 3)
					(< (ai_living_count banshee04) 1) 
					(< tempbanshee gNumber))
						(begin
							(sleep 90)
							(ai_place banshee04)
							(set tempbanshee (+ tempbanshee 1))										
						)
					)
					((and 
					(= banshee_rand_short 4)
					(< (ai_living_count banshee05) 1) 
					(< tempbanshee gNumber))
						(begin
							(sleep 90)
							(ai_place banshee05)
							(set tempbanshee (+ tempbanshee 1))										
						)
					)
					((and 
					(= banshee_rand_short 5)
					(< (ai_living_count banshee06) 1) 
					(< tempbanshee gNumber))
						(begin
							(sleep 90)
							(ai_place banshee06)
							(set tempbanshee (+ tempbanshee 1))										
						)
					)										
			)
		(>= tempbanshee gNumber))
	)
	(print "exited script")
)

(global boolean wave_left FALSE)
(global boolean wave_right FALSE)
(global boolean wave_center FALSE)


(script dormant end_phantom_battle
	(game_save)
; wave 1 pick a random direction and spawn in enemies
	(set g_wave_control 1)
	(set banshee_rand_wave (random_range 0 3))			
	(cond
		((and (= banshee_rand_wave 0) (= wave_left FALSE))
			(begin
				(print "THEY ARE COMING FROM THE LEFT SIDE!!")
				(set wave_left TRUE)
				(ai_place banshee03 2)
				(ai_place banshee05 2)
				(ai_place end_phantom01)
				(set v_end_phantom01 (ai_vehicle_get_from_starting_location end_phantom01/pilot))
				(cs_run_command_script end_phantom01/pilot 
				cs_end_phantom_path_a)
				(sleep_until (= (ai_living_count end_phantom01) 0))
				
			)
		)
		((and (= banshee_rand_wave 1) (= wave_center FALSE))
			(begin
				(print "THEY ARE COMING FROM THE CENTER!!")			
				(set wave_center TRUE)
				(ai_place banshee02 2)
				(ai_place banshee06 2)
				(ai_place end_phantom05)
				(set v_end_phantom05 (ai_vehicle_get_from_starting_location end_phantom05/pilot))
				(cs_run_command_script end_phantom05/pilot cs_end_phantom_path_e)
				(sleep_until (= (ai_living_count end_phantom05) 0))
												
			)
		)
		((and (= banshee_rand_wave 2) (= wave_right FALSE))
			(begin
				(print "THEY ARE COMING FROM THE RIGHT SIDE!!")			
				(set wave_right TRUE)
				(ai_place banshee01 2)
				(ai_place banshee04 2)
				(ai_place end_phantom03)
				(set v_end_phantom03 
				(ai_vehicle_get_from_starting_location end_phantom03/pilot))
				(cs_run_command_script end_phantom03/pilot 
				cs_end_phantom_path_c)			
				(sleep_until (= (ai_living_count end_phantom03) 0))

			)
		)				
	)

; wave 2
	(if (> (ai_living_count banshee_groups) 4) (sleep 300))
	(game_save)
	(if (> (ai_living_count banshee_groups) 2) (sleep 300))
	(set g_wave_control 2)			
	(ai_place end_phantom02)
	(ai_place end_phantom02_5)
	
	(set v_end_phantom02 (ai_vehicle_get_from_starting_location end_phantom02/pilot))
	(set v_end_phantom02_5 (ai_vehicle_get_from_starting_location end_phantom02_5/pilot))
	
	(ai_place Wave02_Infantry01)
	(ai_place Wave02_Infantry02)
	(ai_place Wave02_Infantry03)
	(ai_place Wave02_Infantry04)	
	(ai_vehicle_enter_immediate Wave02_Infantry01 v_end_phantom02 "phantom_p_lb")
	(ai_vehicle_enter_immediate Wave02_Infantry02 v_end_phantom02 "phantom_p_lf")
	(ai_vehicle_enter_immediate Wave02_Infantry03 v_end_phantom02_5 "phantom_p_lb")
	(ai_vehicle_enter_immediate Wave02_Infantry04 v_end_phantom02_5 "phantom_p_ml_b")		
	
	(cs_run_command_script end_phantom02/pilot cs_end_phantom_path_b)
	(cs_run_command_script end_phantom02_5/pilot cs_end_phantom_path_b_2)	
	(f_banshee_spawns 2); add more banshees squads
	
	(sleep_until (and 
				(= (ai_living_count end_phantom02) 0)
				(= (ai_living_count end_phantom02_5) 0)
				(< (ai_living_count Wave02_Infantry_Group) 3)
				)
	)
; wave 3
	(set g_wave_control 3)
	(print "WAVE 3")
	(game_save)
	(sleep_until
		(begin	
			(set banshee_rand_wave (random_range 0 3))				
			(cond
				((and (= banshee_rand_wave 0) (= wave_left FALSE))
					(begin
						(print "THEY ARE COMING FROM THE LEFT SIDE!!")
						(set wave_left TRUE)
						(ai_place banshee03 2)
						(ai_place banshee05 2)				
						(ai_place end_phantom01)
						(set v_end_phantom01 (ai_vehicle_get_from_starting_location end_phantom01/pilot))
						(cs_run_command_script end_phantom01/pilot 
						cs_end_phantom_path_a)
						(f_banshee_spawns 6); add more banshees squads					
						(sleep_until (= (ai_living_count end_phantom01) 0))
						
					)
				)
				((and (= banshee_rand_wave 1) (= wave_center FALSE))
					(begin
						(print "THEY ARE COMING FROM THE CENTER!!")			
						(set wave_center TRUE)
						(ai_place banshee02 2)
						(ai_place banshee06 2)
						(ai_place end_phantom05)
						(set v_end_phantom05 (ai_vehicle_get_from_starting_location end_phantom05/pilot))
						(cs_run_command_script end_phantom05/pilot cs_end_phantom_path_e)
						(f_banshee_spawns 6); add more banshees squads					
						(sleep_until (= (ai_living_count end_phantom05) 0))
														
					)
				)
				((and (= banshee_rand_wave 2) (= wave_right FALSE))
					(begin
						(print "THEY ARE COMING FROM THE RIGHT SIDE!!")			
						(set wave_right TRUE)
						(ai_place banshee01 2)
						(ai_place banshee04 2)
						(ai_place end_phantom03)
						(set v_end_phantom05 
						(ai_vehicle_get_from_starting_location end_phantom03/pilot))
						(cs_run_command_script end_phantom03/pilot 
						cs_end_phantom_path_c)
						(f_banshee_spawns 4); add more banshees squads					
						(sleep_until (= (ai_living_count end_phantom03) 0))
					)
				)
			)
		TRUE)
	)
	(if (> (ai_living_count banshee_groups) 4) (sleep 600))
	(game_save)
	(if (> (ai_living_count banshee_groups) 2) (sleep 300))
	(game_save)	
; wave 4
	(set g_wave_control 4)
	(game_save)
	(begin_random
		(begin
			(ai_place end_phantom04)
			(set v_end_phantom04 (ai_vehicle_get_from_starting_location 
			end_phantom04/pilot))
			(cs_run_command_script end_phantom04/pilot cs_end_phantom_path_d)
			(sleep_until (= (ai_living_count end_phantom04) 0))		
		)
		(begin
			(ai_place end_phantom04_5)
			(set v_end_phantom04_5 (ai_vehicle_get_from_starting_location 
			end_phantom04_5/pilot))
			
			(cs_run_command_script end_phantom04_5/pilot 
			cs_end_phantom_path_d_2)
			(sleep_until (= (ai_living_count end_phantom04_5) 0))			
		)
	)
	(f_banshee_spawns 4); add more banshees squads

	(sleep_until (and (= (ai_living_count end_phantom04) 0)(= 
	(ai_living_count end_phantom04_5) 0)))
	(sleep_until (< (ai_living_count Wave04_Infantry_Group) 1)5 1200)
	(game_save)		
; wave 5
	(set g_wave_control 5)
	(sleep_until				
		(begin
			(set banshee_rand_wave (random_range 0 3))
				(cond
					((and (= banshee_rand_wave 0) (= wave_left FALSE))
						(begin
							(print "THEY ARE COMING FROM THE LEFT SIDE!!")
							(set wave_left TRUE)
							(ai_place banshee03 2)
							(ai_place banshee05 2)				
							(ai_place end_phantom01)
							(set v_end_phantom01 (ai_vehicle_get_from_starting_location end_phantom01/pilot))
							(cs_run_command_script end_phantom01/pilot cs_end_phantom_path_a)
							(sleep 120)
							(ai_place end_phantom01_5)
							(set v_end_phantom01_5 (ai_vehicle_get_from_starting_location end_phantom01_5/pilot))
							(cs_run_command_script end_phantom01_5/pilot cs_end_phantom_path_a_2)
							(f_banshee_spawns 4); add more banshees squads					
							(sleep_until 
								(and 
									(= (ai_living_count end_phantom01) 0) 
									(= (ai_living_count end_phantom01_5) 0)
								)
							)							
						)
					)
					((and (= banshee_rand_wave 1) (= wave_center FALSE))
						(begin
							(print "THEY ARE COMING FROM THE CENTER!!")			
							(set wave_center TRUE)
							(ai_place banshee02 2)
							(ai_place banshee06 2)
							(ai_place end_phantom05)
							(set v_end_phantom05 (ai_vehicle_get_from_starting_location end_phantom05/pilot))
							(cs_run_command_script end_phantom05/pilot cs_end_phantom_path_e)
							(sleep 120)
							(ai_place end_phantom05_5)
							(set v_end_phantom05_5 (ai_vehicle_get_from_starting_location 
							end_phantom05_5/pilot))
							(cs_run_command_script end_phantom05_5/pilot cs_end_phantom_path_e_2)	
							(f_banshee_spawns 4); add more banshees squads					
							(sleep_until 
								(and 
									(= (ai_living_count end_phantom05) 0) 
									(= (ai_living_count end_phantom05_5) 0)
								)
							)															
						)
					)
				((and (= banshee_rand_wave 2) (= wave_right FALSE))
					(begin
						(print "THEY ARE COMING FROM THE RIGHT SIDE!!")			
						(set wave_right TRUE)
						(ai_place banshee01 2)
						(ai_place banshee04 2)
						(ai_place end_phantom03)
						(set v_end_phantom03 
						(ai_vehicle_get_from_starting_location end_phantom03/pilot))
						(cs_run_command_script end_phantom03/pilot 
						cs_end_phantom_path_c)
						(sleep 120)
						(set v_end_phantom03_5 
						(ai_vehicle_get_from_starting_location end_phantom03_5/pilot))
						(cs_run_command_script end_phantom03_5/pilot cs_end_phantom_path_c_2)
						(f_banshee_spawns 4); add more banshees squads														
						(sleep_until 
							(and 
								(= (ai_living_count end_phantom03) 0) 
								(= (ai_living_count end_phantom03_5) 0)
							)
						)
					)
				)
			)
		TRUE)
	)
	
; wave 6
	(if (> (ai_living_count banshee_groups) 4) (sleep 600))
	(game_save)
	(if (> (ai_living_count banshee_groups) 2) (sleep 300))
	(game_save)
	(set g_wave_control 6)
	(ai_place end_phantom06)
	(set v_end_phantom06 (ai_vehicle_get_from_starting_location end_phantom06/pilot))
	(cs_run_command_script end_phantom06/pilot cs_end_phantom_path_f)		
	
	(ai_place Wave06_Infantry01)
	(ai_place Wave06_Infantry02)
	(ai_place Wave06_Infantry03)
	(ai_place Wave06_Infantry04)	
	(ai_vehicle_enter_immediate Wave06_Infantry01 v_end_phantom06 
	"phantom_p_lf")
	(ai_vehicle_enter_immediate Wave06_Infantry02 v_end_phantom06 
	"phantom_p_ml_f")	
	(ai_vehicle_enter_immediate Wave06_Infantry03 v_end_phantom06 
	"phantom_p_ml_b")	
	(ai_vehicle_enter_immediate Wave06_Infantry04 v_end_phantom06 
	"phantom_p_lb")
	(sleep_until (> (ai_living_count Wave06_Infantry_Group) 1))
	(sleep_until (< (ai_living_count Wave06_Infantry_Group) 1)30 1200)

	(cinematic_fade_to_black)
	(ai_erase end_phantom06)
	(ai_erase Wave04_Infantry_Group)
	(ai_erase Wave06_Infantry_Group)
	(ai_erase banshee_groups)
	(ai_erase gr_allies)
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						(if debug (print "sc140_out_sc"))
						(sc140_out_sc)
					)
				)
				(cinematic_skip_stop)
				
			)
		)
		
	(sleep 5)
	; Hub Global Mission Complete Variable
	(gp_boolean_set gp_sc140_complete TRUE)
	(end_scene)	

)
(script static void phantom_center_test
	(ai_place end_phantom05)
	(set v_end_phantom05 (ai_vehicle_get_from_starting_location end_phantom05/pilot))
	(cs_run_command_script end_phantom05/pilot cs_end_phantom_path_e)
	(sleep 120)
	(ai_place end_phantom05_5)
	(set v_end_phantom05_5 (ai_vehicle_get_from_starting_location 
	end_phantom05_5/pilot))
	(cs_run_command_script end_phantom05_5/pilot cs_end_phantom_path_e_2)	
)
(script static void phantom_left_test			
	(ai_place end_phantom01)
	(set v_end_phantom01 (ai_vehicle_get_from_starting_location end_phantom01/pilot))
	(cs_run_command_script end_phantom01/pilot cs_end_phantom_path_a)
	(sleep 120)
	(ai_place end_phantom01_5)
	(set v_end_phantom01_5 (ai_vehicle_get_from_starting_location end_phantom01_5/pilot))
	(cs_run_command_script end_phantom01_5/pilot cs_end_phantom_path_a_2)	
)
(script static void phantom_right_test
	(ai_place end_phantom03)
	(set v_end_phantom03 
	(ai_vehicle_get_from_starting_location end_phantom03/pilot))
	(cs_run_command_script end_phantom03/pilot 
	cs_end_phantom_path_c)
	(sleep 120)
	(ai_place end_phantom03_5)	
	(set v_end_phantom03_5 
	(ai_vehicle_get_from_starting_location end_phantom03_5/pilot))
	(cs_run_command_script end_phantom03_5/pilot cs_end_phantom_path_c_2)	
)

(script dormant phantom02_test
	(set g_wave_control 2)
	(ai_place end_phantom02)
	(ai_place end_phantom02_5)
	
	(set v_end_phantom02 (ai_vehicle_get_from_starting_location end_phantom02/pilot))
	(set v_end_phantom02_5 (ai_vehicle_get_from_starting_location end_phantom02_5/pilot))
	
	(ai_place Wave02_Infantry01)
	(ai_place Wave02_Infantry02)
	(ai_place Wave02_Infantry03)
	(ai_place Wave02_Infantry04)	
	(ai_vehicle_enter_immediate Wave02_Infantry01 v_end_phantom02 "phantom_p_lb")
	(ai_vehicle_enter_immediate Wave02_Infantry02 v_end_phantom02 "phantom_p_lf")
	(ai_vehicle_enter_immediate Wave02_Infantry03 v_end_phantom02_5 "phantom_p_lb")
	(ai_vehicle_enter_immediate Wave02_Infantry04 v_end_phantom02_5 "phantom_p_ml_b")		
	
	(cs_run_command_script end_phantom02/pilot cs_end_phantom_path_b)
	(cs_run_command_script end_phantom02_5/pilot cs_end_phantom_path_b_2)	
	
)

(script dormant phantom04_test
	(begin_random
		(begin
			(ai_place end_phantom04)
			(set v_end_phantom04 (ai_vehicle_get_from_starting_location 
			end_phantom04/pilot))
			(cs_run_command_script end_phantom04/pilot cs_end_phantom_path_d)
			(sleep_until (= (ai_living_count end_phantom04) 0))
		)
		(begin
			(ai_place end_phantom04_5)
			(set v_end_phantom04_5 (ai_vehicle_get_from_starting_location 
			end_phantom04_5/pilot))
			(cs_run_command_script end_phantom04_5/pilot 
			cs_end_phantom_path_d_2)
			(sleep_until (= (ai_living_count end_phantom04_5) 0))			
		)
	)
)

(script dormant phantom06_test
	(ai_place end_phantom06)
	(set v_end_phantom06 (ai_vehicle_get_from_starting_location end_phantom06/pilot))
	(ai_place Wave06_Infantry01)
	(ai_place Wave06_Infantry02)
	(ai_place Wave06_Infantry03)
	(ai_place Wave06_Infantry04)	
;	(ai_place chieftain)
	(cs_run_command_script end_phantom06/pilot cs_end_phantom_path_f)		
	(ai_vehicle_enter_immediate Wave06_Infantry01 v_end_phantom06 
	"phantom_p_lf")
	(ai_vehicle_enter_immediate Wave06_Infantry02 v_end_phantom06 
	"phantom_p_ml_f")	
	(ai_vehicle_enter_immediate Wave06_Infantry03 v_end_phantom06 
	"phantom_p_ml_b")	
	(ai_vehicle_enter_immediate Wave06_Infantry04 v_end_phantom06 
	"phantom_p_lb")
;	(ai_vehicle_enter_immediate chieftain v_end_phantom06 "phantom_pr_lf")
	(ai_cannot_die end_phantom06/pilot true)
;	(ai_cannot_die chieftain/actor true)
	
)

(script dormant banshee_flyby
	(wake bridge_wiggle)
	(sleep_until (volume_test_players banshee_flyby_vol) 1)
	(ai_place banshee_flyby01)
	(cs_run_command_script banshee_flyby01/pilot cs_banshee_fly_by)
	(sleep 30)
	(ai_place banshee_flyby02)
	(cs_run_command_script banshee_flyby02/pilot cs_banshee_fly_by)
	(sleep 60)
	(wake md_070_cell_banshee_bridge)
	
)

(script dormant bridge_wiggle
	(sleep_until (volume_test_objects banshee_wiggle_vol (ai_actors 
	banshee_flyby01))1)
	(device_set_position bridge 1)
)
(script command_script cs_banshee_fly_by
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1.0)
	(cs_fly_by flyby/p0 3)
	(cs_vehicle_speed 1)	
	(cs_fly_by flyby/p1 3)
	(cs_vehicle_boost TRUE)
	(cs_fly_by flyby/p2 1)
	(cs_fly_by flyby/p3 1)
	(cs_fly_by flyby/p4 1)
	(cs_fly_to flyby/p5 5)
	(ai_erase ai_current_actor)
	
)

(script command_script cs_1a_phantom_path_a
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to cell_1a_phantom_01/p0 5)
	(cs_vehicle_speed 0.4)	
	(cs_fly_to cell_1a_phantom_01/p1 1)
	(wake md_020_cell_1a_alt)
	
	(sleep 60)
	(begin_random
		(begin
			(vehicle_unload v_1a_phantom01 "phantom_p_rf")
			(sleep (random_range 5 15))
		)
		(begin
			(vehicle_unload v_1a_phantom01 "phantom_p_rb")
			(sleep (random_range 5 15))
		)
	)
	(sleep 45)
	(begin_random
		(begin
			(vehicle_unload v_1a_phantom01 "phantom_p_mr_f")
			(sleep (random_range 5 15))
		)
		(begin
			(vehicle_unload v_1a_phantom01 "phantom_p_mr_b")
			(sleep (random_range 5 15))
		)
	)
	(cs_vehicle_speed 0.8)	
	(cs_fly_to cell_1a_phantom_01/p2 2)
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_to cell_1a_phantom_01/p3 10)	

	(ai_erase 1a_phantom01)
	
)

(script command_script cs_1b_phantom_path_a
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_by cell_1b_phantom_01/p2 2)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by cell_1b_phantom_01/p1 5)

	(cs_vehicle_speed 0.6)	
	(cs_fly_to cell_1b_phantom_01/p0 2)
	(sleep_until (volume_test_players enc_cell_1a_vol01) 5)
	
	
	(ai_trickle_via_phantom 1b_phantom/pilot 1b_squad01)
	(ai_set_objective 1b_squad01 cell_1b_obj)
	
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_by cell_1b_phantom_01/p3 10)
	(cs_vehicle_boost FALSE)
	(cs_fly_to cell_1b_phantom_01/p4 2)	

	(ai_erase 1b_phantom)
	
)


(script command_script cs_2a_phantom_path_a
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to cell_2a_phantom_01/p0 5)
	(cs_vehicle_speed 0.5)

	(cs_fly_to cell_2a_phantom_01/p1 10)
	(cs_vehicle_speed 0.8)	

	(cs_fly_to cell_2a_phantom_01/p2 2)
	(cs_vehicle_speed 1.0)	

	(ai_erase 2a_phantom01)
	
)

(script command_script cs_end_phantom_path_a
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_a/p0 5)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by end_phantom_path_a/p1 10)

	(cs_vehicle_speed 0.4)
	(sleep 240)
	(cs_fly_to end_phantom_path_a/p2 2)
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_to end_phantom_path_a/p3 10)	

	(ai_erase end_phantom01)
	
)
(script command_script cs_end_phantom_path_a_2
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_a/p4 5)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by end_phantom_path_a/p5 10)

	(cs_vehicle_speed 0.4)
	(sleep 240)
	(cs_fly_to end_phantom_path_a/p6 2)
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_to end_phantom_path_a/p7 10)	

	(ai_erase end_phantom01_5)
	
)
(script command_script cs_end_phantom_path_b
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_b/p0 5)
	(cs_fly_to end_phantom_path_b/p9 2)
	(cs_fly_to end_phantom_path_b/p1 2)
	(cs_vehicle_speed 0.4)

	(cs_fly_to_and_face end_phantom_path_b/p2 end_phantom_path_b/p3)
	(sleep 30)
	(vehicle_hover v_end_phantom02 TRUE)

	(vehicle_unload v_end_phantom02 "phantom_p_lb")
	(sleep 330)

	(vehicle_unload v_end_phantom02 "phantom_p_lf")
	(sleep (random_range 30 90))

	(sleep 180)
	(vehicle_hover v_end_phantom02 FALSE)
	
	(cs_vehicle_speed 1)
	(cs_vehicle_boost TRUE)	
	(cs_fly_to end_phantom_path_b/p4 2)	

;	(cs_fly_to end_phantom_path_b/p5 2)
	(ai_erase end_phantom02)
	
)

(script command_script cs_end_phantom_path_b_2
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_b/p5 5)
	(cs_fly_by end_phantom_path_b/p6 1)
	(cs_vehicle_speed 0.4)

	(cs_fly_to_and_face end_phantom_path_b/p7 end_phantom_path_b/p8)
	(sleep 30)
	(vehicle_hover v_end_phantom02_5 TRUE)

	(vehicle_unload v_end_phantom02_5 "phantom_p_ml_b")
	(sleep (random_range 120 180))

	(vehicle_unload v_end_phantom02_5 "phantom_p_lb")
	(sleep (random_range 120 180))

	(sleep 90)
	(vehicle_hover v_end_phantom02_5 FALSE)
	
	(cs_vehicle_speed 1)
	(cs_vehicle_boost TRUE)	
	(cs_fly_to end_phantom_path_b/p10 2)	

;	(cs_fly_to end_phantom_path_b/p5 2)
	(ai_erase end_phantom02_5)
	
)


(script command_script cs_end_phantom_path_c
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_c/p0 5)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by end_phantom_path_c/p1 10)

	(cs_fly_to end_phantom_path_c/p2 2)
	(cs_vehicle_speed 0.4)	
	
	(cs_fly_to end_phantom_path_c/p3 2)
	(sleep 240)
	(cs_fly_to end_phantom_path_c/p4 2)	
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_by end_phantom_path_c/p5 5)	
	(ai_erase end_phantom03)
)

(script command_script cs_end_phantom_path_c_2
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_c/p10 5)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by end_phantom_path_c/p9 10)

	(cs_fly_to end_phantom_path_c/p8 2)
	(cs_vehicle_speed 0.4)	
	
	(cs_fly_to end_phantom_path_c/p7 2)
	(sleep 240)
	(cs_fly_to end_phantom_path_c/p6 2)	
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_by end_phantom_path_c/p11 5)	
	(ai_erase end_phantom03_5)
)

(script command_script cs_end_phantom_path_d
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_d/p0 1)
	(ai_dump_via_phantom end_phantom04/pilot Wave04_Infantry01)
	(cs_vehicle_speed 0.4)
	(cs_fly_by end_phantom_path_d/p1 10)
	(ai_dump_via_phantom end_phantom04/pilot Wave04_Infantry02)

	(cs_fly_to end_phantom_path_d/p2 2)
	(cs_vehicle_speed 0.4)	
	(ai_dump_via_phantom end_phantom04/pilot Wave04_Infantry03)
	(cs_vehicle_speed 1)			
	(cs_fly_to end_phantom_path_d/p3 2)	
	(ai_erase end_phantom04)
	
)
(script command_script cs_end_phantom_path_d_2
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_d/p5 5)
	(cs_vehicle_speed 0.4)
	(cs_fly_by end_phantom_path_d/p2 10)
	(ai_dump_via_phantom end_phantom04_5/pilot Wave04_Infantry05)

	(cs_fly_to end_phantom_path_d/p1 1)
	(cs_vehicle_speed 0.4)
	(ai_dump_via_phantom end_phantom04_5/pilot Wave04_Infantry04)			
	(cs_fly_to end_phantom_path_d/p0 0)
	(ai_dump_via_phantom end_phantom04_5/pilot Wave04_Infantry06)	
	(cs_vehicle_speed 1)		
	(cs_fly_to end_phantom_path_d/p4 0)	
	
	(ai_erase end_phantom04_5)
	
)

(script command_script cs_end_phantom_path_e
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_e/p0 5)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by end_phantom_path_e/p1 10)

	(cs_vehicle_speed 0.4)	
	(cs_fly_to end_phantom_path_e/p2 2)
	(sleep 240)
	
	(cs_fly_to end_phantom_path_e/p3 2)
	(cs_vehicle_speed 1.0)	
	(cs_fly_by end_phantom_path_e/p4 2)	

	(ai_erase end_phantom05)
)

(script command_script cs_end_phantom_path_e_2
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_e/p5 5)

	(cs_vehicle_speed 0.8)	
	(cs_fly_by end_phantom_path_e/p6 10)

	(cs_vehicle_speed 0.4)	
	(cs_fly_to end_phantom_path_e/p7 2)
	(sleep 240)
	
	(cs_fly_to end_phantom_path_e/p8 2)
	(cs_vehicle_speed 1.0)	
	(cs_fly_by end_phantom_path_e/p9 2)	

	(ai_erase end_phantom05_5)
)

(script command_script cs_end_phantom_path_f
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to end_phantom_path_f/p0 5)
	(cs_fly_to end_phantom_path_f/p6 2)	
	(cs_fly_to end_phantom_path_f/p1 5)
	(cs_vehicle_speed 0.4)

	(cs_fly_to_and_face end_phantom_path_f/p2 end_phantom_path_f/p3)
	(sleep 30)
	(vehicle_hover v_end_phantom06 TRUE)

		(begin_random
			(begin
				(vehicle_unload v_end_phantom06 "phantom_p_lf")
				(sleep (random_range 120 180))
			)
			(begin
				(vehicle_unload v_end_phantom06 "phantom_p_lb")
				(sleep (random_range 120 180))
			)
		)
		(sleep 120)
		(begin_random
			(begin
				(vehicle_unload v_end_phantom06 "phantom_p_ml_f")
				(sleep (random_range 120 180))
			)
			(begin
				(vehicle_unload v_end_phantom06 "phantom_p_ml_b")
				(sleep (random_range 120 180))
			)
		)
)

(script dormant save_game
	(sleep_until (volume_test_players game_save_vol01))
	(sleep_until (game_safe_to_save) 10 300)
	(if (volume_test_players_all game_save_vol01) (game_save_immediate))
	(sleep_until (volume_test_players game_save_vol10))
	(sleep_until (game_safe_to_save) 10 300)
	(if (volume_test_players_all game_save_vol10) (game_save_immediate))	
)

(script dormant object_management
	(if (= (current_zone_set) 0)
		(print "OBJ_MGMT- Beginning")
	)
	(sleep_until (>= (current_zone_set) 1) 1)
	(if (= (current_zone_set) 1)
		(print "OBJ_MGMT- LOADING LOBBY")
	)
	(sleep_until (>= (current_zone_set) 2) 1)
	(if (= (current_zone_set) 2)
		(begin
			(device_set_position_immediate sc140_door_14 0)
			(device_set_power sc140_door_14 0)							
			(print "OBJ_MGMT- LOADING CELL2")
		)
	)
	(sleep_until (>= (current_zone_set) 3) 1)
	(if (= (current_zone_set) 3)
		(begin
			(device_set_position_immediate sc140_door_15 0)
			(device_set_power sc140_door_15 0)		
			(print "OBJ_MGMT- REMOVING LOBBY")
		)
	)
)