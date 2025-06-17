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
(global short g_pod_01_obj_control 0)
(global short g_pod_02_obj_control 0)
(global short g_pod_03_obj_control 0)
(global short g_pod_04_obj_control 0)
(global short g_pod_02_ghost_escape 0)

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
;=============================== Scene 110 MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================
(script startup sc110_startup
	(if debug (print "sc110 mission script"))
	
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
	(gp_integer_set gp_current_scene 110)
	(wake sc110_first)
)

(script dormant sc110_first

	(ai_allegiance human player)
	(ai_allegiance player human)

; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						;fade to black
						(cinematic_snap_to_black)
						(if debug (print "sc110_int_sc"))	
							(sleep 60)	
						(cinematic_set_title title_1)
							(sleep 60)
						(cinematic_set_title title_2)
						(sleep (* 30 5))
						(sc110_int_sc)
					)
				)
				(cinematic_skip_stop)
			)
		)

	; start initial encounter
	(wake enc_pod_01)
	(wake pod_01_place_01)
	(sleep 1)
				
	(cinematic_fade_to_gameplay)

)

;====================================================================================================================================================================================================
;=============================== POD_1 ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_pod_01

	;Trigger Volumes

	(sleep_until (volume_test_players tv_pod_01_01) 1)
	(if debug (print "set objective control 1"))
	(set g_pod_01_obj_control 1)
	(game_save)

	(wake pod_01_drone)
	(ai_cannot_die sq_pod_01_warthog_01 FALSE)	
	(ai_cannot_die sq_pod_01_warthog_02 FALSE)
	(ai_cannot_die sq_pod_01_chopper_01 FALSE)
	(ai_cannot_die sq_pod_01_chopper_02 FALSE)
	(ai_cannot_die sq_pod_01_chopper_03 FALSE)

	(sleep_until (volume_test_players tv_pod_01_02) 1)
	(if debug (print "set objective control 2"))
	(set g_pod_01_obj_control 2)
	(wake pod_01_place_02)
	
	(sleep_until (volume_test_players tv_pod_01_03) 1)
	(if debug (print "set objective control 3"))
	(set g_pod_01_obj_control 3)
	
	(sleep_until (volume_test_players tv_pod_01_04) 1)
	(if debug (print "set objective control 4"))
	(set g_pod_01_obj_control 4)
	(wake pod_01_place_03)
	(game_save)

	(sleep_until (volume_test_players tv_pod_01_05) 1)
	(if debug (print "set objective control 5"))
	(set g_pod_01_obj_control 5)
	(game_save)	
	
	(sleep_until (volume_test_players tv_pod_01_06) 1)
	(if debug (print "set objective control 6"))
	(set g_pod_01_obj_control 6)
	(wake enc_pod_02)
	(wake pod_02_place_01)
)

;=============================== POD_1 secondary scripts =======================================================================================================================================

(script dormant pod_01_place_01
	
	;initial placement
	(ai_place sq_pod_01_wraith_01)
	(ai_place sq_pod_01_wraith_02)
	(ai_place sq_pod_01_chopper_01)
	(ai_place sq_pod_01_chopper_02)
	(ai_place sq_pod_01_chopper_03)
	(ai_place sq_pod_01_warthog_01)	
	(ai_place sq_pod_01_warthog_02)
;	(ai_place sq_pod_01_warthog_03)
;	(ai_place sq_pod_01_warthog_04)	
	(ai_place sq_pod_01_allies_01)	
	(ai_place sq_pod_01_allies_02)
	(ai_place sq_pod_01_allies_03)
	(ai_place sq_pod_01_ghost_01)
	(ai_place sq_pod_01_cov_01)
	(ai_place sq_pod_01_jackal_01)
	
	(ai_cannot_die sq_pod_01_warthog_01 TRUE)	
	(ai_cannot_die sq_pod_01_warthog_02 TRUE)
	(ai_cannot_die sq_pod_01_chopper_01 TRUE)
	(ai_cannot_die sq_pod_01_chopper_02 TRUE)
	(ai_cannot_die sq_pod_01_chopper_03 TRUE)
	
	(ai_force_active gr_pod_01_cov TRUE)
	(ai_force_active gr_pod_01_allies TRUE)
)

(script dormant pod_01_place_02

	(sleep_until
		(= (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 2) 5)
		(ai_place sq_phantom_01)
		(game_save)
)

(script dormant pod_01_place_03

;(if (= (ai_task_count obj_pod_01_cov/gt_ghost) 0)
	;(ai_place sq_pod_01_ghost_02))
	(sleep 1)
)

;=============================== Wraith Firing Behavior =====================================================================================================================================================================================

(script command_script cs_pod_01_wraith_shoot

	(cs_run_command_script sq_pod_01_wraith_01/gunner abort_cs)	
	(cs_run_command_script sq_pod_01_wraith_02/gunner abort_cs)
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 0 150))
					(cs_shoot_point TRUE ps_pod_01_wraith/p0)
				)
				(begin
					(sleep (random_range 0 150))
					(cs_shoot_point TRUE ps_pod_01_wraith/p1)
				)
				(begin
					(sleep (random_range 0 150))
					(cs_shoot_point TRUE ps_pod_01_wraith/p2)
				)
			)
			FALSE
		)
	)
)

;=============================== phantom_01 =====================================================================================================================================================================================

(global vehicle phantom_01 none)
(script command_script cs_phantom_01

	(if debug (print "phantom 01"))
	(set phantom_01 (ai_vehicle_get_from_starting_location sq_phantom_01/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_01_jackal_01)
;		(ai_place sq_phantom_01_jackal_02)		
		(ai_place sq_phantom_01_cov_01)
;		(ai_place sq_phantom_01_cov_02)
		(ai_place sq_phantom_01_ghost_01)
		
		(ai_force_active gr_phantom_01 TRUE)

			(sleep 5)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_01_jackal_01 phantom_01 "phantom_p_mr_b")
		(ai_vehicle_enter_immediate sq_phantom_01_jackal_02 phantom_01 "phantom_p_ml_b")
		(ai_vehicle_enter_immediate sq_phantom_01_cov_01 phantom_01 "phantom_p_rb")		
		(ai_vehicle_enter_immediate sq_phantom_01_cov_02 phantom_01 "phantom_p_lb")
		(vehicle_load_magic phantom_01 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_01_ghost_01/ghost))
		
			(sleep 1)

	; start movement 
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_01/approach_01)
	(cs_vehicle_boost FALSE)
	(cs_fly_by ps_phantom_01/approach_02)
	(cs_fly_by ps_phantom_01/approach_03)


	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_01/hover_01 ps_phantom_01/face_01 1)
		(unit_open phantom_01)
		(sleep 15)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_01/drop_01 ps_phantom_01/face_01 1)
		
		; set the objective
		(ai_set_objective sq_phantom_01 obj_pod_01_cov)
		(ai_set_objective gr_phantom_01 obj_pod_01_cov)
	
		;drop		
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
		(vehicle_unload phantom_01  "phantom_p_rb")
		(vehicle_unload phantom_01  "phantom_p_lb")
		(sleep 15)
		(vehicle_unload phantom_01 "phantom_p_mr_b")
		(vehicle_unload phantom_01 "phantom_p_ml_b")
		(sleep 75)

		(cs_fly_to_and_face ps_phantom_01/hover_01 ps_phantom_01/face_01 1)
		
	(unit_close phantom_01)
	(sleep (random_range 60 90))
	(cs_vehicle_speed 1.0)

	(cs_fly_by ps_phantom_01/exit_01)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_01/erase)
	(ai_erase ai_current_squad)
)

(script dormant pod_01_drone

	(device_set_position drone_fighter_01 1)
	
	(sound_impulse_start sound\device_machines\040vc_longsword\start drone_fighter_01 1)
		
		(sleep (* 30 8))
		
	(object_destroy drone_fighter_01)
)
	
;====================================================================================================================================================================================================
;=============================== POD_2 ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_pod_02

	;Trigger Volumes

	(sleep_until (volume_test_players tv_pod_02_01) 1)
	(if debug (print "set objective control 1"))
	(set g_pod_02_obj_control 1)
	(game_save)

	(sleep_until (volume_test_players tv_pod_02_02) 1)
	(if debug (print "set objective control 2"))
	(set g_pod_02_obj_control 2)	
	
	(sleep_until (volume_test_players tv_pod_02_03) 1)
	(if debug (print "set objective control 3"))
	(set g_pod_02_obj_control 3)
	(wake pod_02_banshee)

	(sleep_until (volume_test_players tv_pod_02_04) 1)
	(if debug (print "set objective control 4"))
	(set g_pod_02_obj_control 4)
	(wake pod_02_ghost_escape)
	(game_save)

	(sleep_until (volume_test_players tv_pod_02_05) 1)
	(if debug (print "set objective control 5"))
	(set g_pod_02_obj_control 5)
	(wake pod_02_place_03)
	
	(sleep_until (volume_test_players tv_pod_02_06) 1)
	(if debug (print "set objective control 6"))
	(set g_pod_02_obj_control 6)
	(wake enc_pod_03)
	(wake pod_03_place_01)
	(game_save)	

)

;=============================== POD_2 secondary scripts =======================================================================================================================================

(script dormant pod_02_place_01
	
	;initial placement
	(ai_place sq_pod_02_jackal_01)
	(ai_place sq_pod_02_shade_01)
	(ai_place sq_pod_02_shade_02)
	(ai_place sq_pod_02_shade_03)	
	(ai_place sq_pod_02_brute_01)
	(ai_place sq_pod_02_chopper_01)
	(ai_place sq_pod_02_ghost_01)
	(ai_place sq_pod_02_ghost_03)	
	(ai_place sq_pod_02_grunt_01)
	(ai_place sq_pod_02_grunt_02)	
	(ai_place sq_pod_02_cov_01)
	(ai_place sq_pod_02_cov_02)
	(sleep 1)
	
	(ai_force_active gr_pod_02_cov TRUE)

)

(script dormant pod_02_place_02

	(ai_place sq_pod_02_banshee_01)
	(ai_place sq_pod_02_banshee_02)
	
	(ai_force_active gr_pod_02_cov TRUE)
)

(script dormant pod_02_place_03
	(ai_place sq_phantom_02)

)

;=============================== Attacking Ridge Ghost =========================================================================

(script command_script cs_pod_02_ghost_01
	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_go_to_vehicle (ai_vehicle_get_from_starting_location sq_pod_02_ghost_01/ghost))
	(ai_vehicle_enter sq_pod_02_ghost_01 sq_pod_02_ghost_01/ghost "ghost_d")
		
		(cs_enable_targeting FALSE)
		(cs_enable_looking FALSE)
		
		(cs_vehicle_boost TRUE)
	(cs_go_to ps_pod_02_ghost/p0)
)	

(script command_script cs_pod_02_chopper_01
		(sleep 35)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to_vehicle (ai_vehicle_get_from_starting_location sq_pod_02_chopper_01/chopper))
	(ai_vehicle_enter sq_pod_02_chopper_01 sq_pod_02_chopper_01/chopper "chopper_d")
	(cs_go_to ps_pod_02_chopper/p0)
)	

;=============================== Banshee =========================================================================

(script dormant pod_02_banshee

	(sleep_until
		(volume_test_players tv_pod_02_banshee)
	1)

	(wake pod_02_place_02)
	(game_save)
)	


;	Simple Banshee introduction

(script command_script cs_pod_02_banshee
	(cs_vehicle_boost TRUE)
		(sleep (random_range 250 280))
	(cs_vehicle_boost FALSE)
)

;	Banshee retreat

(script command_script cs_pod_02_banshee_R

	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_02_banshee/run_01)
	(cs_fly_by ps_pod_02_banshee/exit)
	(cs_fly_by ps_pod_02_banshee/erase)
		(ai_erase ai_current_squad)
)
	

;=============================== Drones =========================================================================

(script dormant pod_02_drone

	(device_set_position drone_fighter_02 1)
	(device_set_position drone_fighter_03 1)
	
	(sound_impulse_start sound\device_machines\040vc_longsword\start drone_fighter_02 1)
	(sound_impulse_start sound\device_machines\040vc_longsword\start drone_fighter_03 1)
	
		(sleep (* 30 8))
		
	(object_destroy drone_fighter_02)
	(object_destroy drone_fighter_03)
)

;=============================== Running Ridge Ghost + Drone trigger =========================================================================

(script dormant pod_02_ghost_escape

	(sleep_until
		(volume_test_players tv_pod_02_ghost_escape)
	1)
	(set g_pod_02_ghost_escape 1)
	
	(wake pod_02_drone)
	
)

(script command_script cs_pod_02_ghost_escape
		(cs_enable_pathfinding_failsafe TRUE)
		
		(cs_enable_targeting FALSE)
		(cs_enable_looking FALSE)
		
			(cs_vehicle_boost TRUE)
		(cs_go_to ps_ghost_escape/run_01)
		(cs_go_to ps_ghost_escape/run_02)
		(cs_go_to ps_ghost_escape/run_03)
		(cs_go_to ps_ghost_escape/run_04)
		(cs_go_to ps_ghost_escape/run_05)
		(cs_go_to ps_ghost_escape/run_06)
		(cs_go_to ps_ghost_escape/run_07)
		(cs_go_to ps_ghost_escape/run_08)
		(cs_go_to ps_ghost_escape/run_09)
		(cs_go_to ps_ghost_escape/run_10)
		(cs_go_to ps_ghost_escape/run_11)
			(cs_vehicle_boost FALSE)
			
		(set g_pod_02_ghost_escape 2)

	(ai_set_objective sq_pod_02_ghost_03 obj_pod_03_cov)	
)

;=============================== phantom_02 =====================================================================================================================================================================================

(global vehicle phantom_02 none)
(script command_script cs_phantom_02

	(if debug (print "phantom 02"))
	(set phantom_02 (ai_vehicle_get_from_starting_location sq_phantom_02/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_02_cov_01)
		(ai_place sq_phantom_02_cov_02)
		(ai_place sq_phantom_02_ghost_01)
;		(ai_place sq_phantom_02_jackal_01)
		
		(ai_force_active gr_phantom_02 TRUE)

			(sleep 5)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_02_cov_01 phantom_02 "phantom_p_lf")		
		(ai_vehicle_enter_immediate sq_phantom_02_cov_02 phantom_02 "phantom_p_lb")
		(ai_vehicle_enter_immediate sq_phantom_02_jackal_01 phantom_02 "phantom_p_ml_b")		
		(vehicle_load_magic phantom_02 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_02_ghost_01/ghost))
		
			(sleep 1)

		; set the objective
		(ai_set_objective sq_phantom_02 obj_pod_03_cov)
		(ai_set_objective gr_phantom_02 obj_pod_03_cov)

	; start movement 
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_02/approach_01)
		(cs_vehicle_boost FALSE)
	(cs_fly_by ps_phantom_02/approach_02)
	(cs_fly_by ps_phantom_02/approach_03)
	(cs_vehicle_speed .6)
	(cs_fly_by ps_phantom_02/approach_04)
	(cs_fly_to_and_face ps_phantom_02/hover_01 ps_phantom_02/face_01 1)
	(ai_cannot_die sq_phantom_02 TRUE)	
	
	(sleep_until
		(>= g_pod_03_obj_control 1)
	1)
		
	(ai_cannot_die sq_phantom_02 FALSE)		
		(sleep (random_range (* 30 2) (* 30 4)))
		
	; == drone ====================================================
		(wake pod_03_drone)		
		
	(cs_vehicle_speed 1)
	(cs_fly_by ps_phantom_02/approach_05)
	
	(cs_vehicle_speed .75)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_02/hover_02 ps_phantom_02/face_02 1)
			(sleep 15)
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_02/drop_02 ps_phantom_02/face_02 1)
	
		;drop		
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
			(sleep 30)

	(cs_fly_by ps_phantom_02/approach_06)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_02/hover_03 ps_phantom_02/face_03 1)
		(unit_open phantom_02)
			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_02/drop_03 ps_phantom_02/face_03 1)
			(sleep 15)

		; drop 
		(vehicle_unload phantom_02 "phantom_p_lf")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_02 "phantom_p_lb")
			(sleep (random_range 5 15))
		(vehicle_unload phantom_02 "phantom_p_ml_b")
		(sleep 75)

		(cs_fly_to_and_face ps_phantom_02/hover_04 ps_phantom_02/face_04 1)
		
	(unit_close phantom_02)
	(sleep (random_range 120 150))
	(cs_vehicle_speed 1.0)

	(cs_fly_by ps_phantom_02/exit_01)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_02/erase)
	(ai_erase ai_current_squad)
)

;====================================================================================================================================================================================================
;=============================== POD_3 ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_pod_03

	;Trigger Volumes

	(sleep_until (volume_test_players tv_pod_03_01) 1)
	(if debug (print "set objective control 1"))
	(set g_pod_03_obj_control 1)
	(game_save)
	
	(ai_cannot_die sq_pod_03_warthog_01 FALSE)	
	(ai_cannot_die sq_pod_01_chopper_01 FALSE)

	(sleep_until (volume_test_players tv_pod_03_02) 1)
	(if debug (print "set objective control 2"))
	(set g_pod_03_obj_control 2)
	(wake pod_03_game_save_01)
	(game_save)

	(sleep_until (volume_test_players tv_pod_03_03) 1)
	(if debug (print "set objective control 3"))
	(set g_pod_03_obj_control 3)
	(game_save)
	
	(sleep_until (volume_test_players tv_pod_03_04) 1)
	(if debug (print "set objective control 4"))
	(set g_pod_03_obj_control 4)
	(game_save)

	(sleep_until (volume_test_players tv_pod_03_05) 1)
	(if debug (print "set objective control 5"))
	(set g_pod_03_obj_control 5)
	(wake enc_pod_04)
;	(wake pod_04_place_01)
	(the_fall)
	(game_save)

	(sleep_until (volume_test_players tv_pod_03_06) 1)
	(if debug (print "set objective control 6"))
	(set g_pod_03_obj_control 6)
	
)

;=============================== POD_3 secondary scripts =======================================================================================================================================

(script dormant pod_03_place_01
	
	(ai_place sq_pod_03_wraith_01)	
	(ai_place sq_pod_03_wraith_02)
	(ai_place sq_pod_03_allies_01)
	(ai_place sq_pod_03_allies_02)
	(ai_place sq_pod_03_allies_03)
	(ai_place sq_pod_03_warthog_01)
;	(ai_place sq_pod_03_warthog_02)
	(ai_place sq_pod_03_chopper_01)
	(ai_place sq_pod_03_chopper_02)
	(ai_place sq_pod_03_chopper_03)
	(ai_place sq_pod_03_watchtower_01)
	(ai_place sq_pod_03_shade_01)
	(ai_place sq_pod_03_shade_02)
	(ai_place sq_pod_03_shade_03)
	(ai_place sq_pod_03_shade_04)
	
		(sleep 5)
	
	(ai_force_active gr_pod_03_cov TRUE)
	(ai_force_active gr_pod_03_allies TRUE)
	
	(ai_cannot_die sq_pod_03_warthog_01 TRUE)	
	(ai_cannot_die sq_pod_01_chopper_01 TRUE)

)

(script dormant pod_03_game_save_01

	(sleep_until (= (ai_task_count obj_pod_03_cov/gt_pod_03_wraith) 0) 5)
	
	(game_save)
	
)

;=============================== Drones =========================================================================

(script dormant pod_03_drone

	(sleep 30)

	(device_set_position drone_fighter_04 1)
	(device_set_position drone_fighter_05 1)
	(device_set_position drone_fighter_06 1)

	(sound_impulse_start sound\device_machines\040vc_longsword\start drone_fighter_04 1)
	(sound_impulse_start sound\device_machines\040vc_longsword\start drone_fighter_05 1)
	(sound_impulse_start sound\device_machines\040vc_longsword\start drone_fighter_06 1)
		
		(sleep (* 30 8))
		
	(object_destroy drone_fighter_04)
	(object_destroy drone_fighter_05)
	(object_destroy drone_fighter_06)	
)

;=============================== Wraith Firing Behavior =====================================================================================================================================================================================

(script command_script cs_pod_03_wraith_shoot

	(cs_run_command_script sq_pod_03_wraith_01/gunner abort_cs)	
	(cs_run_command_script sq_pod_03_wraith_02/gunner abort_cs)
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 60 210))
					(cs_shoot_point TRUE ps_pod_03_wraith/p0)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_pod_03_wraith/p1)
				)
				(begin
					(sleep (random_range 90 210))
					(cs_shoot_point TRUE ps_pod_03_wraith/p2)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_pod_03_wraith/p3)
				)
				(begin
					(sleep (random_range 30 210))
					(cs_shoot_point TRUE ps_pod_03_wraith/p4)
				)				
			)
			FALSE
		)
	)
)

;=============================== Allied turret =====================================================================================================================================================================================

(script command_script cs_pod_03_allies_04

	(cs_enable_pathfinding_failsafe TRUE)
	
	(cs_go_to_vehicle pod_03_turret_01)
	(ai_vehicle_enter sq_pod_03_allies_04 pod_03_turret_01 "warthog_g")
)

;====================================================================================================================================================================================================
;=============================== POD_4 ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_pod_04

	;Trigger Volumes

	(sleep_until (volume_test_players tv_pod_04_01) 1)
	(if debug (print "set objective control 1"))
	(set g_pod_04_obj_control 1)
	(wake pod_04_place_02)
	(wake level_end)
	(game_save)

	(sleep_until (volume_test_players tv_pod_04_02) 1)
	(if debug (print "set objective control 2"))
	(set g_pod_04_obj_control 2)
	(wake pod_04_place_03)
	(game_save)
	
	(sleep_until (volume_test_players tv_pod_04_03) 1)
	(if debug (print "set objective control 3"))
	(set g_pod_04_obj_control 3)
	(game_save)

	(sleep_until (volume_test_players tv_pod_04_04) 1)
	(if debug (print "set objective control 4"))
	(set g_pod_04_obj_control 4)
	(game_save)

	(sleep_until (volume_test_players tv_pod_04_05) 1)
	(if debug (print "set objective control 5"))
	(set g_pod_04_obj_control 5)
	
	(sleep_until (volume_test_players tv_pod_04_06) 1)
	(if debug (print "set objective control 6"))
	(set g_pod_04_obj_control 6)
		
	(sleep_until (volume_test_players tv_pod_04_07) 1)
	(if debug (print "set objective control 7"))
	(set g_pod_04_obj_control 7)
	(wake pod_04_place_04)
	(wake pod_04_drone)
	(game_save)

	(sleep_until (volume_test_players tv_pod_04_08) 1)
	(if debug (print "set objective control 8"))
	(set g_pod_04_obj_control 8)
	(game_save)
	
	(sleep_until (volume_test_players tv_pod_04_09) 1)
	(if debug (print "set objective control 9"))
	(set g_pod_04_obj_control 9)
		
	(sleep_until (volume_test_players tv_pod_04_10) 1)
	(if debug (print "set objective control 10"))
	(set g_pod_04_obj_control 10)

)

;=============================== POD_4 secondary scripts =======================================================================================================================================

(script dormant pod_04_place_01
	
	(ai_place sq_pod_04_banshee_01)
	(ai_place sq_pod_04_banshee_02)
	
	(ai_force_active gr_pod_04_cov TRUE)

)

(script dormant pod_04_place_02

	(ai_place sq_pod_04_phantom_01)
	(ai_force_active gr_pod_04_phantom_01 TRUE)

;	(ai_place sq_pod_04_ghost_01)
	(ai_place sq_pod_04_shade_01)
	(ai_place sq_pod_04_shade_02)
;	(ai_place sq_pod_04_shade_03)
	(ai_place sq_pod_04_watchtower_01)
	(ai_place sq_pod_04_jackal_01)
	(ai_place sq_pod_04_grunt_01)
	(ai_place sq_pod_04_grunt_02)
	
	(ai_place sq_pod_04_wraith_01)
	(ai_place sq_pod_04_ghost_02)
	(ai_place sq_pod_04_shade_04)
	(ai_place sq_pod_04_jackal_02)
	(ai_place sq_pod_04_jackal_03)
	(ai_place sq_pod_04_cov_01)
	(ai_place sq_pod_04_cov_02)
	(ai_place sq_pod_04_allies_01)
	(ai_place sq_pod_04_allies_02)
	
	(ai_place sq_pod_04_brute_01)
	(ai_place sq_pod_04_brute_02)
	
	(ai_force_active gr_pod_04_cov TRUE)
	(ai_force_active gr_pod_04_allies TRUE)
	
		
)

(script dormant pod_04_place_03

	(sleep_until 
		(volume_test_players tv_pod_04_phantom_02)
	1)

	(game_save)
	(ai_place sq_pod_04_phantom_02)
	(ai_force_active gr_pod_04_phantom_02 TRUE)
)

(script dormant pod_04_place_04

	(ai_disposable gr_pod_04_cov_lower TRUE)

	(ai_place sq_pod_04_phantom_03)
	(ai_force_active gr_pod_04_phantom_03 TRUE)
	(ai_place sq_pod_04_phantom_04)
	(ai_force_active gr_pod_04_phantom_04 TRUE)

	(ai_place sq_pod_04_grunt_03)
	(ai_place sq_pod_04_grunt_04)
	(ai_place sq_pod_04_grunt_05)	
	(ai_place sq_pod_04_plasma_cannon_01)
	(ai_place sq_pod_04_brute_03)
	(ai_place sq_pod_04_jackal_04)
	(ai_place sq_pod_04_wraith_02)
	
	(ai_force_active gr_pod_04_cov TRUE)
)
;=============================== ghost introduction =======================================================================================================================================

(script command_script cs_pod_04_ghost_01
		(cs_enable_pathfinding_failsafe TRUE)
		(cs_enable_targeting FALSE)
		(cs_enable_looking FALSE)

			(cs_vehicle_boost TRUE)
		(cs_go_to ps_pod_04_ghost/run_02)
		(cs_go_to ps_pod_04_ghost/run_03)
		(cs_go_to ps_pod_04_ghost/run_04)
		(cs_go_to ps_pod_04_ghost/run_05)
		(cs_go_to ps_pod_04_ghost/run_06)
		(cs_go_to ps_pod_04_ghost/run_07)
		(cs_go_to ps_pod_04_ghost/run_08)
			(cs_vehicle_boost FALSE)
)

;=============================== ghost pursuit =======================================================================================================================================

(script command_script cs_pod_04_ghost_01_R
	(cs_enable_pathfinding_failsafe TRUE)
		(cs_enable_targeting TRUE)
		(cs_enable_looking TRUE)

		(cs_go_to ps_pod_04_ghost/run_08)
		(cs_go_to ps_pod_04_ghost/run_07)		
		(cs_go_to ps_pod_04_ghost/run_06)
		(cs_go_to ps_pod_04_ghost/run_05)	
		(cs_go_to ps_pod_04_ghost/run_04)
		(cs_go_to ps_pod_04_ghost/run_03)
		(cs_go_to ps_pod_04_ghost/run_02)

)

;=============================== Bridge Banshee ========================================================================

(script command_script cs_pod_04_banshee_01
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_banshee_bridge/approach_01)
(cs_fly_by ps_banshee_bridge/run_01)
(cs_fly_by ps_banshee_bridge/turn_01)
	(cs_vehicle_boost FALSE)
)

(script command_script cs_pod_04_banshee_02
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)	
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_banshee_bridge/approach_02)
(cs_fly_by ps_banshee_bridge/run_02)
(cs_fly_by ps_banshee_bridge/turn_02)
	(cs_vehicle_boost FALSE)
)

(script command_script cs_pod_04_banshee_01_R
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_banshee_bridge_retreat/approach_01)
(cs_fly_by ps_banshee_bridge_retreat/run_01)
(cs_fly_by ps_banshee_bridge_retreat/turn_01)
	(cs_vehicle_boost FALSE)
)

(script command_script cs_pod_04_banshee_02_R
	
(cs_enable_targeting TRUE)
(cs_enable_looking TRUE)	
	(cs_vehicle_boost TRUE)
(cs_fly_by ps_banshee_bridge_retreat/approach_02)
(cs_fly_by ps_banshee_bridge_retreat/run_02)
(cs_fly_by ps_banshee_bridge_retreat/turn_02)
	(cs_vehicle_boost FALSE)
)

;=============================== Wraith Firing Behavior =====================================================================================================================================================================================

; into

(script command_script cs_pod_04_wraith_intro

	(cs_run_command_script sq_pod_04_wraith_01/gunner abort_cs)
	(cs_enable_moving TRUE)	
	
	(sleep_until
		(begin
			(sleep 45)
			(cs_shoot_point TRUE ps_pod_04_wraith/p0)
		FALSE)
	)
)

; intro #2

(script command_script cs_pod_04_wraith_shoot

	(cs_run_command_script sq_pod_04_wraith_01/gunner abort_cs)	
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_pod_04_wraith/p1)
				)
				(begin
					(sleep (random_range 90 210))
					(cs_shoot_point TRUE ps_pod_04_wraith/p2)
				)
				(begin
					(sleep (random_range 120 210))
					(cs_shoot_point TRUE ps_pod_04_wraith/p3)
				)			
			)
			FALSE
		)
	)
)

;=============================== pod_04_phantom_01 =====================================================================================================================================================================================

(script command_script cs_pod_04_phantom_01

	(if debug (print "pod_04_phantom_01"))
	
	; start movement 

	(cs_fly_by ps_pod_04_phantom_01/approach_01)
	(cs_fly_by ps_pod_04_phantom_01/approach_02)
	(cs_fly_by ps_pod_04_phantom_01/approach_03)
	
	(cs_fly_by ps_pod_04_phantom_01/exit_01)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_04_phantom_01/erase)
	(ai_erase ai_current_squad)
)

;=============================== Drones =========================================================================

(script dormant pod_04_drone

	(sleep_until (volume_test_players tv_pod_04_drone) 1)

	(object_create drone_fighter_07)
	(object_create drone_fighter_08)
	(object_create drone_fighter_09)	
	(object_create drone_fighter_10)	

	(device_set_position drone_fighter_07 1)
	(device_set_position drone_fighter_08 1)
	(device_set_position drone_fighter_09 1)
	(device_set_position drone_fighter_10 1)

	(sound_impulse_start sound\device_machines\040vc_longsword\start drone_fighter_07 1)
	(sound_impulse_start sound\device_machines\040vc_longsword\start drone_fighter_08 1)
	(sound_impulse_start sound\device_machines\040vc_longsword\start drone_fighter_09 1)
	(sound_impulse_start sound\device_machines\040vc_longsword\start drone_fighter_10 1)		
		(sleep (* 30 8))
		
	(object_destroy drone_fighter_07)
	(object_destroy drone_fighter_08)
	(object_destroy drone_fighter_09)	
	(object_destroy drone_fighter_10)	
)

;=============================== pod_04_phantom_02 =====================================================================================================================================================================================

(global vehicle p_04_phantom_02 none)
(script command_script cs_pod_04_phantom_02

	(if debug (print "pod_04_phantom_02"))
	(set p_04_phantom_02 (ai_vehicle_get_from_starting_location sq_pod_04_phantom_02/phantom))

	; == spawning ====================================================
		(ai_place sq_pod_04_phantom_02_wraith)
			(sleep 5)
			
	; == seating ====================================================		
		(vehicle_load_magic p_04_phantom_02 "phantom_lc" (ai_vehicle_get_from_starting_location sq_pod_04_phantom_02_wraith/wraith))
			(sleep 1)

	; start movement 
	(cs_fly_by ps_pod_04_phantom_02/approach_01)
	(cs_fly_by ps_pod_04_phantom_02/approach_02)
	(cs_fly_by ps_pod_04_phantom_02/exit_01)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_04_phantom_02/erase)
	(ai_erase sq_pod_04_phantom_02_wraith)
	(ai_erase ai_current_squad)
)

;=============================== pod_04_phantom_03 =====================================================================================================================================================================================

(script command_script cs_pod_04_phantom_03

	(if debug (print "pod_04_phantom_03"))
	
	; start movement 

	(cs_fly_by ps_pod_04_phantom_03/approach_01)
	(cs_fly_by ps_pod_04_phantom_03/exit_01)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_04_phantom_03/erase)
	(ai_erase ai_current_squad)
)

;=============================== pod_04_phantom_04 =====================================================================================================================================================================================

(global vehicle p_04_phantom_04 none)
(script command_script cs_pod_04_phantom_04

	(if debug (print "pod_04_phantom_04"))
	(set p_04_phantom_04 (ai_vehicle_get_from_starting_location sq_pod_04_phantom_04/phantom))

	; == spawning ====================================================
		(ai_place sq_pod_04_phantom_04_wraith)
			(sleep 5)
			
	; == seating ====================================================		
		(vehicle_load_magic p_04_phantom_04 "phantom_lc" (ai_vehicle_get_from_starting_location sq_pod_04_phantom_04_wraith/wraith))
			(sleep 1)

	; start movement 
	(cs_fly_to_and_face ps_pod_04_phantom_04/drop_01 ps_pod_04_phantom_04/face_01 1)
	
	(sleep_until (volume_test_players tv_pod_04_09) 1)
	
	(cs_fly_to_and_face ps_pod_04_phantom_04/hover_01 ps_pod_04_phantom_04/face_01 1)
		(sleep 30)

	(cs_fly_by ps_pod_04_phantom_04/exit_01)
		(cs_vehicle_boost TRUE)
	(cs_fly_by ps_pod_04_phantom_04/erase)
	(ai_erase sq_pod_04_phantom_04_wraith)
	(ai_erase ai_current_squad)
)

;=============================== level end =====================================================================================================================================================================================

(script dormant level_end
		(sleep 1)
		
		(sleep_until (volume_test_players tv_pod_04_10) 1)

; fade to black 
	(cinematic_fade_to_black)
		(sleep 1)
	
	; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						(if debug (print "sc110_out_sc"))
;						(sc110_out_sc)
					)
				)
				(cinematic_skip_stop)
				
			)
		)
		
	(sleep 5)
	(gp_boolean_set gp_sc110_complete TRUE)
	(end_scene)
)
