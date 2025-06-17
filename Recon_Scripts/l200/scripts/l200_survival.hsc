;=============================================================================================================================
;================================================== GLOBALS ==================================================================
;=============================================================================================================================


;=============================================================================================================================
;============================================== STARTUP SCRIPTS ==============================================================
;=============================================================================================================================

(script static void launch_survival_mode

	(wake start_survival)
)

(script dormant survival_recycle
	(sleep_until
		(begin
			(add_recycling_volume su_garbage_all 60 60)
			(sleep 1500)
		FALSE)
	1)
)

;starting up survival mode
(script dormant start_survival
	(fade_out 0 0 0 0)

	
	(print "L200 Survival")
	(switch_zone_set pipe_room)
	
	; switch to correct zone set unless "set_all" is loaded 
	;(if (!= (current_zone_set) g_set_all)
	;	(begin
	;		(print "switching zone sets...")
	;		(switch_zone_set pipe_room)
	;	)
	;)
	(sleep 1)

	; snap to black 
	;(cinematic_snap_to_black)
	
	(soft_ceiling_enable l200_survival TRUE)
	(kill_volume_enable kill_pipe_room)
	(kill_volume_enable kill_pipe_trough)
	(wake survival_recycle)	
	(sleep 1)
	
	;(object_destroy_folder dm_survival_destroy)
	;(object_destroy_folder sc_survival_destroy)
	(object_destroy_folder cr_survival_destroy)
	(object_destroy_folder v_survival_destroy)
	
	(sleep 1)

	(object_create_folder sc_survival_create)
	(sleep 1)
	(object_create_folder sc_survival)
	(sleep 1)
	(object_create_folder cr_survival_create)
	(sleep 1)
	(object_create_folder v_survival)
	
	(sleep 1)
	
	;enabling doors
	(device_set_power pr_small_door_01 1)
	(device_set_power pr_small_door_02 1)
	(device_set_power pr_small_door_03 1)
	(device_set_power pr_small_door_04 1)
	(device_set_power pr_small_door_05 1)
	(device_set_power pr_small_door_16 1)
	(device_set_power pr_small_door_17 1)
	(device_set_power pr_small_door_18 1)
	(device_set_power pr_small_door_19 1)
	(device_set_power pr_small_door_20 1)
	(device_set_power pr_small_door_21 1)
	(device_set_power pr_small_door_22 1)
	(device_set_power arch_gate_11 1)
	(device_set_power arch_gate_09 1)
	(sleep 1)
	
	;setting elevators in the up position
	(device_set_position_immediate lift_nest_right 1)
	(device_set_position_immediate lift_nest_left 1)
	(sleep 1)
	
	;turning off elevators
	(device_set_power lift_nest_right 0)
	(device_set_power lift_nest_left 0)
	(device_set_power lift_nest_right1 0)
	(device_set_power lift_nest_right2 0)
	(device_set_power lift_nest_right3 0)
	(device_set_power lift_nest_left1 0)
	(device_set_power lift_nest_left2 0)
	(device_set_power lift_nest_left3 0)
	(sleep 1)
	

			; set player pitch 
			(player0_set_pitch g_player_start_pitch 0)
			(player1_set_pitch g_player_start_pitch 0)
			(player2_set_pitch g_player_start_pitch 0)
			(player3_set_pitch g_player_start_pitch 0)
				(sleep 1)

	;(cinematic_fade_to_gameplay)
	(fade_in 0 0 0 30)
	
	(wake survival_mode_mission)
	(sleep_forever)
)

;=============================================================================================================================
;============================================ SURVIVAL SCRIPTS ===============================================================
;=============================================================================================================================

(script dormant survival_mode_mission
	; define the number of waves set up in sapien 
		(set b_wave_initial_present TRUE)
		(set b_wave_01_present TRUE)
		(set b_wave_02_present TRUE)
		(set b_wave_03_present TRUE)
		(set b_wave_04_present FALSE)
		(set b_wave_05_present FALSE)
		(set b_wave_final_present TRUE)
		
	(sleep 1)

	; assign squads to global variables 
		(set ai_initial_squad_01 sq_survival_wave1a)
		(set ai_initial_squad_02 sq_survival_wave1b)
		(set ai_initial_squad_03 sq_survival_wave1c)
		(set ai_initial_squad_04 sq_survival_wave1d)
		(set ai_initial_squad_05 sq_survival_wave1e)
		(set ai_initial_squad_06 sq_survival_wave1f)
		(set ai_initial_squad_07 sq_survival_wave1g)
		
		(set ai_wave_01_squad_01 sq_survival_wave2a)
		(set ai_wave_01_squad_02 sq_survival_wave2b)
		(set ai_wave_01_squad_03 sq_survival_wave2c)
		(set ai_wave_01_squad_04 sq_survival_wave2d)
		(set ai_wave_01_squad_05 sq_survival_wave2e)
		(set ai_wave_01_squad_06 sq_survival_wave2f)
		(set ai_wave_01_squad_07 sq_survival_wave2g)
		
		(set ai_wave_02_squad_01 sq_survival_wave3a)
		(set ai_wave_02_squad_02 sq_survival_wave3b)
		(set ai_wave_02_squad_03 sq_survival_wave3c)
		(set ai_wave_02_squad_04 sq_survival_wave3d)
		(set ai_wave_02_squad_05 sq_survival_wave3e)
		(set ai_wave_02_squad_06 sq_survival_wave3f)
		(set ai_wave_02_squad_07 sq_survival_wave3g)
		
		(set ai_wave_03_squad_01 sq_survival_wave4a)
		(set ai_wave_03_squad_02 sq_survival_wave4b)
		(set ai_wave_03_squad_03 sq_survival_wave4c)
		(set ai_wave_03_squad_04 sq_survival_wave4d)
		(set ai_wave_03_squad_05 sq_survival_wave4e)
		(set ai_wave_03_squad_06 sq_survival_wave4f)
		(set ai_wave_03_squad_07 sq_survival_wave4g)

		(set ai_final_squad_01 sq_survival_wave5a)
		(set ai_final_squad_02 sq_survival_wave5b)
		(set ai_final_squad_03 sq_survival_wave5c)
		(set ai_final_squad_04 sq_survival_wave5d)
		(set ai_final_squad_05 sq_survival_wave5e)
		(set ai_final_squad_06 sq_survival_wave5f)
		(set ai_final_squad_07 sq_survival_wave5g)
		
	(sleep 1)
		
; define weapon crates 
;		(set sur_weapon_01 survival_smg1)
;		(set sur_weapon_02 survival_smg2)
;		(set sur_weapon_03 survival_smg3)
;		(set sur_weapon_04 survival_mag1)
;		(set sur_weapon_05 survival_mag2)
;		(set sur_weapon_06 survival_rocks)
;		(set sur_weapon_07 survival_sniper)
;		(set sur_weapon_08 survival_turret_01)
;		(set sur_weapon_09 survival_turret_02)
;		(set sur_weapon_10 survival_turret_03)
		
	(sleep 1)
	
	(fade_in 0 0 0 15)

	
	(wake survival_mode)
	
	(sleep 5)
	
; setting the number of random waves per round based on difficulty 
	;(cond
	;	((<= (game_difficulty_get) normal) (set g_sur_wave_per_round_limit 3))
	;	((= (game_difficulty_get) heroic) (set g_sur_wave_per_round_limit 4))
	;	((= (game_difficulty_get) legendary) (set g_sur_wave_per_round_limit 5))
	;)
)



;===================================================== COMMAND SCRIPTS =========================================================

; command script for survival bugger wave2a
(script command_script cs_su_wave2a
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to survival_wave2a/p0)
		(cs_fly_to survival_wave2a/p1)
)

; command script for survival bugger wave2b
(script command_script cs_su_wave2b
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to survival_wave2b/p0)
		(cs_fly_to survival_wave2b/p1)
		(cs_fly_to survival_wave2b/p2)
)

; command script for survival bugger wave2c
(script command_script cs_su_wave2c
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to survival_wave2c/p0)
		(cs_fly_to survival_wave2c/p1)
		(cs_fly_to survival_wave2c/p2)
)

; command script for survival bugger wave2d
(script command_script cs_su_wave2d
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to survival_wave2d/p0)
		(cs_fly_to survival_wave2d/p1)
		(cs_fly_to survival_wave2d/p2)
)

; command script for survival bugger wave2e
(script command_script cs_su_wave2e
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to survival_wave2e/p0)
		(cs_fly_to survival_wave2e/p1)
		(cs_fly_to survival_wave2e/p2)
)

; command script for survival bugger wave2f
(script command_script cs_su_wave2f
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to survival_wave2f/p0)
		(cs_fly_to survival_wave2f/p1)
		(cs_fly_to survival_wave2f/p2)
)

; command script for survival bugger wave2g
(script command_script cs_su_wave2g
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to survival_wave2g/p0)
		(cs_fly_to survival_wave2g/p1)
		(cs_fly_to survival_wave2g/p2)
)
;==================================================== WORKSPACE ================================================================

