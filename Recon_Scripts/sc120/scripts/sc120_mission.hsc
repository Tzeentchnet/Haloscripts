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

; objective control global shorts
(global short g_030_lower_obj_control 0)
(global short g_030_mid_obj_control 0)
(global short g_030_upper_obj_control 0)
(global short g_040_obj_control 0)
(global short g_100_obj_control 0)
(global short g_030_wraith_03 0)

; starting player pitch 
(global short g_player_start_pitch -16)

(global boolean g_null FALSE)

(global real g_nav_offset 0.55)

(script command_script abort_cs
	(sleep 1)
)

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
;=============================== Scene 120 MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================
(script startup sc120_startup
	(if debug (print "sc120 mission script"))
	

	(ai_allegiance human player)
	(ai_allegiance player human)

		; === PLAYER IN WORLD TEST =====================================================
		(if	(and
				(not editor)
				(> (player_count) 0)
			)
			; if game is allowed to start 
			(start)
			
			; if game is NOT allowed to start

			(begin 
				(fade_in 0 0 0 0)
			)
		)
)

		; === PLAYER IN WORLD TEST =====================================================

(script static void start

	(wake sc120_first)
)

(script dormant sc120_first

	(ai_allegiance human player)
	(ai_allegiance player human)

; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						;fade to black
						(cinematic_snap_to_black)
						(if debug (print "sc120_int_sc"))	
;							(sleep 60)	
;						(cinematic_set_title title_1)
;							(sleep 60)
;						(cinematic_set_title title_2)
;						(sleep (* 30 5))
						(sc120_int_sc)
					)
				)
				(cinematic_skip_stop)
			)
		)
		
	; start initial encounter
	(wake enc_030_lower)
	(wake 030_lower_place_01)
	(wake nav_point_tank)
	(object_create jersey_01)
	(object_create jersey_02)
	(object_create 030_intro_truck)
	(object_create 030_intro_car)
	(sleep 1)
				
	(cinematic_fade_to_gameplay)

)

;====================================================================================================================================================================================================
;=============================== 030_lower ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_030_lower

	;Trigger Volumes

	(sleep_until (volume_test_players tv_030_lower_01) 1)
	(if debug (print "set objective control 1"))
	(set g_030_lower_obj_control 1)
	(game_save)
	
	(sleep_until (volume_test_players tv_030_lower_02) 1)
	(if debug (print "set objective control 2"))
	(set g_030_lower_obj_control 2)
	(game_save)
	
	(sleep_until (volume_test_players tv_030_lower_03) 1)
	(if debug (print "set objective control 3"))
	(set g_030_lower_obj_control 3)
	(game_save)
	
	(sleep_until (volume_test_players tv_030_lower_04) 1)
	(if debug (print "set objective control 4"))
	(set g_030_lower_obj_control 4)
	(wake enc_030_mid)
	(game_save)
	
)	

;=============================== 030_lower secondary scripts =======================================================================================================================================

(script dormant 030_lower_place_01

	;initial placement

	(ai_place sq_030_allies_01)
	(ai_place sq_030_allies_02)
	(ai_place sq_030_scorpion_01)
		(sleep 1)
	(ai_place sq_030_allies_03)
	(ai_place sq_030_allies_04)
		(sleep 1)
	(ai_place sq_030_cov_01)
	(ai_place sq_030_cov_02)
		(sleep 1)
	(ai_place sq_030_cov_03)
	(ai_place sq_030_jackal_01)
		(sleep 1)
	(ai_place sq_030_jackal_02)
	(ai_place sq_030_wraith_01)	
;	(ai_place sq_030_wraith_02)
		(sleep 1)
	(ai_place sq_030_wraith_03)
	(ai_place sq_030_jackal_03)
		(sleep 1)
	(ai_place sq_phantom_01)
	
	(ai_vehicle_reserve_seat sq_030_scorpion_01 "scorpion_p" TRUE)
		
	(wake scorpion_unreserve)
	
	(ai_force_active gr_030_lower_cov TRUE)
	
;	(units_set_current_vitality (ai_actors sq_030_scorpion_01) .9 0)
;	(units_set_maximum_vitality (ai_actors sq_030_scorpion_01) .9 0)
	(ai_prefer_target_ai sq_030_allies_02 sq_030_wraith_01 TRUE)
	
	(sleep_until (volume_test_players tv_030_lower_04) 1)
	
	(ai_prefer_target_ai sq_030_allies_02 sq_030_wraith_01 FALSE)
)

;=============================== Wraith Firing Behavior =====================================================================================================================================================================================

(script command_script cs_030_wraith_shoot

	(cs_run_command_script sq_030_wraith_01/gunner abort_cs)	
		(cs_enable_moving TRUE)
		(cs_abort_on_damage TRUE)
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_030_wraith_01/p0)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_030_wraith_01/p1)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_030_wraith_01/p2)
				)
			)
			FALSE
		)
	)
)

;=============================== Scorpion Navigation =====================================================================================================================================================================================

(global vehicle scorpion_01 none)

(script command_script cs_030_scorpion

	(cs_enable_pathfinding_failsafe TRUE)
		
	(cs_enable_targeting FALSE)
	(cs_enable_looking FALSE)
		(cs_vehicle_speed .6)
		
	(cs_go_to ps_030_scorpion/run_01)
	(cs_go_to ps_030_scorpion/run_02 2)
	(cs_go_to ps_030_scorpion/run_03 2)		
	(cs_go_to ps_030_scorpion/run_04)
	(cs_go_to ps_030_scorpion/run_05 1)
	
	(sleep 1)
)

(script dormant scorpion_unreserve


	(set scorpion_01 (ai_vehicle_get_from_starting_location sq_030_scorpion_01/scorpion))
	
	(sleep_until	
		(or
			(vehicle_test_seat_unit scorpion_01 "scorpion_d" (player0))
			(vehicle_test_seat_unit scorpion_01 "scorpion_d" (player1))
			(vehicle_test_seat_unit scorpion_01 "scorpion_d" (player2))
			(vehicle_test_seat_unit scorpion_01 "scorpion_d" (player3))
		)
	5)	
	
	(ai_vehicle_reserve_seat sq_030_scorpion_01 "scorpion_p" FALSE)
)

;=============================== Tank NavPoint =========================================================================================

(script dormant nav_point_tank

	(sleep_until (volume_test_players tv_030_lower_00) 1)		

	(hud_activate_team_nav_point_flag player fl_tank .5)
	
	(sleep_until
		(volume_test_players tv_tank) 1)
		
	(hud_deactivate_team_nav_point_flag player fl_tank)
)

;=============================== phantom_01 =====================================================================================================================================================================================

(global vehicle phantom_01 none)
(script command_script cs_phantom_01

	(if debug (print "phantom 01"))
	(set phantom_01 (ai_vehicle_get_from_starting_location sq_phantom_01/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_01_cov_01)
		(ai_place sq_phantom_01_brute_01)		
		(ai_place sq_phantom_01_ghost_01)
		
		(ai_force_active gr_phantom_01 TRUE)

			(sleep 5)
			
	; == scale ====================================================		

	(object_set_scale phantom_01 0.9 0)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_01_cov_01 phantom_01 "phantom_p_lb")		
		(ai_vehicle_enter_immediate sq_phantom_01_brute_01 phantom_01 "phantom_p_rb")
		(vehicle_load_magic phantom_01 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_01_ghost_01/ghost))
		
			(sleep 1)

	; start movement 
	
	(sleep_until (>= g_030_lower_obj_control 3))

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_01/hover_01 ps_phantom_01/face_01 1)
			(sleep 30)
		(cs_fly_to_and_face ps_phantom_01/hover_02 ps_phantom_01/face_01 1)
			(sleep 15)
			(cs_vehicle_speed .15)
		
		(cs_fly_by ps_phantom_01/approach_01 1)
;		(cs_fly_to ps_phantom_01/approach_02 1)	
	
			(cs_vehicle_speed .3)
		(cs_fly_to ps_phantom_01/drop_01 1)
		(unit_open phantom_01)
		(sleep 15)
		
		; set the objective
		(ai_set_objective sq_phantom_01 obj_030_lower_cov)
		(ai_set_objective gr_phantom_01 obj_030_lower_cov)
	
		;drop		
		(vehicle_unload phantom_01  "phantom_p_lb")
		(sleep 75)
		
		(cs_fly_to ps_phantom_01/drop_02)
		
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
		(sleep 15)
		(vehicle_unload phantom_01 "phantom_p_rb")
		(sleep 75)
		
	(unit_close phantom_01)
	(cs_vehicle_speed .6)
	
	; == introduce wraith ====================================================
	(set g_030_wraith_03 1)

	(cs_fly_by ps_phantom_01/exit_01)
	(cs_fly_by ps_phantom_01/exit_02)
	(cs_fly_by ps_phantom_01/exit_03)
		(cs_vehicle_speed 1)
	(cs_fly_by ps_phantom_01/exit_04)	
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_01/erase)
	(ai_erase ai_current_squad)
)

;====================================================================================================================================================================================================
;=============================== 030_mid ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_030_mid

	;Trigger Volumes	
	
	(sleep_until (volume_test_players tv_030_mid_01) 1)
	(if debug (print "set objective control 1"))
	(set g_030_mid_obj_control 1)
	(wake 030_mid_place_01)	
	(game_save)
	
	(sleep_until (volume_test_players tv_030_mid_02) 1)
	(if debug (print "set objective control 2"))
	(set g_030_mid_obj_control 2)
	(wake 030_mid_place_02)
	(game_save)
	
	(sleep_until (volume_test_players tv_030_mid_03) 1)
	(if debug (print "set objective control 3"))
	(set g_030_mid_obj_control 3)					
	(wake 030_mid_place_03)	
	(game_save)
	
	(sleep_until (volume_test_players tv_030_mid_04) 1)
	(if debug (print "set objective control 4"))
	(set g_030_mid_obj_control 4)
	(wake 030_mid_place_04)
	(wake enc_030_upper)
	(game_save)
	
)	

;=============================== 030_mid secondary scripts =======================================================================================================================================

(script dormant 030_mid_place_01

	(ai_place sq_030_jackal_04)
	(ai_place sq_030_jackal_sniper_01)
		(sleep 1)
	(ai_place sq_030_brute_01)
	(ai_place sq_030_brute_02)

;	introduce wraith
	(set g_030_wraith_03 1)
)

(script dormant 030_mid_place_02

	(ai_place sq_030_ghost_01)
	(ai_force_active gr_030_mid_cov TRUE)
)

(script dormant 030_mid_place_03

	(ai_place sq_030_watchtower_01)
	(ai_place sq_030_ghost_02)
		(sleep 1)
	(ai_place sq_030_shade_01)
	(ai_place sq_030_shade_02)
		(sleep 1)
	(ai_place sq_030_cov_04)	
	
	(ai_force_active gr_030_mid_cov TRUE)
)

(script dormant 030_mid_place_04

	(ai_place sq_030_jackal_sniper_02)
	(ai_place sq_phantom_02)		
)

;=============================== ghost attack =====================================================================================================================================================================================

(script command_script cs_030_ghost_01
		(cs_enable_pathfinding_failsafe TRUE)
		
		(cs_enable_targeting TRUE)
		(cs_enable_looking TRUE)

		(cs_go_to ps_030_ghost_01/run_01)
		(cs_go_to ps_030_ghost_01/run_02)
)

;=============================== phantom_02 =====================================================================================================================================================================================

(global vehicle phantom_02 none)
(script command_script cs_phantom_02

	(if debug (print "phantom 02"))
	(set phantom_02 (ai_vehicle_get_from_starting_location sq_phantom_02/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_02_cov_01)
		(ai_place sq_phantom_02_jackal_01)
		(ai_place sq_phantom_02_ghost)
		
		(ai_force_active gr_phantom_02 TRUE)

			(sleep 5)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_02_cov_01 phantom_02 "phantom_p_rb")		
		(ai_vehicle_enter_immediate sq_phantom_02_jackal_01 phantom_02 "phantom_p_mr_b")		
		(vehicle_load_magic phantom_02 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_02_ghost/ghost))
		
			(sleep 1)

		; set the objective
		(ai_set_objective sq_phantom_02 obj_030_mid_cov)
		(ai_set_objective gr_phantom_02 obj_030_mid_cov)

	; start movement 
		
	(cs_fly_by ps_phantom_02/approach_01)
	(cs_fly_by ps_phantom_02/approach_02)
		(cs_vehicle_speed .8)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_02/hover_01 ps_phantom_02/face_01 1)
			(sleep 15)
			(unit_open phantom_02)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_02/drop_01 ps_phantom_02/face_01 1)
	
		;drop		
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
			(sleep 30)
		(vehicle_unload phantom_02 "phantom_p_rb")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_02 "phantom_p_mr_b")
		(sleep 75)

		(cs_fly_to_and_face ps_phantom_02/hover_01 ps_phantom_02/face_01 1)
		
	(unit_close phantom_02)
	(sleep (random_range 60 90))
	(cs_vehicle_speed .8)

	(cs_fly_by ps_phantom_02/exit_01)
	(cs_fly_by ps_phantom_02/exit_02)	
	(cs_fly_by ps_phantom_02/exit_03)
	(cs_fly_by ps_phantom_02/exit_04)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_02/erase)
	(ai_erase ai_current_squad)
)

;====================================================================================================================================================================================================
;=============================== 030_upper ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_030_upper

	;Trigger Volumes
	
	(sleep_until (volume_test_players tv_030_upper_01) 1)
	(if debug (print "set objective control 1"))
	(set g_030_upper_obj_control 1)
	(wake 030_upper_place_01)
	(game_save)
	
	(sleep_until (volume_test_players tv_030_upper_02) 1)
	(if debug (print "set objective control 2"))
	(set g_030_upper_obj_control 2)
	(game_save)
	
	(sleep_until (volume_test_players tv_030_upper_03) 1)
	(if debug (print "set objective control 3"))
	(set g_030_upper_obj_control 3)	
	(wake 030_upper_place_02)
	(game_save)
	
	(sleep_until (volume_test_players tv_030_upper_04) 1)
	(if debug (print "set objective control 4"))
	(set g_030_upper_obj_control 4)
	(wake enc_040)
	(wake 040_place_01)	
	(game_save)			
)

;=============================== 030_upper secondary scripts =======================================================================================================================================

(script dormant 030_upper_place_01

;	(ai_place sq_030_wraith_04)
	(ai_place sq_030_cov_05)
	(ai_place sq_030_cov_06)
	(ai_place sq_030_shade_03)
	(ai_place sq_030_shade_04)
	(ai_place sq_030_shade_05)	
	(ai_place sq_030_turret_01)
	(ai_place sq_030_ghost_03)
	(ai_place sq_030_cov_07)
	(ai_place sq_030_jackal_sniper_03)
	
	(ai_force_active gr_030_upper_cov TRUE)		
)

(script dormant 030_upper_place_02

	(sleep_until (<= (ai_task_count obj_030_upper_cov/gt_shade) 1) 5 (* 30 5))  
	
	(ai_place sq_phantom_03)

)

;=============================== phantom_03 =====================================================================================================================================================================================

(global vehicle phantom_03 none)
(script command_script cs_phantom_03

	(if debug (print "phantom 03"))
	(set phantom_03 (ai_vehicle_get_from_starting_location sq_phantom_03/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_03_brute)
		(ai_place sq_phantom_03_grunt)
		(ai_place sq_phantom_03_jackal_sniper_01)		
		(ai_place sq_phantom_03_jackal_sniper_02)
		(ai_place sq_phantom_03_ghost)
		
		(ai_force_active gr_phantom_03 TRUE)

			(sleep 5)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_03_brute phantom_03 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_03_grunt phantom_03 "phantom_p_lf")	
		(ai_vehicle_enter_immediate sq_phantom_03_jackal_sniper_01 phantom_03 "phantom_p_ml_b")						
		(ai_vehicle_enter_immediate sq_phantom_03_jackal_sniper_02 phantom_03 "phantom_p_mr_b")		
		(vehicle_load_magic phantom_03 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_03_ghost/ghost))
		
			(sleep 1)

		; set the objective
		(ai_set_objective sq_phantom_03 obj_030_upper_cov)
		(ai_set_objective gr_phantom_03 obj_030_upper_cov)

	; start movement 
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_03/approach_01)
		(cs_vehicle_boost FALSE)

	(cs_vehicle_speed 1)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_03/hover_01 ps_phantom_03/face_01 1)
			(sleep 15)
		(unit_open phantom_03)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_03/drop_01 ps_phantom_03/face_01 1)
			(sleep 30)
	
		;drop		

		(vehicle_unload phantom_03 "phantom_p_rf")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_03 "phantom_p_mr_b")
			(sleep 75)
		
		(cs_fly_to_and_face ps_phantom_03/drop_03 ps_phantom_03/face_03 1)	 
			(sleep (random_range 15 30))
		(vehicle_unload phantom_03 "phantom_p_lf")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_03 "phantom_p_ml_b")

			(sleep 75)

	; == begin drop ====================================================
			(cs_vehicle_speed 1)
			
		(cs_fly_by ps_phantom_03/approach_02)
			
		(cs_fly_to_and_face ps_phantom_03/hover_02 ps_phantom_03/face_02 1)
			(sleep 15)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_03/drop_02 ps_phantom_03/face_02 1)
		
		;drop		
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
			(sleep 30)

		(cs_fly_to_and_face ps_phantom_03/hover_02 ps_phantom_03/face_02 1)
		
	(sleep (random_range 15 75))
	(cs_vehicle_speed 1.0)

	(cs_fly_by ps_phantom_03/exit_01)
	(cs_fly_by ps_phantom_03/exit_02)
	(cs_fly_by ps_phantom_03/exit_03)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_03/erase)
	(ai_erase ai_current_squad)
)

;====================================================================================================================================================================================================
;=============================== 040 ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_040

	;Trigger Volumes

	(sleep_until (volume_test_players tv_040_01) 1)
	(if debug (print "set objective control 1"))
	(set g_040_obj_control 1)
	(game_save)
	
	(sleep_until (volume_test_players tv_040_02) 1)
	(if debug (print "set objective control 2"))
	(set g_040_obj_control 2)
	(wake 040_place_02)
	(game_save)
	
	(sleep_until (volume_test_players tv_040_03) 1)
	(if debug (print "set objective control 3"))
	(set g_040_obj_control 3)
	(game_save)
	
	(sleep_until (volume_test_players tv_040_04) 1)
	(if debug (print "set objective control 4"))
	(set g_040_obj_control 4)
	(wake 040_place_03)	
	(game_save)
	
	(sleep_until (volume_test_players tv_040_05) 1)
	(if debug (print "set objective control 5"))
	(set g_040_obj_control 5)	
	(game_save)
	
	(sleep_until (volume_test_players tv_040_06) 1)
	(if debug (print "set objective control 6"))
	(set g_040_obj_control 6)
	(game_save)
	
	(sleep_until (volume_test_players tv_040_07) 1)
	(if debug (print "set objective control 7"))
	(set g_040_obj_control 7)
	(game_save)
	
		;zone set switch	
		(zone_set_trigger_volume_enable zone_set:set_030_040 FALSE)
		(device_set_power 030_040_hub_door 0)	
		(device_set_position 030_040_hub_door 0)
			
			(sleep_until (= (device_get_position 030_040_hub_door) 0))
		(switch_zone_set set_040_100)
			(sleep 90)
		(wake 040_place_04)
		(device_set_position 040_100_hub_door 1)
	
	(sleep_until (volume_test_players tv_040_08) 1)
	(if debug (print "set objective control 8"))
	(set g_040_obj_control 8)
	(game_save)	
)

;=============================== 040 secondary scripts =======================================================================================================================================

(script dormant 040_place_01

	(ai_place sq_040_cov_01)
	(ai_place sq_040_cov_04)
	(ai_place sq_040_cov_05)
	(ai_place sq_040_jackal_01)
	(ai_place sq_040_grunts_01)

	(ai_place sq_040_wraith_01)
;	(ai_place sq_040_wraith_02)
	(ai_place sq_040_cov_02)
	(ai_place sq_040_cov_03)
	
;	(ai_place sq_040_scorpion)
	(ai_place sq_040_allies_01)
	(ai_place sq_040_allies_02)
;	(ai_place sq_040_allies_03)
)	

(script dormant 040_place_02

	(ai_place sq_040_banshee_01)
	(ai_place sq_040_banshee_02)
)

(script dormant 040_place_03

	(ai_place sq_phantom_04)
)

(script dormant 040_place_04

	(ai_place sq_040_jackal_02)
	(ai_place sq_040_jackal_03)
	(ai_place sq_040_cov_06)
)

;=============================== Banshee ========================================================================

(script command_script cs_040_banshee_01
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_040_banshee/approach_01)
(cs_fly_by ps_040_banshee/dive_01)
	(cs_vehicle_boost FALSE)
(cs_fly_by ps_040_banshee/turn_01)
(cs_fly_by ps_040_banshee/split_01)
(cs_fly_by ps_040_banshee/end_01)

)

(script command_script cs_040_banshee_02
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_040_banshee/approach_02)
(cs_fly_by ps_040_banshee/dive_02)
	(cs_vehicle_boost FALSE)
(cs_fly_by ps_040_banshee/turn_02)
(cs_fly_by ps_040_banshee/split_02)
(cs_fly_by ps_040_banshee/end_02)

)

;=============================== Marine running to turret ========================================================================

(script command_script cs_040_allies_01
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_go_to_vehicle 040_machinegun_01)
	(ai_vehicle_enter sq_040_allies_01 040_machinegun_01 "turret_g")
)

;=============================== phantom_04 =====================================================================================================================================================================================

(global vehicle phantom_04 none)
(script command_script cs_phantom_04

	(if debug (print "phantom 04"))
	(set phantom_04 (ai_vehicle_get_from_starting_location sq_phantom_04/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_04_cov_01)
		(ai_place sq_phantom_04_cov_02)
		(ai_place sq_phantom_04_jackal_01)		
		(ai_place sq_phantom_04_jackal_02)
		(ai_place sq_phantom_04_ghost)
		
		(ai_force_active gr_phantom_04 TRUE)

			(sleep 5)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_04_cov_01 phantom_04 "phantom_p_lb")
		(ai_vehicle_enter_immediate sq_phantom_04_cov_02 phantom_04 "phantom_p_lf")	
		(ai_vehicle_enter_immediate sq_phantom_04_jackal_01 phantom_04 "phantom_p_ml_f")						
		(ai_vehicle_enter_immediate sq_phantom_04_jackal_02 phantom_04 "phantom_p_ml_b")		
		(vehicle_load_magic phantom_04 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_04_ghost/ghost))
		
			(sleep 1)

		; set the objective
		(ai_set_objective sq_phantom_04 obj_040_cov)
		(ai_set_objective gr_phantom_04 obj_040_cov)

	; start movement 
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_04/approach_01)
		(cs_vehicle_boost FALSE)
	(cs_fly_by ps_phantom_04/approach_02)

	(cs_vehicle_speed 1)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_04/hover_01 ps_phantom_04/face_01 1)
			(sleep 15)
		(unit_open phantom_04)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_04/drop_01 ps_phantom_04/face_01 1)
			(sleep 30)
	
		;drop		

		(vehicle_unload phantom_04 "phantom_p_lb")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_04 "phantom_p_lf")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_04 "phantom_p_ml_f")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_04 "phantom_p_ml_b")

			(sleep 75)

	; == defensive maneuver ====================================================
			(cs_vehicle_speed 1)
			
		(cs_fly_to_and_face ps_phantom_04/hover_01 ps_phantom_04/face_01 1)
			(sleep (random_range 5 15))
			
		(cs_fly_by ps_phantom_04/run_01)	
		(cs_fly_by ps_phantom_04/run_02)
		(cs_fly_by ps_phantom_04/run_03)
		(cs_fly_by ps_phantom_04/run_04)		
		(cs_fly_by ps_phantom_04/run_05)
			(cs_vehicle_speed .5)			

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_04/hover_02 ps_phantom_04/face_02 1)
			(sleep 15)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_04/drop_02 ps_phantom_04/face_02 1)
			(sleep 15)
			
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
			(sleep 30)	
		
		(cs_fly_to_and_face ps_phantom_04/hover_02 ps_phantom_04/face_02 1)
		(cs_fly_to_and_face ps_phantom_04/hover_03 ps_phantom_04/face_03 1)
		
	(sleep_until (<= (ai_task_count obj_040_cov/gt_phantom) 1) 5 (* 30 10))
		
	(cs_vehicle_speed 1.0)

	(cs_fly_by ps_phantom_04/exit_01)
	(cs_fly_by ps_phantom_04/exit_02)

		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_04/erase)
	(ai_erase ai_current_squad)
)

;====================================================================================================================================================================================================
;=============================== 100 ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_100

	;Trigger Volumes

	(sleep_until (volume_test_players tv_100_01) 1)
	(if debug (print "set objective control 1"))
	(set g_040_obj_control 1)
	(game_save)
)	

;=============================== 040 secondary scripts =======================================================================================================================================

(script dormant 100_place_01
	(sleep 1)
	;(ai_place sq_040_cov_01)
)
;=============================== level end =====================================================================================================================================================================================

(script dormant level_end
		(sleep 1)
		
;		(sleep_until (volume_test_players tv_pod_04_10) 1)

; fade to black 
	(cinematic_fade_to_black)
		(sleep 1)
	
	; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						(if debug (print "sc120_out_sc_01"))
						(sc120_out_sc)
					)
				)
				(cinematic_skip_stop)
				
			)
		)
		
	(sleep 5)
	(gp_boolean_set gp_sc120_complete TRUE)
	(end_scene)
)