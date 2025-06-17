;=========================================================================================
;================================ GLOBAL VARIABLES =======================================
;=========================================================================================
(global short g_set_all 24)

;=========================================================================================
;================================== LABYRINTH A ==========================================
;=========================================================================================
(script static void ins_labyrinth_a
	(print "insertion point : labyrinth a")
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set labyrinth_a)
		)
	)
	(sleep 1)
	
	(if (cinematic_skip_start)
		(begin
			(cinematic_snap_to_black)
			
			(if debug (print "L200_Underground"))
			(l200_intro_sc)
		)
	)
	(cinematic_skip_stop)

		; teleport players to the proper locations 
		(object_teleport (player0) player0_la_start)
		(object_teleport (player1) player1_la_start)
		(object_teleport (player2) player2_la_start)
		(object_teleport (player3) player3_la_start)
		(sleep 1)

			; set player pitch 
			(player0_set_pitch g_player_start_pitch 0)
			(player1_set_pitch g_player_start_pitch 0)
			(player2_set_pitch g_player_start_pitch 0)
			(player3_set_pitch g_player_start_pitch 0)
				(sleep 1)

			
	; set insertion point index 
	(set g_insertion_index 1)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	
	(cinematic_fade_to_gameplay)
	
)


;=========================================================================================
;================================== LABYRINTH B ==========================================
;=========================================================================================
(script static void ins_labyrinth_b
	(print "insertion point : labyrinth b")
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set labyrinth_b)
			(sleep 1)
		)
	)

	; set insertion point index 
	(set g_insertion_index 2)

		; set mission progress accordingly 
		(set g_la_obj_control 100)
	
	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_lb_start)
	(object_teleport (player1) player1_lb_start)
	(object_teleport (player2) player2_lb_start)
	(object_teleport (player3) player3_lb_start)
		(sleep 1)
		
	;opening server for passage
	(device_set_position la_server_on_01 1)
		
	(player_disable_movement FALSE)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)

	; un-pause metagame timer   
	(campaign_metagame_time_pause FALSE)

)

;=========================================================================================
;=================================== LABYRINTH C ==========================================
;=========================================================================================
(script static void ins_labyrinth_c
	(print "insertion point : labyrinth c")
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set labyrinth_c)
			(sleep 1)
		)
	)
	
	; set insertion point index 
	(set g_insertion_index 3)

		; set mission progress accordingly 
		(set g_la_obj_control 100)
		(set g_lb_obj_control 100)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_lc_start)
	(object_teleport (player1) player1_lc_start)
	(object_teleport (player2) player2_lc_start)
	(object_teleport (player3) player3_lc_start)
		(sleep 1)
	
	;opening server for passage
	(device_set_position lb_server_on_01 1)
	
	(player_disable_movement FALSE)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	
		(sleep 1)

	; un-pause metagame timer   
	(campaign_metagame_time_pause FALSE)
	
)

;=========================================================================================
;===================================== LABYRINTH D =======================================
;=========================================================================================
(script static void ins_labyrinth_d
	(print "insertion point : labyrinth d")

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set labyrinth_d)
			(sleep 1)
		)
	)

	; set insertion point index 
	(set g_insertion_index 4)

		; set mission progress accordingly 
		(set g_la_obj_control 100)
		(set g_lb_obj_control 100)
		(set g_lc_obj_control 100)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_ld_start)
	(object_teleport (player1) player1_ld_start)
	(object_teleport (player2) player2_ld_start)
	(object_teleport (player3) player3_ld_start)
		(sleep 1)
		
	;opening server for passage
	(device_set_position lc_server_on_01 1)
	
	(player_disable_movement FALSE)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)


	; un-pause metagame timer   
	(campaign_metagame_time_pause FALSE)
)

;=========================================================================================
;=================================== RESCUE ==============================================
;=========================================================================================
(script static void ins_rescue
	(print "insertion point : rescue")
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set rescue)
			(sleep 1)
		)
	)

	(sleep 1)

	; set insertion point index 
	(set g_insertion_index 5)

		; set mission progress accordingly 
		(set g_la_obj_control 100)
		(set g_lb_obj_control 100)
		(set g_lc_obj_control 100)
		(set g_ld_obj_control 100)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_res_start)
	(object_teleport (player1) player1_res_start)
	(object_teleport (player2) player2_res_start)
	(object_teleport (player3) player3_res_start)
		(sleep 1)	

	(player_disable_movement FALSE)
	
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)

	; un-pause metagame timer   
	(campaign_metagame_time_pause FALSE)
)

;=========================================================================================
;===================================== DATA REVEAL =======================================
;=========================================================================================
(script static void ins_data_reveal
	(print "insertion point : data reveal")

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set data_reveal)
			(sleep 1)
		)
	)

	; set insertion point index 
	(set g_insertion_index 6)
	
		; set mission progress accordingly 
		(set g_la_obj_control 100)
		(set g_lb_obj_control 100)
		(set g_lc_obj_control 100)
		(set g_ld_obj_control 100)
		(set g_res_obj_control 100)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_dr_start)
	(object_teleport (player1) player1_dr_start)
	(object_teleport (player2) player2_dr_start)
	(object_teleport (player3) player3_dr_start)
		(sleep 1)
	(player_disable_movement FALSE)
	
		(sleep 1)
	(device_set_power res_door_large_01 1)

	;wake up breadcrumbs script
	(wake pda_breadcrumbs)
	
	; un-pause metagame timer   
	(campaign_metagame_time_pause FALSE)
)

;=========================================================================================
;================================== PIPE ROOM ============================================
;=========================================================================================

(script static void ins_pipe_room
	(print "insertion point : pipe room")

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set pipe_room)
			(sleep 1)
		)
	)
	
	(sleep 1)

	; set insertion point index 
	(set g_insertion_index 7)


		; set mission progress accordingly 
		(set g_la_obj_control 100)
		(set g_lb_obj_control 100)
		(set g_lc_obj_control 100)
		(set g_ld_obj_control 100)
		(set g_res_obj_control 100)
		(set g_dr_obj_control 100)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_pr_start)
	(object_teleport (player1) player1_pr_start)
	(object_teleport (player2) player2_pr_start)
	(object_teleport (player3) player3_pr_start)
		(sleep 1)
	(player_disable_movement FALSE)
	

	; placing allies... 
	(print "placing allies...")
	(ai_place sq_pr_dare)
		(sleep 15)
		
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)

)

;=========================================================================================
;====================================== DATA CORE ========================================
;=========================================================================================
(script static void ins_data_core
	(print "insertion point : data core")

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set data_core)
			(sleep 1)
		)
	)

	(sleep 1)

	; set insertion point index 
	(set g_insertion_index 8)
	
		; set mission progress accordingly 
		(set g_la_obj_control 100)
		(set g_lb_obj_control 100)
		(set g_lc_obj_control 100)
		(set g_ld_obj_control 100)
		(set g_res_obj_control 100)
		(set g_dr_obj_control 100)
		(set g_pr_obj_control 100)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_dc_start)
	(object_teleport (player1) player1_dc_start)
	(object_teleport (player1) player2_dc_start)
	(object_teleport (player1) player3_dc_start)
		(sleep 1)
	(player_disable_movement FALSE)

	;placing allies... 
	(print "placing allies...")
	(ai_place sq_dc_dare)
		(sleep 1)
		
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)

)

;=========================================================================================
;===================================== FINAL AREA ========================================
;=========================================================================================
(script static void ins_final_area
	(print "insertion point : final area")

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set final_area)
			(sleep 1)
		)
	)

	(sleep 1)

	; set insertion point index 
	(set g_insertion_index 9)
	
		; set mission progress accordingly 
		(set g_la_obj_control 100)
		(set g_lb_obj_control 100)
		(set g_lc_obj_control 100)
		(set g_ld_obj_control 100)
		(set g_res_obj_control 100)
		(set g_dr_obj_control 100)
		(set g_pr_obj_control 100)
		(set g_dc_obj_control 100)

	; teleporting players... to the proper location 
	(print "teleporting players...")
	(object_teleport (player0) player0_fa_start)
	(object_teleport (player1) player1_fa_start)
	(object_teleport (player1) player2_fa_start)
	(object_teleport (player1) player3_fa_start)
		(sleep 1)
	(player_disable_movement FALSE)

	; placing allies... 
	;(print "placing allies...")
	;(ai_place sq_fa_dare)
	;(ai_place sq_fa_engineer)
		(sleep 1)
		
	;wake up breadcrumbs script
	(wake pda_breadcrumbs)

)

