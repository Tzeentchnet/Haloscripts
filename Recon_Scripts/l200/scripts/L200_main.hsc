;===============================================================================================================================
;====================================================== GLOBAL VARIABLES =======================================================
;===============================================================================================================================

(global boolean editor FALSE)

(global boolean g_play_cinematics TRUE)
(global boolean g_player_training TRUE)

(global boolean debug TRUE)
(global boolean dialogue TRUE)
(global boolean music TRUE)

; insertion point index 
(global short g_insertion_index 0)

; objective control global shorts

; starting player pitch 
(global short g_player_start_pitch -16)

(global boolean g_null FALSE)

(global real g_nav_offset 0.55)

;phantoms for data core
(global vehicle v_sq_dc_phantom_01 NONE)
(global vehicle v_sq_dc_phantom_02 NONE)
(global vehicle v_sq_dc_phantom_03 NONE)

; objective control golbal shorts
(global short g_la_obj_control 0)
(global short g_lb_obj_control 0)
(global short g_lc_obj_control 0)
(global short g_ld_obj_control 0)
(global short g_res_obj_control 0)
(global short g_dr_obj_control 0)
(global short g_pr_obj_control 0)
(global short g_dc_obj_control 0)
(global short g_fa_obj_control 0)


;===============================================================================================================================
;=============================================== UNDERGROUND MISSION SCRIPTS ===================================================
;===============================================================================================================================
(script static void start
	; fade out 
	(fade_out 0 0 0 0)
	
	(cond 
		((campaign_survival_enabled) (wake start_survival))
	
	
	; select insertion point 
		((= (game_insertion_point_get) 0) (ins_labyrinth_a))
		((= (game_insertion_point_get) 1) (ins_labyrinth_b))
		((= (game_insertion_point_get) 2) (ins_labyrinth_c))
		((= (game_insertion_point_get) 3) (ins_labyrinth_d))
		((= (game_insertion_point_get) 4) (ins_rescue))
		((= (game_insertion_point_get) 5) (ins_data_reveal))
		((= (game_insertion_point_get) 6) (ins_pipe_room))
		((= (game_insertion_point_get) 7) (ins_data_core))
		((= (game_insertion_point_get) 8) (ins_final_area))
	)
)



(script startup su_L200_startup
	(print "Welcome to Underground.")
	
	; fade out 
	(fade_out 0 0 0 0)
	
	; set allegiances 
	(ai_allegiance covenant player)
	(ai_allegiance player covenant)
	(ai_allegiance human player)
	(ai_allegiance player human)
	(ai_allegiance covenant human)
	(ai_allegiance human covenant)
	
	(sleep 1)
		
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
	;			(wake temp_camera_bounds_off)
			)
		)
		; === PLAYER IN WORLD TEST =====================================================
		
		
		
		;==== begin labyrinth a encounter (insertion 1) 
			(sleep_until (>= g_insertion_index 1) 1)
			(if (<= g_insertion_index 1) (wake enc_labyrinth_a))
		
		;==== begin labyrinth b encounter (insertion 2) 
			(sleep_until	(or
							(volume_test_players tv_enc_labyrinth_b)
							(>= g_insertion_index 2)
						)
			1)
				; wake encounter script 
				(if (<= g_insertion_index 2) (wake enc_labyrinth_b))
			
		;==== begin labyrinth c encounters (insertion 3) 
			(sleep_until	(or
							(volume_test_players tv_enc_labyrinth_c)
							(>= g_insertion_index 3)
						)
			1)
				; wake encounter script 
				(if (<= g_insertion_index 3) (wake enc_labyrinth_c))
		
		;==== begin labyrinth d encounters (insertion 4) 
			(sleep_until	(or
							(volume_test_players tv_enc_labyrinth_d)
							(>= g_insertion_index 4)
						)
			1)
				; wake encounter script 
				(if (<= g_insertion_index 4) (wake enc_labyrinth_d))
		
		;==== begin rescue encounters (insertion 5) 
			(sleep_until	(or
							(volume_test_players tv_enc_rescue)
							(>= g_insertion_index 5)
						)
			1)
				; wake encounter script 
				(if (<= g_insertion_index 5) (wake enc_rescue))
		
		;==== begin data reveal encounters (insertion 6) 
			(sleep_until	(or
							(volume_test_players tv_enc_data_reveal)
							(>= g_insertion_index 6)
						)
			1)
				; wake encounter script 
				(if (<= g_insertion_index 6) (wake enc_data_reveal))
		
		;==== begin pipe room encounters (insertion 7) 
			(sleep_until	(or
							(volume_test_players tv_enc_pipe_room)
							(>= g_insertion_index 7)
						)
			1)
				; wake encounter script 
			(if (<= g_insertion_index 7) (wake enc_pipe_room))
		
		;==== begin data core encounters (insertion 8) 
			(sleep_until	(or
							(volume_test_players tv_enc_data_core)
							(>= g_insertion_index 8)
						)
			1)
			; wake encounter script 
			(if (<= g_insertion_index 8) (wake enc_data_core))
			
		;==== begin final area encounters (insertion 9) 
			(sleep_until	(or
							(volume_test_players tv_enc_final_area)
							(>= g_insertion_index 9)
						)
			1)
			; wake encounter script 
			(if (<= g_insertion_index 9) (wake enc_final_area))
)

;==============================================================================================================================
;======================================================= LABYRINTH A ==========================================================
;==============================================================================================================================

;encounter script for Labyrinth A
(script dormant enc_labyrinth_a
	
	(sleep_until (volume_test_players tv_la_01) 1)
		(set g_la_obj_control 1)
		(print "g_la_obj_control set to 1")
		(wake cs_la_door_flutter)
		;placing ai
		(ai_place sq_la_brute_01)
		(ai_place sq_la_brute_02)
		(ai_place sq_la_brute_03)
		(game_save)
		
	(sleep_until (volume_test_players tv_la_02) 1)
		(set g_la_obj_control 2)
		(print "g_la_obj_control set to 2")
		
	(sleep_until (volume_test_players tv_la_03) 1)
		(set g_la_obj_control 3)
		(print "g_la_obj_control set to 3")
		
	(sleep_until (volume_test_players tv_la_04) 1)
		(set g_la_obj_control 4)
		(print "g_la_obj_control set to 4")
		
	(sleep_until (volume_test_players tv_la_05) 1)
		(set g_la_obj_control 5)
		(print "g_la_obj_control set to 5")
		;placing ai
		(ai_place sq_la_jackal_01)
		(ai_place sq_la_brute_06)
		(game_save)
		
	(sleep_until (volume_test_players tv_la_06) 1)
		(set g_la_obj_control 6)
		(print "g_la_obj_control set to 6")
		
	(sleep_until (volume_test_players tv_la_07) 1)
		(set g_la_obj_control 7)
		(print "g_la_obj_control set to 7")
		(game_save)
		
	(sleep_until (volume_test_players tv_la_08) 1)
		(set g_la_obj_control 8)
		(print "g_la_obj_control set to 8")
				
	(sleep_until (volume_test_players tv_la_09) 1)
		(set g_la_obj_control 9)
		(print "g_la_obj_control set to 9")
		;placing ai
		(ai_place sq_la_brute_04)
		(ai_place sq_la_brute_05)
				
	(sleep_until (volume_test_players tv_la_10) 1)
		(set g_la_obj_control 10)
		(print "g_la_obj_control set to 10")
		(game_save)
		
	(sleep_until (volume_test_players tv_la_11) 1)
		(set g_la_obj_control 11)
		(print "g_la_obj_control set to 11")
		;waking buggers for server rise
		(wake sc_la_bugger_server)
				
	(sleep_until (volume_test_players tv_la_12) 1)
		(set g_la_obj_control 12)
		(print "g_la_obj_control set to 12")
		(game_save)
						
)


;============================================ LAB A SECONDARY SCRIPTS =========================================================

;buggers flying out of the server
(script dormant sc_la_bugger_server
	(sleep_until (>= (device_get_position la_server_on_01) 0.1))
		(ai_place sq_la_bugger_01)

)

; command script for bugger wave2a
(script command_script cs_la_bugger_01
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to la_bugger_server_01/p0)
		(cs_fly_to la_bugger_server_01/p1)
		(cs_fly_to la_bugger_server_01/p2)
)

(script dormant cs_la_door_flutter
	(device_set_power la_door_large_08 1)
		(sleep_until
			(begin
				(device_set_position la_door_large_08 0.3)
				(sleep 13)
				(device_set_position la_door_large_08 0.1)
			FALSE)
		60)
)

;==============================================================================================================================
;====================================================== LABYRINTH B ===========================================================
;==============================================================================================================================

;encounter script for Labyrinth B
(script dormant enc_labyrinth_b
	
	(sleep_until (volume_test_players tv_lb_01) 1)
		(set g_lb_obj_control 1)
		(print "g_lb_obj_control set to 1")
		;placing ai
		(ai_place sq_lb_brute_01)
		(ai_place sq_lb_bugger_01)
		(ai_place sq_lb_bugger_02)
		(sleep 1)
		(ai_place sq_lb_jackal_01)
		(ai_place sq_lb_brute_02)
		(ai_place sq_lb_brute_03)
		(game_save)
		
	(sleep_until (volume_test_players tv_lb_02) 1)
		(set g_lb_obj_control 2)
		(print "g_lb_obj_control set to 2")
		
		
	(sleep_until (volume_test_players tv_lb_03) 1)
		(set g_lb_obj_control 3)
		(print "g_lb_obj_control set to 3")
		(game_save)
		
	(sleep_until (volume_test_players tv_lb_04) 1)
		(set g_lb_obj_control 4)
		(print "g_lb_obj_control set to 4")
				
	(sleep_until (volume_test_players tv_lb_05) 1)
		(set g_lb_obj_control 5)
		(print "g_lb_obj_control set to 5")
		(game_save)
		
	(sleep_until (volume_test_players tv_lb_06) 1)
		(set g_lb_obj_control 6)
		(print "g_lb_obj_control set to 6")
				
	(sleep_until (volume_test_players tv_lb_07) 1)
		(set g_lb_obj_control 7)
		(print "g_lb_obj_control set to 7")
		;placing ai
		(ai_place sq_lb_bugger_03)
		(ai_place sq_lb_bugger_04)
		(ai_place sq_lb_bugger_05)
				
	(sleep_until (volume_test_players tv_lb_08) 1)
		(set g_lb_obj_control 8)
		(print "g_lb_obj_control set to 8")
		;placing ai
		(ai_place sq_lb_brute_04)
		(ai_place sq_lb_brute_05)
		
	(sleep_until (volume_test_players tv_lb_09) 1)
		(set g_lb_obj_control 9)
		(print "g_lb_obj_control set to 9")
		;placing ai
		(ai_place sq_lb_brute_06)
		(ai_place sq_lb_brute_07)
				
	(sleep_until (volume_test_players tv_lb_10) 1)
		(set g_lb_obj_control 10)
		(print "g_lb_obj_control set to 10")
			
	(sleep_until (volume_test_players tv_lb_11) 1)
		(set g_lb_obj_control 11)
		(print "g_lb_obj_control set to 11")
		(game_save)
		
	(sleep_until (volume_test_players tv_lb_12) 1)
		(set g_lb_obj_control 12)
		(print "g_lb_obj_control set to 12")
				
	(sleep_until (volume_test_players tv_lb_13) 1)
		(set g_lb_obj_control 13)
		(print "g_lb_obj_control set to 13")
		;placing ai
		(ai_place sq_lb_brute_08)
		(ai_place sq_lb_grunts_01)
		(sleep 1)
		(ai_place sq_lb_brute_09)
		(ai_place sq_lb_jackal_02)
				
	(sleep_until (volume_test_players tv_lb_14) 1)
		(set g_lb_obj_control 14)
		(print "g_lb_obj_control set to 14")
		(game_save)
		
	(sleep_until (volume_test_players tv_lb_15) 1)
		(set g_lb_obj_control 15)
		(print "g_lb_obj_control set to 15")
				
	(sleep_until (volume_test_players tv_lb_16) 1)
		(set g_lb_obj_control 16)
		(print "g_lb_obj_control set to 16")
		(game_save)
		
	(sleep_until (volume_test_players tv_lb_17) 1)
		(set g_lb_obj_control 17)
		(print "g_lb_obj_control set to 17")
		
	(sleep_until (volume_test_players tv_lb_18) 1)
		(set g_lb_obj_control 18)
		(print "g_lb_obj_control set to 18")
				
)


; =========================================== LAB B SECONDARY SCRIPTS =========================================================

; command script for lab b buggers eating 01
(script command_script cs_lb_bugger_01
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE) 
	
	(ai_activity_set sq_lb_bugger_01 "act_bugger_lunch")
	(ai_activity_set sq_lb_bugger_02 "act_bugger_lunch")
)


(script command_script cs_lb_bugger_03
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE) 
	
	(cs_fly_to lb_bugger_03/p0)
	(cs_fly_to lb_bugger_03/p1)
	(cs_fly_to lb_bugger_03/p2)
	(cs_fly_to lb_bugger_03/p3)
	
)

(script command_script cs_lb_bugger_04
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE) 
	
	(cs_fly_to lb_bugger_04/p0)
	(cs_fly_to lb_bugger_04/p1)
	
)

(script command_script cs_lb_bugger_05
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE) 
	
	(cs_fly_to lb_bugger_05/p0)
	(cs_fly_to lb_bugger_05/p1)
	
)
;==============================================================================================================================
;====================================================== LABYRINTH C ===========================================================
;==============================================================================================================================

;objective control for Labyrinth C
(script dormant enc_labyrinth_c
	
	(sleep_until (volume_test_players tv_lc_01) 1)
		(set g_lc_obj_control 1)
		(print "g_lc_obj_control set to 1")
		;placing ai
		(ai_place sq_lc_bugger_01)
		(ai_place sq_lc_brute_01)
		(ai_place sq_lc_brute_02)
		(game_save)
		
	(sleep_until (volume_test_players tv_lc_02) 1)
		(set g_lc_obj_control 2)
		(print "g_lc_obj_control set to 2")
		
	(sleep_until (volume_test_players tv_lc_03) 1)
		(set g_lc_obj_control 3)
		(print "g_lc_obj_control set to 3")
				
	(sleep_until (volume_test_players tv_lc_04) 1)
		(set g_lc_obj_control 4)
		(print "g_lc_obj_control set to 4")
		
	(sleep_until (volume_test_players tv_lc_05) 1)
		(set g_lc_obj_control 5)
		(print "g_lc_obj_control set to 5")
		(game_save)
		
	(sleep_until (volume_test_players tv_lc_06) 1)
		(set g_lc_obj_control 6)
		(print "g_lc_obj_control set to 6")
		
	(sleep_until (volume_test_players tv_lc_07) 1)
		(set g_lc_obj_control 7)
		(print "g_lc_obj_control set to 7")
		;placing ai
		(ai_place sq_lc_bugger_02)
		(ai_place sq_lc_brute_03)
		(sleep 1)
		(ai_place sq_lc_brute_04)
		(ai_place sq_lc_brute_05)
		(sleep 1)
		(ai_place sq_lc_brute_06)
		(ai_place sq_lc_brute_07)
				
	(sleep_until (volume_test_players tv_lc_08) 1)
		(set g_lc_obj_control 8)
		(print "g_lc_obj_control set to 8")
		
	(sleep_until (volume_test_players tv_lc_09) 1)
		(set g_lc_obj_control 9)
		(print "g_lc_obj_control set to 9")
		(game_save)
		
	(sleep_until (volume_test_players tv_lc_10) 1)
		(set g_lc_obj_control 10)
		(print "g_lc_obj_control set to 10")
				
	(sleep_until (volume_test_players tv_lc_11) 1)
		(set g_lc_obj_control 11)
		(print "g_lc_obj_control set to 11")
				
	(sleep_until (volume_test_players tv_lc_12) 1)
		(set g_lc_obj_control 12)
		(print "g_lc_obj_control set to 12")
		
	(sleep_until (volume_test_players tv_lc_13) 1)
		(set g_lc_obj_control 13)
		(print "g_lc_obj_control set to 13")
		(game_save)
)

;==============================================================================================================================
;===================================================== LABYRINTH D ============================================================
;==============================================================================================================================

;objective control for Labyrinth D
(script dormant enc_labyrinth_d
	
	(sleep_until (volume_test_players tv_ld_01) 1)
		(set g_ld_obj_control 1)
		(print "g_ld_obj_control set to 1")
		;placing ai
		(ai_place sq_ld_brute_01)
		(ai_place sq_ld_brute_02)
		(sleep 1)
		(ai_place sq_ld_brute_03)
		(game_save)
		
	(sleep_until (volume_test_players tv_ld_02) 1)
		(set g_ld_obj_control 2)
		(print "g_ld_obj_control set to 2")
				
	(sleep_until (volume_test_players tv_ld_03) 1)
		(set g_ld_obj_control 3)
		(print "g_ld_obj_control set to 3")
				
	(sleep_until (volume_test_players tv_ld_04) 1)
		(set g_ld_obj_control 4)
		(print "g_ld_obj_control set to 4")
		(game_save)
		
	(sleep_until (volume_test_players tv_ld_05) 1)
		(set g_ld_obj_control 5)
		(print "g_ld_obj_control set to 5")
				
	(sleep_until (volume_test_players tv_ld_06) 1)
		(set g_ld_obj_control 6)
		(print "g_ld_obj_control set to 6")
				
	(sleep_until (volume_test_players tv_ld_07) 1)
		(set g_ld_obj_control 7)
		(print "g_ld_obj_control set to 7")
		(ai_place sq_ld_brute_04)
		(sleep 10)
		(ai_place sq_ld_bugger_01)
		(game_save)		
)


;============================================ LABYRINTH D SECONDARY SCRIPTS ===================================================

; buggers flying through the doors to attack player
(script command_script cs_ld_bugger_01
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE) 
	
	(cs_fly_to ld_bugger_01/p0)
	(cs_fly_to ld_bugger_01/p1)
	(cs_fly_to ld_bugger_01/p2)	
)
;==============================================================================================================================
;======================================================== RESCUE ==============================================================
;==============================================================================================================================

;objective control for Rescue
(script dormant enc_rescue
	
	(sleep_until (volume_test_players tv_res_01) 1)
		(set g_res_obj_control 1)
		(print "g_res_obj_control set to 1")
		(game_save)
		
	(sleep_until (volume_test_players tv_res_02) 1)
		(set g_res_obj_control 2)
		(print "g_res_obj_control set to 2")
		(ai_place sq_res_brute_01)
		(ai_place sq_res_bugger_01)
		(sleep 1)
		(ai_place sq_res_bugger_02)
		(ai_place sq_res_brute_02)
		
	(sleep_until (volume_test_players tv_res_03) 1)
		(set g_res_obj_control 3)
		(print "g_res_obj_control set to 3")
		(wake sc_rescue_open_door)
		(game_save)
		
	(sleep_until (volume_test_players tv_res_04) 1)
		(set g_res_obj_control 4)
		(print "g_res_obj_control set to 4")
		
	(sleep_until (volume_test_players tv_res_05) 1)
		(set g_res_obj_control 5)
		(print "g_res_obj_control set to 5")
		(game_save)
		
	(sleep_until (volume_test_players tv_res_06) 1)
		(set g_res_obj_control 6)
		(print "g_res_obj_control set to 6")
		
	(sleep_until (volume_test_players tv_res_07) 1)
		(set g_res_obj_control 7)
		(print "g_res_obj_control set to 7")
		(game_save)
)


;============================================ RESCUE SECONDARY SCRIPTS ========================================================

;this controls when the player is able to get through the door and rescue dare
(script dormant sc_rescue_open_door
	(sleep_until
		(and
			(<= (ai_living_count sq_res_brute_01) 0)
			(<= (ai_living_count sq_res_brute_02) 0)
			(<= (ai_living_count sq_res_bugger_01) 0)
			(<= (ai_living_count sq_res_bugger_02) 0)
		)
	1)
	(sleep 90)
	(device_set_power res_door_large_01 1)
)
;==============================================================================================================================
;======================================================== DATA REVEAL =========================================================
;==============================================================================================================================

;objective control for Data Reveal
(script dormant enc_data_reveal

	;making sure dare doesn't die
	(ai_cannot_die dare_01 TRUE)
	
	(sleep_until (volume_test_players tv_dr_01) 1)
		(set g_dr_obj_control 1)
		(print "g_dr_obj_control set to 1")
		;placing dare character
		(ai_place sq_dr_dare_01)
		(game_save)

	(sleep_until (volume_test_players tv_dr_02) 1)
		(set g_dr_obj_control 2)
		(print "g_dr_obj_control set to 2")
		(if (cinematic_skip_start)
			(begin
				(cinematic_snap_to_black)
				(ai_erase sq_dr_dare_01)
				;getting rid of door
				(object_destroy dr_door_small_06)
				(object_destroy dr_door_small_07)
				(sleep 1)
				
				(if debug (print "Meeting Dare"))
				(l200_va_dare)
			)
		)
		(cinematic_skip_stop)
		(sleep 1)
		(ai_place sq_dr_dare_01)
		(sleep 5)
		
		; teleport players to the proper locations 
		(object_teleport (player0) player0_dr_cine_end)
		(object_teleport (player1) player1_dr_cine_end)
		(object_teleport (player2) player2_dr_cine_end)
		(object_teleport (player3) player3_dr_cine_end)
		(sleep 5)
		(object_create dr_door_small_06)
		(object_create dr_door_small_07)
		(device_set_power dr_door_small_07 1)
		(device_set_position dr_door_small_07 1)
		(sleep 5)
		
		(cinematic_fade_to_gameplay)
		
	(sleep_until (volume_test_players tv_dr_03) 1)
		(set g_dr_obj_control 3)
		(print "g_dr_obj_control set to 3")
		;placing ai
		(ai_place sq_dr_brute_01)
		(ai_place sq_dr_brute_02)
		(ai_place sq_dr_brute_03)
		(sleep 1)
		(ai_place sq_dr_brute_04)
		(ai_place sq_dr_brute_05)
		
	(sleep_until (volume_test_players tv_dr_04) 1)
		(set g_dr_obj_control 4)
		(print "g_dr_obj_control set to 4")
		
	(sleep_until (volume_test_players tv_dr_05) 1)
		(set g_dr_obj_control 5)
		(print "g_dr_obj_control set to 5")
		(ai_set_objective dare_01 dr_friendly_02)
		
	(sleep_until (volume_test_players tv_dr_06) 1)
		(set g_dr_obj_control 6)
		(print "g_dr_obj_control set to 6")
		
	(sleep_until (volume_test_players tv_dr_07) 1)
		(set g_dr_obj_control 7)
		(print "g_dr_obj_control set to 7")
		
	(sleep_until (volume_test_players tv_dr_08) 1)
		(set g_dr_obj_control 8)
		(print "g_dr_obj_control set to 8")
		
	(sleep_until (volume_test_players tv_dr_09) 1)
		(set g_dr_obj_control 9)
		(print "g_dr_obj_control set to 9")
		
	(sleep_until (volume_test_players tv_dr_10) 1)
		(set g_dr_obj_control 10)
		(print "g_dr_obj_control set to 10")
		
	(sleep_until (volume_test_players tv_dr_11) 1)
		(set g_dr_obj_control 11)
		(print "g_dr_obj_control set to 11")
		
	(sleep_until (volume_test_players tv_dr_12) 1)
		(set g_dr_obj_control 12)
		(print "g_dr_obj_control set to 12")
		(ai_set_objective dare_01 dr_friendly_03)
		
	(sleep_until (volume_test_players tv_dr_13) 1)
		(set g_dr_obj_control 13)
		(print "g_dr_obj_control set to 13")
		
	(sleep_until (volume_test_players tv_dr_14) 1)
		(set g_dr_obj_control 14)
		(print "g_dr_obj_control set to 14")
		
	(sleep_until (volume_test_players tv_dr_15) 1)
		(set g_dr_obj_control 15)
		(print "g_dr_obj_control set to 15")
		
)

	
;==============================================================================================================================
;======================================================== PIPE ROOM ===========================================================
;==============================================================================================================================

;objective control for Pipe Room
(script dormant enc_pipe_room
	
	;making sure dare doesn't die
	(ai_cannot_die dare_01 TRUE)
	
	;kill volumes for survival mode
	(kill_volume_disable kill_pipe_trough)
	
	;soft ceilings for survival mode
	(soft_ceiling_enable l200_survival FALSE)
	
	;enabling doors
	(device_set_power pr_small_door_14 1)
	(device_set_power pr_small_door_15 1)
	
	(sleep_until (volume_test_players tv_pr_01) 1)
		(set g_pr_obj_control 1)
		(print "g_pr_obj_control set to 1")
		(ai_place sq_pr_brute_01)
		(ai_place sq_pr_brute_02)
		(ai_set_objective dare_01 pipe_room_01)
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_02) 1)
		(set g_pr_obj_control 2)
		(print "g_pr_obj_control set to 2")
		
	(sleep_until (volume_test_players tv_pr_03) 1)
		(set g_pr_obj_control 3)
		(print "g_pr_obj_control set to 3")
		(ai_place sq_pr_brute_03)
		(ai_place sq_pr_brute_04)
		(ai_place sq_pr_brute_05)
		(sleep 1)
		(ai_place sq_pr_brute_06)
		(ai_place sq_pr_brute_07)
		(sleep 1)
		(ai_place sq_pr_chieftain_01)
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_04) 1)
		(set g_pr_obj_control 4)
		(print "g_pr_obj_control set to 4")
		(ai_set_objective dare_01 pipe_room_02)
		
	(sleep_until (volume_test_players tv_pr_05) 1)
		(set g_pr_obj_control 5)
		(print "g_pr_obj_control set to 5")
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_06) 1)
		(set g_pr_obj_control 6)
		(print "g_pr_obj_control set to 6")
		(game_save)		
		
	(sleep_until (volume_test_players tv_pr_07) 1)
		(set g_pr_obj_control 7)
		(print "g_pr_obj_control set to 7")
		
	(sleep_until (volume_test_players tv_pr_08) 1)
		(set g_pr_obj_control 8)
		(print "g_pr_obj_control set to 8")
		(ai_set_objective dare_01 pipe_room_03)
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_09) 1)
		(set g_pr_obj_control 9)
		(print "g_pr_obj_control set to 9")
		(monster_closet_door sq_pr_jackal_01 pr_small_door_22 tv_pr_door_22_test)
		(monster_closet_door sq_pr_jackal_02 pr_small_door_21 tv_pr_door_21_test)

		
	(sleep_until (volume_test_players tv_pr_10) 1)
		(set g_pr_obj_control 10)
		(print "g_pr_obj_control set to 10")
		(ai_place sq_pr_bugger_01)
		(ai_place sq_pr_bugger_02)
		(sleep 1)
		(monster_closet_door sq_pr_brute_08 pr_small_door_12 tv_pr_door_12_test)
		(monster_closet_door sq_pr_brute_09 pr_small_door_13 tv_pr_door_13_test)
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_11) 1)
		(set g_pr_obj_control 11)
		(print "g_pr_obj_control set to 11")
		(ai_place sq_pr_brute_10)
		(ai_place sq_pr_brute_11)
		
	(sleep_until (volume_test_players tv_pr_12) 1)
		(set g_pr_obj_control 12)
		(print "g_pr_obj_control set to 12")
		(ai_place sq_pr_bugger_03)
		(ai_place sq_pr_bugger_04)
		(game_save)
		
	(sleep_until (volume_test_players tv_pr_13) 1)
		(set g_pr_obj_control 13)
		(print "g_pr_obj_control set to 13")
		
)

;=============================================== PIPE ROOM SECONDARY SCRIPTS ==================================================

; command script for pipe room bugger 01
(script command_script cs_pr_bugger_01
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to pr_bugger_01/p0)
		(cs_fly_to pr_bugger_01/p1)
)

; command script for pipe room bugger 02
(script command_script cs_pr_bugger_02
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to pr_bugger_02/p0)
		(cs_fly_to pr_bugger_02/p1)
		(cs_fly_to pr_bugger_02/p2)
)

; command script for pipe room bugger 03
(script command_script cs_pr_bugger_03
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to pr_bugger_03/p0)
		(cs_fly_to pr_bugger_03/p1)
		(cs_fly_to pr_bugger_03/p2)
)

; command script for pipe room bugger 04
(script command_script cs_pr_bugger_04
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_fly_to pr_bugger_04/p0)
		(cs_fly_to pr_bugger_04/p1)
		(cs_fly_to pr_bugger_04/p2)
)

;spawning guys coming out of locked doors and closing them back up
(script static void (monster_closet_door (ai spawned_squad)(device machine_door) (trigger_volume vol_name))
	(device_set_power machine_door 1)
	(sleep 5)
	(ai_place spawned_squad)
	(sleep 5)
	(device_set_position machine_door 1)
	(sleep 30)
		(sleep_until
			(and
				(not	(volume_test_players vol_name))
				(not (volume_test_objects vol_name (ai_get_object spawned_squad)))
			)
		5)
	(print "closing door...")
	(device_set_position machine_door 0)
	(sleep_until
		(begin
			(if 
				(and
					(not (volume_test_players vol_name))
					(not (volume_test_objects vol_name (ai_get_object spawned_squad)))
					(= (device_get_position machine_door) 0)
				)
				(device_set_power machine_door 0)                    
			)
		TRUE)
	1)
)

;==============================================================================================================================
;======================================================= DATA CORE ============================================================
;==============================================================================================================================


;objective control for Data Core
(script dormant enc_data_core

	;making sure ai doesn't die
	(ai_cannot_die dare_01 TRUE)
	(ai_cannot_die sq_engineer TRUE)
	(ai_cannot_die dc_buck TRUE)
	
	;changing dare over to the next objective
	(ai_set_objective dare_01 data_core_01)

	
	(sleep_until (volume_test_players tv_dc_01) 1)
		(set g_dc_obj_control 1)
		(print "g_dc_obj_control set to 1")
		(cs_run_command_script dare_01 cs_dc_dare_jump_01)
		(ai_place sq_dc_brutes_01)
		(ai_place sq_dc_chieftain_01)
		
	(sleep_until (volume_test_players tv_dc_02) 1)
		(set g_dc_obj_control 2)
		(print "g_dc_obj_control set to 2")
		
	(sleep_until (volume_test_players tv_dc_03) 1)
		(set g_dc_obj_control 3)
		(print "g_dc_obj_control set to 3")
		(ai_set_objective dare_01 data_core_02)
		;(wake sc_dc_chieftain_phantom)
				
	(sleep_until (volume_test_players tv_dc_04) 1)
		(set g_dc_obj_control 4)
		(print "g_dc_obj_control set to 4")
		(wake sc_dc_open_data_door)
		
	(sleep_until (volume_test_players tv_dc_05) 1)
		(set g_dc_obj_control 5)
		(print "g_dc_obj_control set to 5")
		
	(sleep_until (volume_test_players tv_dc_06) 1)
		(set g_dc_obj_control 6)
		(print "g_dc_obj_control set to 6")
		(ai_set_objective dare_01 data_core_03)
		
	(sleep_until (volume_test_players tv_dc_07) 1)
		(set g_dc_obj_control 7)
		(print "g_dc_obj_control set to 7")

	(sleep_until (volume_test_players tv_dc_08) 1)
		(set g_dc_obj_control 8)
		(print "g_dc_obj_control set to 8")
		(if (cinematic_skip_start)
			(begin
				(cinematic_snap_to_black)
				(ai_erase dare_01)
				(sleep 1)
				
				(if debug (print "Meeting the Engineer"))
				(l200_super)
			)
		)
		(cinematic_skip_stop)
		(sleep 1)
		(ai_place sq_dc_dare_02)
		(ai_place sq_dc_engineer)
		(sleep 5)
		
		; teleport players to the proper locations 
		(object_teleport (player0) player0_dc_cine_end)
		(object_teleport (player1) player1_dc_cine_end)
		(object_teleport (player2) player2_dc_cine_end)
		(object_teleport (player3) player3_dc_cine_end)
		(sleep 5)
		
		(cinematic_fade_to_gameplay)
		
	(sleep_until (volume_test_players tv_dc_07) 1)
		(set g_dc_obj_control 9)
		(print "g_dc_obj_control set to 9")
		(ai_place sq_dc_buck)
		(sleep 5)
		(ai_place sq_dc_phantom_01_left)
		(ai_place sq_dc_phantom_01_right)
		
	(sleep_until (volume_test_players tv_dc_06) 1)
		(set g_dc_obj_control 10)
		(print "g_dc_obj_control set to 10")
		(ai_set_objective dare_01 data_core_04)
		(ai_set_objective sq_engineer data_core_04)
		
	(sleep_until (volume_test_players tv_dc_05) 1)
		(set g_dc_obj_control 11)
		(print "g_dc_obj_control set to 11")
		(wake sc_dc_open_data_leave)
		
	(sleep_until (volume_test_players tv_dc_04) 1)
		(set g_dc_obj_control 12)
		(print "g_dc_obj_control set to 12")
)

;================================================= DATA CORE SECONDARY SCRIPTS ================================================

; command script for dare running into the data core main room
(script command_script cs_dc_dare_jump_01
	(cs_abort_on_damage FALSE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           
                
		(cs_go_to dc_dare_jump_01/p0)
		(cs_go_to dc_dare_jump_01/p1)
		(cs_go_to dc_dare_jump_01/p2)
		(cs_go_to dc_dare_jump_01/p3)
		(sleep_until (= g_dc_obj_control 3))
		(cs_go_to dc_dare_jump_01/p4)
		(sleep_until (= g_dc_obj_control 4))
		(cs_jump_to_point 0 1)
)


;phantom command script to go right
(script command_script cs_dc_phantom_01_right
	(cs_enable_pathfinding_failsafe TRUE)
	
	(set v_sq_dc_phantom_01 (ai_vehicle_get_from_starting_location sq_dc_phantom_01_right/pilot))
	(sleep 1)
	
	(ai_place sq_dc_brute_gr_01)
	(ai_place sq_dc_brute_gr_02)
	(ai_vehicle_enter_immediate sq_dc_brute_gr_01 v_sq_dc_phantom_01 "phantom_p_rf")
	(ai_vehicle_enter_immediate sq_dc_brute_gr_02 v_sq_dc_phantom_01 "phantom_p_rb")
	
		(cs_vehicle_speed 1)
		(cs_fly_to dc_phantom_right/p0)
		(cs_fly_to dc_phantom_right/p1)
		(cs_fly_to_and_face dc_phantom_right/p2 dc_phantom_right/p3)
		(cs_fly_to dc_phantom_right/p3)
		(cs_fly_to dc_phantom_right/p4)
		(cs_fly_to dc_phantom_right/p5)
		(cs_fly_to_and_face dc_phantom_right/p6 dc_phantom_right/p7)
		(vehicle_unload v_sq_dc_phantom_01 "phantom_p_rf")
		(vehicle_unload v_sq_dc_phantom_01 "phantom_p_rb")
		(sleep (random_range 180 300))
		(cs_fly_to dc_phantom_right/p5)
		(cs_fly_to dc_phantom_right/p4)
		(cs_fly_to dc_phantom_right/p3)
		(cs_fly_to dc_phantom_right/p2)
		(cs_fly_to dc_phantom_right/p1)
		(cs_fly_to_and_face dc_phantom_right/p0 dc_phantom_right/p8)
		(cs_fly_to dc_phantom_right/p9)
		(sleep 30)
		(ai_erase sq_dc_phantom_01_right)
)

;phantom command script to go left
(script command_script cs_dc_phantom_01_left
	(cs_enable_pathfinding_failsafe TRUE)
	
	(set v_sq_dc_phantom_02 (ai_vehicle_get_from_starting_location sq_dc_phantom_01_left/pilot))
	(sleep 1)
	
	(ai_place sq_dc_brute_gr_03)
	(ai_place sq_dc_brute_gr_04)
	(ai_vehicle_enter_immediate sq_dc_brute_gr_03 v_sq_dc_phantom_02 "phantom_p_lf")
	(ai_vehicle_enter_immediate sq_dc_brute_gr_04 v_sq_dc_phantom_02 "phantom_p_lb")
	
		(cs_vehicle_speed 1)
		(cs_fly_to dc_phantom_left/p0)
		(cs_fly_to dc_phantom_left/p1)
		(cs_fly_to_and_face dc_phantom_left/p2 dc_phantom_left/p3)
		(cs_fly_to dc_phantom_left/p3)
		(cs_fly_to dc_phantom_left/p4)
		(cs_fly_to dc_phantom_left/p5)
		(cs_fly_to_and_face dc_phantom_left/p6 dc_phantom_left/p7)
		(vehicle_unload v_sq_dc_phantom_02 "phantom_p_lf")
		(vehicle_unload v_sq_dc_phantom_02 "phantom_p_lb")
		(sleep (random_range 180 300))
		(cs_fly_to dc_phantom_left/p5)
		(cs_fly_to dc_phantom_left/p4)
		(cs_fly_to dc_phantom_left/p3)
		(cs_fly_to dc_phantom_left/p2)
		(cs_fly_to dc_phantom_left/p1)
		(cs_fly_to_and_face dc_phantom_left/p0 dc_phantom_left/p8)
		(cs_fly_to dc_phantom_left/p9)
		(sleep 30)
		(ai_erase sq_dc_phantom_01_left)
)

;phantom command script to go to the center
(script command_script cs_dc_phantom_01_center
	(cs_enable_pathfinding_failsafe TRUE)
	
	(set v_sq_dc_phantom_03 (ai_vehicle_get_from_starting_location sq_dc_phantom_01_center/pilot))
	(sleep 1)
	
	(ai_place sq_dc_brutes_01)
	(ai_place sq_dc_chieftain_01)
	(ai_vehicle_enter_immediate sq_dc_brutes_01 v_sq_dc_phantom_03 "phantom_p_rb")
	(ai_vehicle_enter_immediate sq_dc_chieftain_01 v_sq_dc_phantom_03 "phantom_p_rf")
	
		(cs_vehicle_speed 1)
		(cs_fly_to dc_phantom_center/p0)
		(cs_fly_to dc_phantom_center/p1)
		(cs_fly_to dc_phantom_center/p2)
		(cs_fly_to dc_phantom_center/p3)
		(cs_fly_to_and_face dc_phantom_center/p4 dc_phantom_center/p7)
		(vehicle_unload v_sq_dc_phantom_03 "phantom_p_rb")
		(vehicle_unload v_sq_dc_phantom_03 "phantom_p_rf")
		(sleep (random_range 180 300))
		(cs_fly_to dc_phantom_center/p3)
		(cs_fly_to dc_phantom_center/p2)
		(cs_fly_to dc_phantom_center/p1)
		(cs_fly_to_and_face dc_phantom_center/p0 dc_phantom_center/p5)
		(cs_fly_to dc_phantom_center/p6)
		(sleep 30)
		(ai_erase sq_dc_phantom_01_center)
)

;checking when to send in final reinforcements
(script dormant sc_dc_chieftain_phantom
	(sleep_until 
		(and
			(= g_dc_obj_control 3)
			(<= (ai_living_count dc_brute_last_push) 6)
		)
	5)
	(ai_place sq_dc_phantom_01_center)
)

;checking to open the door to get into data core
(script dormant sc_dc_open_data_door
	(sleep_until
		(and
			(<= (ai_living_count dc_brutes) 0)
			(<= (ai_living_count dc_chieftain) 0)
			(= g_dc_obj_control 5)
		)
	5)
	(sleep 90)
	(device_set_power dc_small_door_05 1)
)

;checking to open the door to leave data core
(script dormant sc_dc_open_data_leave
	(sleep_until (= g_dc_obj_control 12))
	(sleep 90)
	(device_set_power dc_small_door_06 1)
	(device_set_power dc_small_door_07 1)
)

;brutes shooting the door
(script command_script cs_dc_brute_shoot
	(cs_abort_on_damage TRUE)
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_enable_looking TRUE)
	(cs_enable_moving TRUE)           

	(sleep_until
		(begin_random
			(begin
				(cs_shoot_point TRUE dc_brute_shoot/p0)
				(sleep (random_range 180 300))
				(cs_shoot_point FALSE dc_brute_shoot/p0)
			FALSE)
			(begin
				(cs_shoot_point TRUE dc_brute_shoot/p1)
				(sleep (random_range 180 300))
				(cs_shoot_point FALSE dc_brute_shoot/p1)
			FALSE)
			(begin
				(cs_shoot_point TRUE dc_brute_shoot/p2)
				(sleep (random_range 180 300))
				(cs_shoot_point FALSE dc_brute_shoot/p2)
			FALSE)
			(begin
				(cs_shoot_point TRUE dc_brute_shoot/p3)
				(sleep (random_range 180 300))
				(cs_shoot_point FALSE dc_brute_shoot/p3)
			FALSE)
			(begin
				(cs_shoot_point TRUE dc_brute_shoot/p4)
				(sleep (random_range 180 300))
				(cs_shoot_point FALSE dc_brute_shoot/p4)
			FALSE)
		)
	5)
)
		
;==============================================================================================================================
;========================================================= FINAL AREA =========================================================
;==============================================================================================================================

;objective control for Final Area
(script dormant enc_final_area

	;making sure ai doesn't die
	(ai_cannot_die dare_01 TRUE)
	(ai_cannot_die sq_engineer TRUE)
	
	;changing dare and engineer over to the next objective
	(ai_set_objective dare_01 final_area_01)
	(ai_set_objective sq_engineer final_area_01)
	
	(sleep_until (volume_test_players tv_fa_01) 1)
		(set g_fa_obj_control 1)
		(print "g_fa_obj_control set to 1")
		
	(sleep_until (volume_test_players tv_fa_02) 1)
		(set g_fa_obj_control 2)
		(print "g_fa_obj_control set to 2")
		
	(sleep_until (volume_test_players tv_fa_03) 1)
		(set g_fa_obj_control 3)
		(print "g_fa_obj_control set to 3")
		
	(sleep_until (volume_test_players tv_fa_04) 1)
		(set g_fa_obj_control 4)
		(print "g_fa_obj_control set to 4")
		
	(sleep_until (volume_test_players tv_fa_05) 1)
		(set g_fa_obj_control 5)
		(print "g_fa_obj_control set to 5")
		
	(sleep_until (volume_test_players tv_fa_06) 1)
		(set g_fa_obj_control 6)
		(print "g_fa_obj_control set to 6")
		
	(sleep_until (volume_test_players tv_fa_07) 1)
		(set g_fa_obj_control 7)
		(print "g_fa_obj_control set to 7")
)


;=====================================================================================================================================
;===================================================== WORKSPACE =====================================================================
;=====================================================================================================================================

;*phantom spawning right
(script static void (spawn_phantom_right (ai spawned_vehicle) (ai spawned_vehicle_driver) (ai spawned_squad_01) (ai spawned_squad_02))
	(ai_place spawned_vehicle)
	(sleep 1)
	
	(set v_sq_dc_phantom_01 (ai_vehicle_get_from_starting_location spawned_vehicle_driver))
	(sleep 1)
	
	(ai_place spawned_squad_01)
	(ai_place spawned_squad_02)
	(ai_vehicle_enter_immediate spawned_squad_01 v_sq_dc_phantom_01 "phantom_p_rf")
	(ai_vehicle_enter_immediate spawned_squad_02 v_sq_dc_phantom_01 "phantom_p_rb")
	(sleep 1)
	(cs_run_command_script spawned_vehicle_driver cs_dc_phantom_01_right)
)

;phantom spawning left
(script static void (spawn_phantom_left (ai spawned_vehicle) (ai spawned_vehicle_driver) (ai spawned_squad_01) (ai spawned_squad_02))
	(ai_place spawned_vehicle)
	(sleep 1)
	
	(set v_sq_dc_phantom_01 (ai_vehicle_get_from_starting_location spawned_vehicle_driver))
	(sleep 1)
	
	(ai_place spawned_squad_01)
	(ai_place spawned_squad_02)
	(ai_vehicle_enter_immediate spawned_squad_01 v_sq_dc_phantom_01 "phantom_p_lf")
	(ai_vehicle_enter_immediate spawned_squad_02 v_sq_dc_phantom_01 "phantom_p_lb")
	(sleep 1)
	(cs_run_command_script spawned_vehicle cs_dc_phantom_01_left)
)

;phantom spawning center
(script static void (spawn_phantom_center (ai spawned_vehicle) (ai spawned_vehicle_driver) (ai spawned_squad_01) (ai spawned_squad_02))
	(ai_place spawned_vehicle)
	(sleep 1)
	
	(set v_sq_dc_phantom_01 (ai_vehicle_get_from_starting_location spawned_vehicle_driver))
	(sleep 1)
	
	(ai_place spawned_squad_01)
	(ai_place spawned_squad_02)
	(ai_vehicle_enter_immediate spawned_squad_01 v_sq_dc_phantom_01 "phantom_p_rb")
	(ai_vehicle_enter_immediate spawned_squad_02 v_sq_dc_phantom_01 "phantom_p_rf")
	(sleep 1)
	(cs_run_command_script spawned_vehicle cs_dc_phantom_01_center)
)*;
