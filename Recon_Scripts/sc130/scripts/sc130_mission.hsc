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
(global short g_bridge_obj_control 0)
(global short g_main_arena_obj_control 0)
(global short g_lobby_obj_control 0)
(global short g_roof_obj_control 0)
(global short g_bridge_allies_advance 0)
(global short g_main_arena_retreat 0)
(global short g_lobby_front 0)
(global short g_lobby_entry_ODST 0)
	;dialogue variables
(global short g_charge_reminder 0)
(global short g_bridge_tunnel 0)

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
;=============================== Scene 130 MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================
(script startup sc130_startup
	(if debug (print "sc130 mission script"))

	; fade out 
	(fade_out 0 0 0 0)
	
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
	(gp_integer_set gp_current_scene 130)
	(wake sc130_first)
)

(script dormant sc130_first
	(device_group_set dm_elev_side_01 dg_elev_side_01 .6)
	(device_group_set dm_elev_side_02 dg_elev_side_02 0.752)
	(device_group_set dm_charge_05 dg_charge_context 1)
	
	(ai_allegiance human player)
	(ai_allegiance player human)

		; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						;fade to black
						(cinematic_snap_to_black)
						(if debug (print "sc130_in_sc"))	
							(sleep 60)	
						(cinematic_set_title title_1)
							(sleep 60)
						(cinematic_set_title title_2)
						(sleep (* 30 5))
						(sc130_in_sc)
					)
				)
				(cinematic_skip_stop)
			)
		)

;	start initial encounter
	(wake enc_bridge)
	(wake bridge_place_01)
	(sleep 1)
				
	(cinematic_fade_to_gameplay)
	
	;dialogue
	(wake md_010_charge_01)
	(wake md_010_charge_reminder_01)
	(wake md_010_charge_reminder_02)
	(wake md_010_charge_02)
)

;====================================================================================================================================================================================================
;=============================== Bridge ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_bridge

	;Trigger Volumes

	(sleep_until (volume_test_players tv_bridge_01) 1)
	(if debug (print "set objective control 1"))
	(set g_bridge_obj_control 1)
	(wake bridge_place_02)

	(sleep_until (volume_test_players tv_bridge_02) 1)
	(if debug (print "set objective control 2"))
	(set g_bridge_obj_control 2)
	
	(sleep_until (volume_test_players tv_bridge_03) 1)
	(if debug (print "set objective control 3"))
	(set g_bridge_obj_control 3)
	(wake md_010_final_charge)

	(sleep_until (volume_test_players tv_bridge_04) 1)
	(if debug (print "set objective control 4"))
	(set g_bridge_obj_control 4)

	(sleep_until (volume_test_players tv_bridge_05) 1)
	(if debug (print "set objective control 5"))
	(set g_bridge_obj_control 5)
;	(wake bridge_detonation)
	(wake enc_main_arena)
	(wake bridge_place_03)
	(game_save)
)

;=============================== Bridge secondary scripts =======================================================================================================================================

(script dormant bridge_place_01
	
	;initial placement
	(ai_place sq_bridge_wraith_01)
	(ai_place sq_bridge_wraith_02)
	(ai_place sq_bridge_wraith_03)
	(ai_place sq_bridge_cov_01)
	(ai_place sq_bridge_cov_02)
	(ai_place sq_bridge_cov_03)
	(ai_place sq_bridge_cov_04)
	(ai_place sq_bridge_cov_05)
	(ai_place sq_bridge_ODST)
	(ai_place sq_bridge_allies_01)
	(ai_place sq_bridge_allies_02)
	(ai_place sq_bridge_civ_01)
	
	(ai_cannot_die sq_bridge_ODST TRUE)
	(wake ODST_bridge_falloff)
	(ai_cannot_die sq_bridge_civ_01 TRUE)	
	(object_cannot_take_damage tower_base)
	(wake bridge_charge)
	(wake watchtower_charge)
	(wake nav_point_charge)
	(bridge_explode)
	
)

(script command_script cs_bridge_allies_initial_01
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_bridge_allies_initial/p0)	
)

(script command_script cs_bridge_allies_initial_02
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_bridge_allies_initial/p1)	
)

(script dormant bridge_place_02
	(sleep_until
		(or
			(volume_test_players tv_bridge_04)
			(volume_test_players tv_bridge_00)
		) 
	1)
	(ai_place sq_phantom_01)
)

(script dormant bridge_place_03
	(sleep 90)
	(ai_place sq_bridge_banshee_01)
)

;=============================== Wraith Firing Behavior =====================================================================================================================================================================================

(script command_script cs_bridge_wraith_shoot

	(cs_run_command_script sq_bridge_wraith_01/gunner abort_cs)	
	(cs_run_command_script sq_bridge_wraith_02/gunner abort_cs)
	(cs_run_command_script sq_bridge_wraith_03/gunner abort_cs)
	(cs_run_command_script sq_phantom_wraith_01/gunner abort_cs)
	(cs_abort_on_damage TRUE)	
	(cs_enable_moving TRUE)
	(sleep_until
		(begin
			(begin_random
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_bridge_wraith/p0)
				)
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_bridge_wraith/p1)
				)
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_bridge_wraith/p2)
				)
				(begin
					(sleep (random_range 60 150))
					(cs_shoot_point TRUE ps_bridge_wraith/p3)
				)
			)
			FALSE
		)
	)
)

;=============================== phantom_01 ============================================================================	

(global vehicle phantom_01 none)
(script command_script cs_phantom_01

	(if debug (print "phantom 01"))
	(set phantom_01 (ai_vehicle_get_from_starting_location sq_phantom_01/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_cov_01)
		(ai_place sq_phantom_cov_02)
		(ai_place sq_phantom_cov_03)
	(if
		(<= (ai_task_count obj_bridge_cov/gt_bridge_wraith) 4)
		(ai_place sq_phantom_wraith_01)
	)
			(sleep 30)

	; == seating ====================================================		
		(vehicle_load_magic phantom_01 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_wraith_01/wraith))
		(ai_vehicle_enter_immediate sq_phantom_cov_01 phantom_01 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_cov_02 phantom_01 "phantom_p_rb")
		(ai_vehicle_enter_immediate sq_phantom_cov_03 phantom_01 "phantom_p_mr_b")
			(sleep 1)
		
		; set the objective
		(ai_set_objective sq_phantom_01 obj_bridge_cov)
		(ai_set_objective gr_phantom_drop_01 obj_bridge_cov)

	; start movement 
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_01/approach_01)
	(cs_vehicle_boost FALSE)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_01/hover_01 ps_phantom_01/face_01 1)
		(unit_open phantom_01)
			(sleep 30)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_01/drop_01 ps_phantom_01/face_01 1)
			(sleep 15)

		; drop 
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
		(ai_set_objective sq_phantom_wraith_01 obj_bridge_cov) 
			(sleep 30)
			
(begin_random
			(begin
				(vehicle_unload phantom_01 "phantom_p_rf")
				(sleep (random_range 5 15))
			)
			(begin
				(vehicle_unload phantom_01 "phantom_p_rb")
				(sleep (random_range 5 15))
			)
			(begin
				(vehicle_unload phantom_01 "phantom_p_mr_b")
				(sleep (random_range 5 15))
			)
)			
			(sleep 90)

		(cs_fly_to_and_face ps_phantom_01/hover_01 ps_phantom_01/face_01 1)

	(unit_close phantom_01)
	(cs_vehicle_speed 0.2)			
		(sleep (* 30 10))
		(cs_fly_to_and_face ps_phantom_01/hover_02 ps_phantom_01/face_02 1)
		
	(sleep_until
		(or
			(<= (ai_task_count obj_bridge_cov/gt_bridge_phantom) 2)
			(= (device_group_get dg_laptop_01) 1)
		)	
	)	
	
	(cs_vehicle_speed 1.0)
	(cs_fly_by ps_phantom_01/exit_01)
	(cs_fly_by ps_phantom_01/erase)
	(ai_erase ai_current_squad)
)

;=============================== ODST behavior =====================================================================================================================================================================================

(script dormant ODST_bridge_falloff
	
	;(sleep_until
	;	(volume_test_object tv_ODST (ai_get_object sq_bridge_ODST/ODST))
	;)
	(sleep 1)
)

(script dormant bridge_charge

	(sleep_until
		(>= g_bridge_obj_control 3)
		5 (* 30 25))
				
			(if 
				(and
					(= (device_group_get dg_charge_01) 0)
					(not (volume_test_object tv_ODST (ai_get_object sq_bridge_ODST/ODST)))
				)
				(cs_run_command_script sq_bridge_ODST sq_bridge_ODST_charge_01)
			)
		
	(sleep_until
		(and
			(>= g_bridge_obj_control 4)
			(= (device_group_get dg_charge_01) 1)
		)
		5 (* 30 25))
	
			(if 
				(and
					(= (device_group_get dg_charge_02) 0)
					(not (volume_test_object tv_ODST (ai_get_object sq_bridge_ODST/ODST)))
				)	
				(cs_run_command_script sq_bridge_ODST sq_bridge_ODST_charge_02)
			)

	(sleep_until
		(and
			(>= g_bridge_obj_control 5)
			(= (device_group_get dg_charge_01) 1)
			(= (device_group_get dg_charge_02) 1)
		)
		5 )
	
			(if 
				(and
					(= (device_group_get dg_charge_03) 0)
					(not (volume_test_object tv_ODST (ai_get_object sq_bridge_ODST/ODST)))
				)
				(cs_run_command_script sq_bridge_ODST sq_bridge_ODST_charge_03)
			)	
)

(script command_script sq_bridge_ODST_charge_01
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to_and_face ps_bridge_ODST/p_charge_01 ps_bridge_ODST/p_charge_01_face)
	(device_group_set dm_charge_01 dg_charge_01 1)
	(set g_charge_reminder (+ g_charge_reminder 1))
)

(script command_script sq_bridge_ODST_charge_02
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to_and_face ps_bridge_ODST/p_charge_02 ps_bridge_ODST/p_charge_02_face)
	(device_group_set dm_charge_02 dg_charge_02 1)
	(set g_charge_reminder (+ g_charge_reminder 1))
)

(script command_script sq_bridge_ODST_charge_03
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to_and_face ps_bridge_ODST/p_charge_03 ps_bridge_ODST/p_charge_03_face)
	(device_group_set dm_charge_03 dg_charge_03 1)
)

;=============================== Charge NavPoints =========================================================================================

(script dormant nav_point_charge

	(sleep_until
		(or
			(volume_test_players tv_bridge_05)
			(volume_test_players tv_bridge_00)
		)
	)		
	(wake nav_point_charge_01)
	(wake nav_point_charge_02)
	(wake nav_point_charge_03)
)

(script dormant nav_point_charge_01
	(if (= (device_group_get dg_charge_01) 0)
	(hud_activate_team_nav_point_flag player fl_charge_01 .5)
	)
	(sleep_until
		(= (device_group_get dg_charge_01) 1)
	)
	(hud_deactivate_team_nav_point_flag player fl_charge_01)
)	
(script dormant nav_point_charge_02
	(if (= (device_group_get dg_charge_02) 0)
	(hud_activate_team_nav_point_flag player fl_charge_02 .5)
	)
	(sleep_until
		(= (device_group_get dg_charge_02) 1)
	)
	(hud_deactivate_team_nav_point_flag player fl_charge_02)
)	
(script dormant nav_point_charge_03
	(if (= (device_group_get dg_charge_03) 0)
	(hud_activate_team_nav_point_flag player fl_charge_03 .5)
	)
	(sleep_until
		(= (device_group_get dg_charge_03) 1)
	)
	(hud_deactivate_team_nav_point_flag player fl_charge_03)
)

;=============================== Civ behavior =====================================================================================================================================================================================

(script dormant watchtower_charge

	(sleep (* 30 30))
	(sleep_until
		(and
			(volume_test_players tv_bridge_05)
			(= (device_group_get dg_charge_01) 1)
			(= (device_group_get dg_charge_02) 1)
			(= (device_group_get dg_charge_03) 1)
		)
	1)
	
	;dialogue
	(wake md_020_watchtower)
	(wake md_030_wait)
	
	(sleep (* 30 15))
	(sleep_until b_bridge_detonation_enable)
	(sleep_forever md_030_wait)
	(device_set_power c_laptop_01 1)
	
	;dialogue
	(wake md_030_civ_detonator)
	
	(hud_activate_team_nav_point_flag player fl_laptop .5)

)

(script command_script sq_bridge_civ_01_laptop_01
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to_and_face ps_bridge_civ/p_laptop_01 ps_bridge_civ/p_laptop_01_face)
	(device_group_set dm_laptop_01 dg_laptop_01 1)
)

;=============================== Bridge Detonation =====================================================================================================================================================================================

(script static void bridge_explode

	(sleep_until
		(= (device_group_get dg_laptop_01) 1)	
	)
	
;turn off scripts
	(sleep_forever md_030_civ_detonator)

;turn off marker		
		(hud_deactivate_team_nav_point_flag player fl_laptop)
;blow up bridge		
		(object_damage_damage_section bridge "base" .5)
			(sleep 30)
		(object_damage_damage_section bridge "base" .5)
			(sleep 30)
		(object_damage_damage_section bridge "base" .5)
			(sleep 30)
		(object_damage_damage_section bridge "base" .5)
			(sleep 30)			
;fire off final bridge script	
	(wake md_030_bridge_blown)
	
	;fire off final bridge script	
	(wake bridge_cleanup)	
)

;=============================== Banshee_01 =====================================================================================================================================================================================

(script command_script cs_banshee_01

	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_fly_by ps_banshee_01/approach_01)
	(cs_fly_by ps_banshee_01/run_01)
	(cs_fly_by ps_banshee_01/run_02)
	(cs_fly_by ps_banshee_01/run_03)
	(cs_fly_by ps_banshee_01/run_04)
	(cs_fly_by ps_banshee_01/exit_01)
	(cs_fly_by ps_banshee_01/erase)
	(ai_erase ai_current_squad)
)
;=============================== Bridge cleanup =====================================================================================================================================================================================

(script dormant bridge_cleanup
	
	(game_save)				
		(sleep 5)

;zone sets
	(switch_zone_set set_000_005_010)
		(sleep 5)

;place Hunters + open door
	(wake main_arena_place_01)		
	(sleep (random_range 150 300))
	(device_set_position dm_main_arena_door_01 1)

;allies fall back onto ramp	
	(set g_bridge_allies_advance 1)
	
	;civ killoff
	(ai_cannot_die sq_bridge_civ_01 FALSE)	
	(units_set_current_vitality (ai_actors sq_bridge_civ_01) .1 0)
	(units_set_maximum_vitality (ai_actors sq_bridge_civ_01) .1 0)


	(sleep_until
		(volume_test_players tv_bridge_exit) 1)
		
;dialogue variable		
		(set g_bridge_tunnel 1)
		
;advance into main_arena		
		(ai_set_objective sq_bridge_ODST obj_main_arena_allies)
		(ai_set_objective gr_bridge_allies obj_main_arena_allies)

;need to allow the the phantom_02 to escape before bringing in phantom_03
	(sleep (* 30 30))
	(wake main_arena_place_02)
)

(script command_script cs_main_arena_entry_01
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_main_arena_entry/main_arena_entry_01)	
)	

(script command_script cs_main_arena_entry_02
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_main_arena_entry/main_arena_entry_02)	
)	
	
;====================================================================================================================================================================================================
;=============================== main_arena ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_main_arena

	;Trigger Volumes

	(sleep_until (volume_test_players tv_main_arena_01) 1)
	(if debug (print "set objective control 1"))
	(set g_main_arena_obj_control 1)
	(ai_disposable gr_bridge_cov TRUE)
	(game_save)
	
	(sleep_until (volume_test_players tv_main_arena_02) 1)
	(if debug (print "set objective control 2"))
	(set g_main_arena_obj_control 2)
	(device_set_position dm_main_arena_door_01 0)
	
	(sleep 120)
	(switch_zone_set set_000_010)
	
	(units_set_current_vitality (ai_actors sq_bridge_allies_01) .1 0)
	(units_set_maximum_vitality (ai_actors sq_bridge_allies_01) .1 0)
	(units_set_current_vitality (ai_actors sq_bridge_allies_02) .1 0)
	(units_set_maximum_vitality (ai_actors sq_bridge_allies_02) .1 0)
	(units_set_current_vitality (ai_actors sq_main_arena_allies_front_01) .1 0)
	(units_set_maximum_vitality (ai_actors sq_main_arena_allies_front_01) .1 0)
	(units_set_current_vitality (ai_actors sq_main_arena_allies_front_02) .1 0)
	(units_set_maximum_vitality (ai_actors sq_main_arena_allies_front_02) .1 0)
	(game_save)

	(sleep_until (volume_test_players tv_main_arena_03) 1)
	(if debug (print "set objective control 3"))
	(set g_main_arena_obj_control 3)
	(wake enc_lobby)
	(game_save)
)

;=============================== main_arena secondary scripts =======================================================================================================================================

(script dormant main_arena_place_01
	
	;initial placement
	(ai_place sq_phantom_02)
	(ai_place sq_main_arena_allies_right)
	(ai_place sq_main_arena_allies_center)
	(ai_place sq_main_arena_allies_left)
	(ai_place sq_main_arena_allies_front_01)
	(ai_place sq_main_arena_allies_front_02)
	
	(ai_cannot_die sq_main_arena_allies_right TRUE)
	(ai_cannot_die sq_main_arena_allies_center TRUE)
	(ai_cannot_die sq_main_arena_allies_left TRUE)		
)
	
(script dormant main_arena_retreat_01	
	(sleep_until
	(< (ai_task_count obj_main_arena_allies/gt_main_arena_allies) 8)
	1 (* 30 60))
	(set g_main_arena_retreat 1)
	(wake md_040_brute_advance_01)
	(game_save)
)	

;allied retreat
(script command_script cs_main_arena_retreat_right
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_main_arena_retreat/right)	
)	

(script command_script cs_main_arena_retreat_center
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_main_arena_retreat/center)	
)	

(script command_script cs_main_arena_retreat_left
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to ps_main_arena_retreat/left)	
)		

(script dormant main_arena_place_02
	
	(sleep_until
		(and
			(<= (ai_task_count obj_main_arena_cov/gt_hunters) 0)
			(<= (ai_task_count obj_main_arena_cov/gt_phantom_02) 4)
			(>= g_main_arena_obj_control 2)
		)	
	)
	(ai_cannot_die sq_main_arena_allies_right FALSE)
	(ai_cannot_die sq_main_arena_allies_center FALSE)
	(ai_cannot_die sq_main_arena_allies_left FALSE)	
	(ai_place sq_phantom_03)
	(ai_place sq_phantom_04)
	
;Weaken the ring	
;	(units_set_current_vitality (ai_actors sq_main_arena_allies_right) .90 0)
;	(units_set_maximum_vitality (ai_actors sq_main_arena_allies_right) .90 0)
;	(units_set_current_vitality (ai_actors sq_main_arena_allies_left) .90 0)
;	(units_set_maximum_vitality (ai_actors sq_main_arena_allies_left) .90 0)	

	(game_save)
)

(script dormant main_arena_place_03

	(sleep_until
		(<= (ai_task_count obj_main_arena_cov/gt_main_arena_cov) 10)
	)
	(ai_place sq_phantom_05)
	(set g_main_arena_retreat 1)
	(wake nav_point_main_arena)
	(game_save)
)

;=============================== phantom_02 =====================================================================================================================================================================================

(global vehicle phantom_02 none)
(script command_script cs_phantom_02

	(if debug (print "phantom 02"))
	(set phantom_02 (ai_vehicle_get_from_starting_location sq_phantom_02/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_02_hunter_01)
		(ai_place sq_phantom_02_hunter_02)
		(ai_place sq_phantom_02_jackal_01)
		(ai_place sq_phantom_02_cov_01)
		(ai_place sq_phantom_02_cov_02)

			(sleep 30)
			
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_02_hunter_01 phantom_02 "phantom_pc")
		(ai_vehicle_enter_immediate sq_phantom_02_hunter_02 phantom_02 "phantom_pc")
		(ai_vehicle_enter_immediate sq_phantom_02_jackal_01 phantom_02 "phantom_p_ml_f")
		(ai_vehicle_enter_immediate sq_phantom_02_cov_01 phantom_02 "phantom_p_ml_b")
		(ai_vehicle_enter_immediate sq_phantom_02_cov_02 phantom_02 "phantom_p_lb")
			(sleep 1)
		
		; set the objective
		(ai_set_objective sq_phantom_02 obj_main_arena_cov)
		(ai_set_objective gr_phantom_drop_02 obj_main_arena_cov)

	; start movement 
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_02/approach_01)
	(cs_fly_by ps_phantom_02/approach_02)
	(cs_vehicle_boost FALSE)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_02/hover_01 ps_phantom_02/face_01 1)
		(unit_open phantom_02)
		
		; == dialogue =================================================
			(wake md_030_bridge_tunnel)	
	
		(cs_vehicle_speed .5)
		(cs_fly_to_and_face ps_phantom_02/drop_01 ps_phantom_02/face_01 1)
	
		;drop 1		
		(vehicle_unload phantom_02 "phantom_pc_1")
		(vehicle_unload phantom_02 "phantom_p_lb")
		(sleep 75)
		
		;drop 2		
		(cs_fly_to_and_face ps_phantom_02/drop_02 ps_phantom_02/face_01 1)
		(vehicle_unload phantom_02 "phantom_pc_2")
		(sleep 15)
		
		;drop 3
		(cs_fly_to_and_face ps_phantom_02/drop_03 ps_phantom_02/face_01 1)

		; == dialogue ==================================================
			(if (volume_test_players tv_bridge_exit) (wake md_030_bridge_exit))	
		
		(vehicle_unload phantom_02 "phantom_p_ml_f")
		(vehicle_unload phantom_02 "phantom_p_ml_b")

	(cs_vehicle_speed 1.0)
	(sleep (random_range 45 90))
	(unit_close phantom_02)
	(cs_fly_by ps_phantom_02/exit_01)
	(cs_fly_by ps_phantom_02/exit_02)
	(cs_vehicle_boost TRUE)
	(cs_fly_by ps_phantom_02/erase)
	(ai_erase ai_current_squad)
)

;=============================== phantom_03 =====================================================================================================================================================================================

(global vehicle phantom_03 none)
(script command_script cs_phantom_03

	(if debug (print "phantom 03"))
	(set phantom_03 (ai_vehicle_get_from_starting_location sq_phantom_03/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_03_wraith)
		(ai_place sq_phantom_03_cov_01)
		;(ai_place sq_phantom_03_cov_02)
		;(ai_place sq_phantom_03_cov_03)
		(ai_place sq_phantom_03_cov_04)
		(ai_place sq_phantom_03_cov_05)
		;(ai_place sq_phantom_03_cov_06)
		
	; == Forcing AI active to get them into the Phantom ====================================================		
		(ai_force_active gr_phantom_drop_03 TRUE)
			
		(sleep 30)
		
	; == seating ====================================================		
		(vehicle_load_magic phantom_03 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_03_wraith/wraith))
	 	(ai_vehicle_enter_immediate sq_phantom_03_cov_01 phantom_03 "phantom_p_lf")
	;	(ai_vehicle_enter_immediate sq_phantom_03_cov_02 phantom_03 "phantom_p_lb")
	;	(ai_vehicle_enter_immediate sq_phantom_03_cov_03 phantom_03 "phantom_p_mr_b")
		(ai_vehicle_enter_immediate sq_phantom_03_cov_04 phantom_03 "phantom_p_ml_f")
		(ai_vehicle_enter_immediate sq_phantom_03_cov_05 phantom_03 "phantom_p_ml_b")
	;	(ai_vehicle_enter_immediate sq_phantom_03_cov_06 phantom_03 "phantom_p_ml_b")
			(sleep 1)
		
		; set the objective
		(ai_set_objective sq_phantom_03 obj_main_arena_cov)
		(ai_set_objective gr_phantom_drop_03 obj_main_arena_cov)

		; start movement 
		(cs_vehicle_boost TRUE)
		(cs_fly_by ps_phantom_03/approach_01)
		(cs_vehicle_boost FALSE)
		(cs_fly_by ps_phantom_03/approach_02)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_03/hover_01 ps_phantom_03/face_01 1)
		(unit_open phantom_03)
			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_03/drop_01 ps_phantom_03/face_01 1)
			(sleep 15)

		; drop 
		(vehicle_unload phantom_03 "phantom_p_lf")
;		(sleep (random_range 5 15))
;		(vehicle_unload phantom_03 "phantom_p_lb")
		(sleep 75)

	;== begin drop ======================================================
		(cs_fly_to_and_face ps_phantom_03/hover_02 ps_phantom_03/face_02 1)

			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_03/drop_02 ps_phantom_03/face_02 1)
			(sleep 15)
			
		; drop
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
		(ai_set_objective sq_phantom_03_wraith obj_main_arena_cov) 
		(sleep 15)
		
		(vehicle_unload phantom_03 "phantom_p_ml_f")
		(sleep (random_range 5 15))
		
		(vehicle_unload phantom_03 "phantom_p_ml_b")
		(sleep 75)

		(cs_fly_to_and_face ps_phantom_03/hover_02 ps_phantom_03/face_02 1)
		(sleep 30)
		(unit_close phantom_03)
		(cs_vehicle_speed 1.0)

	(sleep (random_range 60 120))
	(cs_fly_by ps_phantom_03/exit_01)
	(cs_fly_by ps_phantom_03/erase)
	
	; == Allowing the AI to go inactive again ====================================================		
		(ai_force_active gr_phantom_drop_03 FALSE)
	
	(ai_erase ai_current_squad)
)

;=============================== phantom_04 =====================================================================================================================================================================================

(global vehicle phantom_04 none)
(script command_script cs_phantom_04

	(if debug (print "phantom 04"))
	(set phantom_04 (ai_vehicle_get_from_starting_location sq_phantom_04/phantom))

	; == spawning ====================================================

		(ai_place sq_phantom_04_wraith)
		(ai_place sq_phantom_04_cov_01)
		(ai_place sq_phantom_04_cov_02)
		(ai_place sq_phantom_04_cov_03)
		(ai_place sq_phantom_04_cov_04)
		;(ai_place sq_phantom_04_cov_05)
		
	; == Forcing AI active to get them into the Phantom ====================================================		
		(ai_force_active gr_phantom_drop_04 TRUE)		
	
			(sleep 30)
		
	; == seating ====================================================		
		(vehicle_load_magic phantom_04 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_04_wraith/wraith))
		(ai_vehicle_enter_immediate sq_phantom_04_cov_01 phantom_04 "phantom_p_lf")
		(ai_vehicle_enter_immediate sq_phantom_04_cov_02 phantom_04 "phantom_p_lb")
		(ai_vehicle_enter_immediate sq_phantom_04_cov_03 phantom_04 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_04_cov_04 phantom_04 "phantom_p_rb")
	;	(ai_vehicle_enter_immediate sq_phantom_04_cov_05 phantom_04 "phantom_p_ml_b")
			(sleep 1)
		
		; set the objective
		(ai_set_objective sq_phantom_04 obj_main_arena_cov)
		(ai_set_objective gr_phantom_drop_04 obj_main_arena_cov)

		; start movement 
		(cs_vehicle_boost TRUE)
		(cs_fly_by ps_phantom_04/approach_01)
		(cs_vehicle_boost FALSE)
		(cs_fly_by ps_phantom_04/approach_02)
		(cs_fly_by ps_phantom_04/approach_03)	

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_04/hover_01 ps_phantom_04/face_01 1)
		(unit_open phantom_04)
			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_04/drop_01 ps_phantom_04/face_01 1)
			(sleep 15)

		; drop 
		(vehicle_unload phantom_04 "phantom_p_lf")
		(sleep (random_range 5 15))

		(vehicle_unload phantom_04 "phantom_p_lb")
		(sleep 75)

	;== begin drop ======================================================
		(cs_fly_to_and_face ps_phantom_04/hover_02 ps_phantom_04/face_02 1)

			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_04/drop_02 ps_phantom_04/face_02 1)
			(sleep 15)
			
		; drop
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
		(ai_set_objective sq_phantom_04_wraith obj_main_arena_cov) 
		(sleep 15)
		
		(vehicle_unload phantom_04 "phantom_p_rf")
		(sleep (random_range 5 15))

		(vehicle_unload phantom_04 "phantom_p_rb")
		
;== retreat behavior ======================================================
	(wake main_arena_retreat_01)	
		
		(sleep 90)

		(cs_fly_to_and_face ps_phantom_04/hover_02 ps_phantom_04/face_02 1)
		(sleep 30)
		(unit_close phantom_04)		
		(cs_vehicle_speed 1.0)
	
	(sleep (random_range 60 120))
	(cs_fly_by ps_phantom_04/exit_01)
	(cs_fly_by ps_phantom_04/erase)
	
	; == second wave ====================================================
		(wake main_arena_place_03)
	
	; == Allowing the AI to go inactive again ====================================================		
		(ai_force_active gr_phantom_drop_04 FALSE)
	
	(ai_erase ai_current_squad)
)

;=============================== Combat Dialogue =====================================================================================================================================================================================

(script static void ssv_md_040_main_arena_start

	(wake md_040_main_arena_start)
)

;=============================== Wraith Firing Behavior =====================================================================================================================================================================================

(script command_script cs_phantom_03_wraith_low

	(cs_run_command_script sq_phantom_03_wraith/gunner abort_cs)	
	(cs_abort_on_damage TRUE)
	(cs_enable_moving TRUE)
	(sleep_until
		(begin
			(begin_random
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_10)
						(<= (object_get_health barrier_10) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_12)
						(<= (object_get_health barrier_12) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_13)
						(<= (object_get_health barrier_13) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_14)
						(<= (object_get_health barrier_14) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_15)
						(<= (object_get_health barrier_15) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_16)
						(<= (object_get_health barrier_16) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_17)
						(<= (object_get_health barrier_17) 0)
					)
					(random_range 60 150)
				)

			)	
		(and (<= (object_get_health barrier_10) 0)
			(<= (object_get_health barrier_12) 0)
			(<= (object_get_health barrier_13) 0)
			(<= (object_get_health barrier_14) 0)
			(<= (object_get_health barrier_15) 0)
			(<= (object_get_health barrier_16) 0)
			(<= (object_get_health barrier_17) 0)
		)
		)
	)
)

(script command_script cs_phantom_04_wraith_low

	(cs_run_command_script sq_phantom_04_wraith/gunner abort_cs)	
	(cs_abort_on_damage TRUE)
	(cs_enable_moving TRUE)

	(sleep_until
		(begin
			(begin_random
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_00)
						(<= (object_get_health barrier_00) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_01)
						(<= (object_get_health barrier_01) 0)
					)
					(random_range 60 150)
				)			
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_02)
						(<= (object_get_health barrier_02) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_03)
						(<= (object_get_health barrier_03) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_04)
						(<= (object_get_health barrier_04) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot true barrier_05)
						(<= (object_get_health barrier_05) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_06)
						(<= (object_get_health barrier_06) 0)
					)
					(random_range 60 150)
				)
			)	
		(and 
			(<= (object_get_health barrier_00) 0)
			(<= (object_get_health barrier_01) 0)			
			(<= (object_get_health barrier_02) 0)
			(<= (object_get_health barrier_03) 0)
			(<= (object_get_health barrier_04) 0)
			(<= (object_get_health barrier_05) 0)
			(<= (object_get_health barrier_06) 0)
		)
		)
	)
)

(script command_script cs_phantom_04_wraith_high

	(cs_run_command_script sq_phantom_04_wraith/gunner abort_cs)	
	(cs_abort_on_damage TRUE)
	(cs_enable_moving TRUE)

	(sleep_until
		(begin
			(begin_random
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_07)
						(<= (object_get_health barrier_07) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_08)
						(<= (object_get_health barrier_08) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_09)
						(<= (object_get_health barrier_09) 0)
					)
					(random_range 60 150)
				)
			)	
		(and 
			(<= (object_get_health barrier_07) 0)
			(<= (object_get_health barrier_08) 0)
			(<= (object_get_health barrier_09) 0)
		)
		)
	)
)

(script command_script cs_phantom_03_wraith_high

	(cs_run_command_script sq_phantom_03_wraith/gunner abort_cs)	
	(cs_abort_on_damage TRUE)
	(cs_enable_moving TRUE)
	(sleep_until
		(begin
			(begin_random
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_18)
						(<= (object_get_health barrier_18) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_19)
						(<= (object_get_health barrier_19) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_20)
						(<= (object_get_health barrier_20) 0)
					)
					(random_range 60 150)
				)
				(sleep_until
					(begin
						(cs_shoot TRUE barrier_21)
						(<= (object_get_health barrier_21) 0)
					)
					(random_range 60 150)
				)
				
			)	
		(and (<= (object_get_health barrier_18) 0)
			(<= (object_get_health barrier_19) 0)
			(<= (object_get_health barrier_20) 0)
			(<= (object_get_health barrier_21) 0)
		)
		)
	)
)

;=============================== phantom_05 =====================================================================================================================================================================================

(global vehicle phantom_05 none)
(script command_script cs_phantom_05

	(if debug (print "phantom 05"))
	(set phantom_05 (ai_vehicle_get_from_starting_location sq_phantom_05/phantom))

	; == allies killoff ====================================================

	(units_set_current_vitality (ai_actors sq_main_arena_allies_right) .1 0)
	(units_set_maximum_vitality (ai_actors sq_main_arena_allies_right) .1 0)
	(units_set_current_vitality (ai_actors sq_main_arena_allies_left) .1 0)
	(units_set_maximum_vitality (ai_actors sq_main_arena_allies_left) .1 0)

	; == spawning ====================================================
		(ai_place sq_phantom_05_wraith)
		(ai_place sq_phantom_05_cov_01)
		(ai_place sq_phantom_05_cov_02)
		(ai_place sq_phantom_05_cov_03)
		(ai_place sq_phantom_05_cov_04)
		(ai_place sq_phantom_05_jackal_01)
		(ai_place sq_phantom_05_jackal_02)		
			
	; == Forcing AI active to get them into the Phantom ====================================================		
		(ai_force_active gr_phantom_drop_05 TRUE)			
			
		(sleep 30)
			
	; == seating ====================================================
		(vehicle_load_magic phantom_05 "phantom_lc" (ai_vehicle_get_from_starting_location sq_phantom_05_wraith/wraith))
		(ai_vehicle_enter_immediate sq_phantom_05_cov_01 phantom_05 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_05_cov_02 phantom_05 "phantom_p_rb")
		(ai_vehicle_enter_immediate sq_phantom_05_cov_03 phantom_05 "phantom_p_mr_f")
		(ai_vehicle_enter_immediate sq_phantom_05_cov_04 phantom_05 "phantom_p_mr_b")
		(ai_vehicle_enter_immediate sq_phantom_05_jackal_01 phantom_05 "phantom_p_ml_f")
		(ai_vehicle_enter_immediate sq_phantom_05_jackal_02 phantom_05 "phantom_p_ml_b")		
		
			(sleep 1)
		
		; set the objective
		(ai_set_objective sq_phantom_05 obj_main_arena_cov_02)
		(ai_set_objective gr_phantom_drop_05 obj_main_arena_cov_02)

		; start movement 
		(cs_vehicle_boost TRUE)
		(cs_fly_by ps_phantom_05/approach_01)
		(cs_vehicle_boost FALSE)
		
			;dialogue
			(wake md_050_phantom)
		
		(cs_fly_by ps_phantom_05/approach_02)

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_05/hover_01 ps_phantom_05/face_01 1)
		(unit_open phantom_05)
			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_05/drop_01 ps_phantom_05/face_01 1)
			(sleep 15)

		; drop 
		(vehicle_unload phantom_05 "phantom_p_rf")
		(sleep (random_range 15 45))
		
		(vehicle_unload phantom_05 "phantom_p_rb")
		(sleep (random_range 15 45))		
		
		(vehicle_unload phantom_05 "phantom_p_ml_f")
		(sleep (random_range 75 90))

	;== begin drop ======================================================
		(cs_fly_to_and_face ps_phantom_05/hover_02 ps_phantom_05/face_02 1)

			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_05/drop_02 ps_phantom_05/face_02 1)
			(sleep 15)
			
		; drop
		(vehicle_unload (ai_vehicle_get ai_current_actor) "phantom_lc")
		(ai_set_objective sq_phantom_05_wraith obj_main_arena_cov) 
		(sleep 30)
						
	;== Lobby entry sequence ======================================================	
		(wake lobby_place_01)	
		
	;== begin drop ======================================================	
		(cs_fly_to_and_face ps_phantom_05/hover_03 ps_phantom_05/face_03 1)

			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_05/drop_03 ps_phantom_05/face_03 1)
			(sleep 15)
			
		;drop
		(vehicle_unload phantom_05 "phantom_p_mr_f")
		(sleep (random_range 15 45))
		
		(vehicle_unload phantom_05 "phantom_p_mr_b")
		(sleep (random_range 15 45))		
		
		(vehicle_unload phantom_05 "phantom_p_ml_b")
		(sleep (random_range 75 90))
		
		(game_save)
		
		(cs_fly_to_and_face ps_phantom_05/hover_03 ps_phantom_05/face_03 1)
			(sleep 30)

	;== Jump pack brutes that drop in from the roof of the ONI building ======================================================				
;		(ai_place sq_main_arena_jump_brutes_01)
;		(ai_place sq_main_arena_jump_brutes_02)
		
		(cs_fly_by ps_phantom_05/course_01)
		(cs_fly_to_and_face ps_phantom_05/hover_04 ps_phantom_05/face_04 1)
		
		(cs_vehicle_speed 0.2)			
			(sleep (* 30 10))
		(cs_fly_to_and_face ps_phantom_05/hover_05 ps_phantom_05/face_05 1)
		
	(sleep_until
		(<= (ai_task_count obj_main_arena_cov_02/gt_phantom) 2)
		30 (* 30 15)
	)	
		(cs_vehicle_speed 1)
		(cs_fly_by ps_phantom_05/exit_01)
		(cs_fly_by ps_phantom_05/erase)
		
	; == Allowing the AI to go inactive again ====================================================		
		(ai_force_active gr_phantom_drop_05 FALSE)		
		
		(ai_erase ai_current_squad)		
)

;=============================== Combat Dialogue =====================================================================================================================================================================================

(script static void ssv_md_040_brute_advance_02

	(wake md_040_main_arena_start)
)

;=============================== Main_Arena Nav Point ================================================================================

(script dormant nav_point_main_arena
	(if 
		(not (volume_test_players tv_main_arena_mega_upper))

	(hud_activate_team_nav_point_flag player fl_main_arena .5)
	)
	(sleep_until
			(volume_test_players tv_main_arena_mega_upper)
	)
	(hud_deactivate_team_nav_point_flag player fl_main_arena)
)	

;====================================================================================================================================================================================================
;=============================== Lobby ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_lobby

	;Trigger Volumes

	(sleep_until (volume_test_players tv_lobby_01) 1)
	(if debug (print "set objective control 1"))
	(set g_lobby_obj_control 1)
	(game_save)

	(sleep_until (volume_test_players tv_lobby_02) 1)
	(if debug (print "set objective control 2"))
	(set g_lobby_obj_control 2)
	(ai_disposable gr_main_arena_cov TRUE)
	(game_save)
	
	(sleep_until (volume_test_players tv_lobby_03) 1)
	(if debug (print "set objective control 3"))
	(set g_lobby_obj_control 3)
	(wake lobby_place_04)

	(sleep_until (volume_test_players tv_lobby_04) 1)
	(if debug (print "set objective control 4"))
	(set g_lobby_obj_control 4)

	(sleep_until (volume_test_players tv_lobby_05) 1)
	(if debug (print "set objective control 5"))
	(set g_lobby_obj_control 5)
	(wake roof_place_01)
	(wake enc_roof)
	(game_save)
	
)

;=============================== Lobby secondary scripts =======================================================================================================================================

(script dormant lobby_place_01
	
	(sleep_until
		(volume_test_players tv_main_arena_mega_upper)
	)	
	
	;zone_set	
	(switch_zone_set set_000_010_020)
		(sleep 5)	
	
	;initial placement
	(ai_place sq_lobby_allies_entry_01)
	(ai_place sq_lobby_allies_entry_02)
	(ai_place sq_lobby_allies_left)
	(ai_place sq_lobby_sarge)
	
	(ai_cannot_die sq_lobby_sarge TRUE)
	
	;doors open
	(device_group_set dm_lobby_door_01 dg_lobby_door 1)
	
	;dialogue
	(wake md_050_ridge_retreat_01)
)

; Cov breaching force

(script dormant lobby_place_02
	
; spark effect
	(effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "")
	(effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\cutting_door.effect dm_lobby_door_02 "")
	
		(sleep (* 30 6))
	
; ai placement
	(ai_place sq_lobby_jackal_01)
	(ai_place sq_lobby_jackal_sniper_01)
	(ai_place sq_lobby_jackal_02)
	(ai_place sq_lobby_jackal_sniper_02)
	(ai_place sq_lobby_jackal_sniper_03)
		(sleep 5)
	(ai_place sq_lobby_cov_01)
	(ai_place sq_lobby_cov_02)
	(ai_place sq_lobby_cov_03)
	(ai_place sq_lobby_cov_04)
	(ai_place sq_lobby_cov_05)
	(ai_place sq_lobby_cov_06)
		(sleep 5)
	(ai_force_active gr_lobby_front_right_cov TRUE)
	(ai_force_active gr_lobby_front_left_cov TRUE)
	
; allied killoff
	(units_set_current_vitality (ai_actors sq_lobby_allies_entry_01) .5 0)
	(units_set_maximum_vitality (ai_actors sq_lobby_allies_entry_01) .5 0)
	(units_set_current_vitality (ai_actors sq_lobby_allies_entry_02) .5 0)
	(units_set_maximum_vitality (ai_actors sq_lobby_allies_entry_02) .5 0)
	
; door explosion	
	(effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\destruction.effect dm_lobby_door_01 "")
	(effect_new_on_object_marker objects\levels\atlas\sc130\revolving_oni_doors\fx\destruction.effect dm_lobby_door_02 "")
	(object_set_permutation dm_lobby_door_01 doors destroyed)
	(object_set_permutation dm_lobby_door_02 doors destroyed)	
	
	(device_set_position_immediate dm_lobby_door_01 1)
	(device_set_position_immediate dm_lobby_door_02 1)
		
		(sleep (* 30 45))
		(game_save)
	
	(wake lobby_place_03)
)

(script dormant lobby_place_03
	(sleep 1)
	(sleep_until
		(and
			(= (ai_task_count obj_lobby_front_cov/gt_lobby_front_cov) 0)
			(= (ai_task_count obj_lobby_holding/gt_lobby_holding_cov) 0)
		)
	)
	(game_save)	
	(ai_place sq_phantom_06)
	(sleep 60)
	(set g_lobby_front 1)
)

(script dormant lobby_place_04
	(ai_place sq_lobby_bugger_01)
	(ai_place sq_lobby_bugger_02)
)

;=============================== Lobby Entry ================================================================================

(script dormant lobby_entry

	(ai_set_objective gr_ODST obj_lobby_allies)
	
		;dialogue
	(wake md_060_lobby_conversation)	
	
	(hud_activate_team_nav_point_flag player fl_lobby .5)
	
	(sleep_until
		(or
			(volume_test_players tv_main_arena_03)
			(>= g_lobby_obj_control 1)
		)
	)
	
	(set g_lobby_obj_control 2)
	
			(sleep (random_range 30 90))
			(ai_set_objective gr_lobby_allies_entry obj_lobby_allies)		
	
	(sleep_until
		(and
			(volume_test_players tv_lobby_02)
			(= g_lobby_entry_ODST 1)
		)
	)	

		(sleep 1)
	
	(hud_deactivate_team_nav_point_flag player fl_lobby)
	(device_group_set dm_lobby_door_01 dg_lobby_door 0)

)

(script command_script cs_lobby_entry_01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)	
	(cs_go_to ps_lobby_entry/lobby_entry_01)	
)	
	
(script command_script cs_lobby_entry_02
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_go_to ps_lobby_entry/lobby_entry_02)	
)

;(script command_script cs_lobby_entry_ODST
;	(cs_enable_pathfinding_failsafe TRUE)
;	(cs_enable_targeting TRUE)
;	(cs_enable_looking TRUE)
;	(cs_go_to ps_lobby_entry_ODST/run_01)
;	(cs_go_to ps_lobby_entry_ODST/run_02)	

	;variable for the doors to close
;	(set g_lobby_entry_ODST 1)	
	
;	(sleep 5)
	
	;moving the sarge to the ODST
	;(cs_run_command_script sq_lobby_sarge cs_lobby_entry_sarge)
	
	;(cs_go_to_and_face ps_lobby_entry_ODST/stand_01 ps_lobby_entry_ODST/face_01)
	
	;dialogue
	;(wake md_060_lobby_conversation)
;)

;(script command_script cs_lobby_entry_sarge
;	(cs_enable_pathfinding_failsafe TRUE)
;	(cs_enable_targeting TRUE)
;	(cs_enable_looking TRUE)
;	(cs_go_to_and_face ps_lobby_entry_sarge/stand_01 ps_lobby_entry_sarge/face_01)
;)
;=============================== Lobby Invasion Front ================================================================================

(script command_script cs_lobby_front_cov_01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)	
	(cs_go_to ps_lobby_entry/lobby_entry_01)	
	(ai_set_objective ai_current_squad obj_lobby_front_cov)
)

(script command_script cs_lobby_front_cov_02
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_go_to ps_lobby_entry/lobby_entry_02)	
	(ai_set_objective ai_current_squad obj_lobby_front_cov)
)

;=============================== phantom_06 =====================================================================================================================================================================================

(global vehicle phantom_06 none)
(script command_script cs_phantom_06

	(if debug (print "phantom 06"))
	(set phantom_06 (ai_vehicle_get_from_starting_location sq_phantom_06/phantom))

	; == allies killoff ====================================================
		(units_set_current_vitality (ai_actors sq_lobby_allies_left) .5 0)
		(units_set_maximum_vitality (ai_actors sq_lobby_allies_left) .5 0)

	; == spawning ====================================================
		(ai_place sq_phantom_06_cov_01)
		(ai_place sq_phantom_06_brute_01)
		(ai_place sq_phantom_06_jackal_01)
		(ai_place sq_phantom_06_brute_02)
		
	; == Forcing AI active to get them into the Phantom ====================================================		
		(ai_force_active gr_phantom_drop_06 TRUE)		
		
		(sleep 30)
		
	; == seating ====================================================		
		(ai_vehicle_enter_immediate sq_phantom_06_cov_01 phantom_06 "phantom_p_rf")
		(ai_vehicle_enter_immediate sq_phantom_06_brute_01 phantom_06 "phantom_p_rb")
		(ai_vehicle_enter_immediate sq_phantom_06_jackal_01 phantom_06 "phantom_p_mr_f")
		(ai_vehicle_enter_immediate sq_phantom_06_brute_02 phantom_06 "phantom_p_mr_b")
		
		; set the objective
		(ai_set_objective sq_phantom_06 obj_lobby_back_cov)
		(ai_set_objective gr_phantom_drop_06 obj_lobby_back_cov)

		; start movement 
		(cs_vehicle_boost TRUE)
		(cs_fly_by ps_phantom_06/approach_01)
		(cs_vehicle_boost FALSE)
		(cs_fly_by ps_phantom_06/approach_02)		

	; == begin drop ====================================================
		(cs_fly_to_and_face ps_phantom_06/hover_01 ps_phantom_06/face_01 1)
		(unit_open phantom_06)
			(sleep 15)
	
		(cs_fly_to_and_face ps_phantom_06/drop_01 ps_phantom_06/face_01 1)
		
		;dialogue
		(wake md_060_rear_attack_sarge)
		
		(sleep 30)		

		; drop 
		(vehicle_unload phantom_06 "phantom_p_rf")
		(sleep (random_range 5 15))
		(vehicle_unload phantom_06 "phantom_p_rb")
		(sleep (random_range 5 15))
		
		(cs_vehicle_speed 0.5)		
		(cs_fly_by ps_phantom_06/course_01)
		(cs_fly_by ps_phantom_06/course_03)		 

	;== begin drop ======================================================
		(cs_fly_to_and_face ps_phantom_06/hover_02 ps_phantom_06/face_02 1)

			(sleep 15)
	
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_06/drop_02 ps_phantom_06/face_02 1)
		(sleep 15)
			
		; drop
		(vehicle_unload phantom_06 "phantom_p_mr_f")
		(sleep (random_range 5 15))
		
		(vehicle_unload phantom_06 "phantom_p_mr_b")
		(sleep (random_range 5 15))

		(cs_fly_by ps_phantom_06/course_02)
		
		(sleep 30)
		(unit_close phantom_06)
		(cs_vehicle_speed 1.0)

	(sleep (random_range 60 120))
	(cs_fly_by ps_phantom_06/exit_01)
	(cs_fly_by ps_phantom_06/exit_02)
	(cs_fly_by ps_phantom_06/erase)

	; == This brings up the elevator when the combat is over ==================================================
		(wake lobby_elevator)		
	
	; == Allowing the AI to go inactive again ====================================================		
		(ai_force_active gr_phantom_drop_06 FALSE)

	(ai_erase ai_current_squad)
)

;=============================== Elevator ================================================================================

(script dormant lobby_elevator

	(sleep_until
		(= (ai_task_count obj_lobby_back_cov/gt_lobby_back_cov) 0)
	)
	
	(game_save)	
	
	;dialogue
	(wake md_060_lobby_combat_end)
	
	(ai_place sq_lobby_civ_01)	
	
	;elevator moves to lobby
	(device_group_set dm_elev_01 dg_elev_position .5)
	
(sleep_until (= (device_get_position dm_elev_01) 0.5))
	
	;reminders
		(wake elevator_nav_marker)
	
	;doors open on lobby
	(device_set_position dm_elev_inner_door_01 1)
	(device_set_position dm_elev_outer_door_01 1)
	
(sleep_until (= (device_get_position dm_elev_outer_door_01) 1))
	(set g_lobby_front 2)
			
	(game_save)	
		
(sleep_until 
		(= (device_get_position c_elev_01) 1)
)	
	;kill reminder
	(sleep_forever md_060_elev_entry_reminder)
	(vs_release_all)

	;doors close on lobby
	(device_set_position dm_elev_inner_door_01 0)
	(device_set_position dm_elev_outer_door_01 0)

(sleep_until (= (device_get_position dm_elev_inner_door_01) 0))
	
	;elevator moves to the roof
	(device_group_set dm_elev_01 dg_elev_position 1)

(sleep_until (= (device_get_position dm_elev_01) 1))
	
	;doors open on the roof
	(device_set_position dm_elev_inner_door_01 1)
	(device_set_position dm_elev_outer_door_02 1)
	
	(ai_set_objective sq_bridge_ODST obj_roof_allies)
	(ai_set_objective sq_lobby_civ_01 obj_roof_allies)
)

(script dormant elevator_nav_marker

	(sleep (* 30 10))
	
	(if (= (device_get_position dm_elev_01) 0.5)
	(hud_activate_team_nav_point_flag player fl_elevator_01 .5)
	)
	
	(sleep_until 
		(= (device_get_position c_elev_01) 1))
	
	(hud_deactivate_team_nav_point_flag player fl_elevator_01)
)

; ODST behavior

(script command_script cs_elevator_ODST
	(cs_enable_pathfinding_failsafe TRUE)	
	(cs_go_to_and_face ps_elevator_ODST/stand_01 ps_elevator_ODST/face_01)
	(device_set_power c_elev_01 1)
		
	;dialogue
	(wake md_060_elev_arrives_sarge)
)	

;====================================================================================================================================================================================================
;=============================== Roof ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant enc_roof

	;Trigger Volumes

	(sleep_until (volume_test_players tv_roof_01) 1)
	(if debug (print "set objective control 1"))
	(set g_roof_obj_control 1)
		;zone_set	
	(switch_zone_set set_000_005_010_020)

	(sleep_until (volume_test_players tv_roof_02) 1)
	(if debug (print "set objective control 2"))
	(set g_roof_obj_control 2)
	
)

;=============================== Roof secondary scripts =======================================================================================================================================

(script dormant roof_place_01
	(ai_place sq_phantom_07)
	(ai_place sq_roof_jump_pack_brute_01)
	(ai_place sq_roof_jump_pack_brute_02)
		
	(sleep_until 
		(= g_roof_obj_control 2)
	)
	(ai_set_objective sq_roof_jump_pack_brute_01 obj_roof_cov)
	(ai_set_objective sq_roof_jump_pack_brute_02 obj_roof_cov)
)

(script dormant roof_place_02

	(sleep_until
		(<= (ai_task_count obj_roof_cov/obj_roof_cov) 4)
	)
	(ai_place sq_pelican_01)
)

;=============================== phantom_07 =====================================================================================================================================================================================

(global vehicle phantom_07 none)
(script command_script cs_phantom_07

	(if debug (print "phantom 07"))
	(set phantom_07 (ai_vehicle_get_from_starting_location sq_phantom_07/phantom))

	; == spawning ====================================================
		(ai_place sq_phantom_07_jackal_01)
		(ai_place sq_phantom_07_jackal_02)
		
	; == Forcing AI active to get them into the Phantom ====================================================		
		(ai_force_active gr_phantom_drop_07 TRUE)		
		
		(sleep 30)
		
	; == seating ====================================================		

		(ai_vehicle_enter_immediate sq_phantom_07_jackal_01 phantom_07 "phantom_p_mr_f")
		(ai_vehicle_enter_immediate sq_phantom_07_jackal_02 phantom_07 "phantom_p_mr_b")
		
		; set the objective
		(ai_set_objective sq_phantom_07 obj_roof_cov)
		(ai_set_objective gr_phantom_drop_07 obj_roof_cov)		

	; == begin drop ====================================================
		(cs_vehicle_speed 0.5)
		(cs_fly_to_and_face ps_phantom_07/drop_01 ps_phantom_07/face_01 1)
		(unit_open phantom_07)
		
		(sleep_until 
			(= g_roof_obj_control 2)
		)
		
		; drop 
		(vehicle_unload phantom_07 "phantom_p_mr_f")
		(vehicle_unload phantom_07 "phantom_p_mr_b")
		(cs_vehicle_speed 0.3)		
		(cs_fly_to_and_face ps_phantom_07/drop_02 ps_phantom_07/face_01 1)		
		(sleep 75)		
		(cs_fly_to_and_face ps_phantom_07/hover_01 ps_phantom_07/face_01 1)
		(unit_close phantom_07)
		(cs_vehicle_speed 1.0)

	(sleep (random_range 60 120))

	; ==	This brings in the Pelican ===================================================
		(wake roof_place_02)

	(cs_fly_by ps_phantom_07/exit_01)
	(cs_fly_by ps_phantom_07/exit_02)
	(cs_fly_by ps_phantom_07/erase)		
	
	; == Allowing the AI to go inactive again ====================================================		
		(ai_force_active gr_phantom_drop_07 FALSE)	
	
	(ai_erase ai_current_squad)
)

;=============================== pelican_01 =====================================================================================================================================================================================

(global vehicle pelican_01 none)
(script command_script cs_pelican_01

	; final script
	(wake level_exit)

	(if debug (print "pelican"))
	(set pelican_01 (ai_vehicle_get_from_starting_location sq_pelican_01/pelican))
	(ai_allegiance human player)
	(ai_allegiance player human)
	
	; set the Pelican to invincible
	(object_cannot_die (ai_vehicle_get_from_starting_location sq_pelican_01/pelican) TRUE)
	(object_cannot_take_damage (ai_vehicle_get_from_starting_location sq_pelican_01/pelican))
	(ai_cannot_die sq_pelican_01 TRUE)	
	
	; set the objective
	(ai_set_objective sq_pelican_01 obj_roof_allies)
		
		; start movement 

		(cs_vehicle_boost TRUE)
		(cs_fly_by ps_pelican_01/approach_01)
		(cs_vehicle_boost FALSE)
		(cs_fly_by ps_pelican_01/course_01)
		(cs_fly_by ps_pelican_01/course_02)
		(cs_vehicle_speed 0.5)				

		(cs_fly_to_and_face ps_pelican_01/hover_01 ps_pelican_01/face_01 1)
		
	(sleep_until
		(= (ai_task_count obj_roof_cov/obj_roof_cov) 0)
	)

		(sleep 30)
		(cs_vehicle_speed 0.3)	
		(unit_open pelican_01)		
		(cs_fly_to_and_face ps_pelican_01/hover_02 ps_pelican_01/face_01 1)
		(wake md_080_exit)
)

;=============================== level_exit =====================================================================================================================================================================================

(script dormant level_exit

	; sleep until any player is in the pelican 
	(sleep_until	
		(or
			(vehicle_test_seat_unit pelican_01 "" (player0))
			(vehicle_test_seat_unit pelican_01 "" (player1))
			(vehicle_test_seat_unit pelican_01 "" (player2))
			(vehicle_test_seat_unit pelican_01 "" (player3))
		)
	5)	
	; fade to black 
	(cinematic_fade_to_black)
		(sleep 1)
	(object_teleport (player0) end_game_teleport_flag00)
	(object_teleport (player1) end_game_teleport_flag01)
	(object_teleport (player2) end_game_teleport_flag02)
	(object_teleport (player3) end_game_teleport_flag03)
		(sleep 1)	
	(ai_erase_all)
		(sleep 1)
(if debug (print "Done"))	
	
	; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						(if debug (print "sc130_out_sc"))
						(sc130_out_sc)
					)
				)
				(cinematic_skip_stop)
				
			)
		)
		
	(sleep 5)
	(gp_boolean_set gp_sc130_complete TRUE)
	(end_scene)

)