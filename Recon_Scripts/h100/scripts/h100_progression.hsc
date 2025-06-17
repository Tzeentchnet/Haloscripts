;====================================================================================================================================================================================================
;================================== GAME PROGRESSION VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
;*
these variables are defined in the .game_progression tag in \globals 


====== INTEGERS ======

gp_current_scene 

- set the scene transition integer equal to the scene number

H100 = 0 

L100 = 1 

SC100 = 100 
SC110 = 110 
SC120 = 120 
SC130 = 130 
SC140 = 140 
SC150 = 150 

L200 = 2 
L300 = 3 

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

g_l300_complete 

*;

(script static void initialize_l100
	; switch to the proper zone set (based on the scene you are returning from) 
	; should be automatically handled in code (this is just a backup) 
		(if debug (print "switching zone set..."))
		(switch_zone_set set_050)

	; teleport players to the proper locations 
		(if debug (print "teleporting players..."))

	; create ___device_terminal___ and ___device_control___ objects for uncompleted scenes 
		(if debug (print "placing beacons and switches..."))
		(object_create_containing object_sc100)

	; activate pda beacons for sc100 
		(if debug (print "activating pda beacons..."))
		(pda_activate_beacon player fl_beacon_sc100 "beacon_waypoints" TRUE)

	; wake beacon listen script 
		(if debug (print "wake beacon listen scripts..."))
		(wake sc100_beacon_listen)

	; wake locked door markers 
	(locked_door_markers)
)


(script static void initialize_h100
	; switch to the proper zone set (based on the scene you are returning from) 
	; should be automatically handled in code (this is just a backup) 
		(if debug (print "switching zone set..."))
		(cond
			((= (gp_integer_get gp_current_scene) 100)	(switch_zone_set set_050_080))		; return from SC100 
			((= (gp_integer_get gp_current_scene) 110)	(switch_zone_set set_090))			; return from SC110 
			((= (gp_integer_get gp_current_scene) 120)	(switch_zone_set set_040))			; return from SC120 
			((= (gp_integer_get gp_current_scene) 130)	(switch_zone_set set_oni))			; return from SC130 
			((= (gp_integer_get gp_current_scene) 140)	(switch_zone_set set_030))			; return from SC140 
			((= (gp_integer_get gp_current_scene) 150)	(switch_zone_set set_000))			; return from SC150 
		)
		(sleep 1)
		

	; run transition in with parameters based on what scene players are returning from 
		(if debug (print "teleporting players..."))
		(cond
			((= (gp_integer_get gp_current_scene) 100)	(f_h100_transition_in
																	sc100_out_hb
																	fl_sc100_teleport_00
																	fl_sc100_teleport_01
																	fl_sc100_teleport_02
																	fl_sc100_teleport_03
												)
			)
			((= (gp_integer_get gp_current_scene) 110)	(f_h100_transition_in
																	sc110_out_hb
																	fl_sc110_teleport_00
																	fl_sc110_teleport_01
																	fl_sc110_teleport_02
																	fl_sc110_teleport_03
												)
			)
			((= (gp_integer_get gp_current_scene) 120)	(f_h100_transition_in
																	sc120_out_hb
																	fl_sc120_teleport_00
																	fl_sc120_teleport_01
																	fl_sc120_teleport_02
																	fl_sc120_teleport_03
												)
			)
			((= (gp_integer_get gp_current_scene) 130)	(f_h100_transition_in
																	sc130_out_hb
																	fl_sc130_teleport_00
																	fl_sc130_teleport_01
																	fl_sc130_teleport_02
																	fl_sc130_teleport_03
												)
			)
			((= (gp_integer_get gp_current_scene) 140)	(f_h100_transition_in
																	sc140_out_hb
																	fl_sc140_teleport_00
																	fl_sc140_teleport_01
																	fl_sc140_teleport_02
																	fl_sc140_teleport_03
												)
			)
			((= (gp_integer_get gp_current_scene) 150)	(f_h100_transition_in
																	sc150_int_hb
																	fl_sc150_teleport_00
																	fl_sc150_teleport_01
																	fl_sc150_teleport_02
																	fl_sc150_teleport_03
												)
			)
		)
		(sleep 1)

	; activate pda beacons for uncompleted scenes
		(if debug (print "activating pda beacons..."))
			(if (= (gp_boolean_get gp_sc110_complete) FALSE) (pda_activate_beacon player fl_beacon_sc110 "beacon_waypoints" TRUE))
			(if (= (gp_boolean_get gp_sc120_complete) FALSE) (pda_activate_beacon player fl_beacon_sc120 "beacon_waypoints" TRUE))
			(if (= (gp_boolean_get gp_sc130_complete) FALSE) (pda_activate_beacon player fl_beacon_sc130 "beacon_waypoints" TRUE))
			(if (= (gp_boolean_get gp_sc140_complete) FALSE) (pda_activate_beacon player fl_beacon_sc140 "beacon_waypoints" TRUE))
			(if (= (gp_boolean_get gp_sc150_complete) FALSE) (pda_activate_beacon player fl_beacon_sc150 "beacon_waypoints" TRUE))
			(sleep 1)
		
	; wake beacon listen scripts 
		(if debug (print "wake beacon listen scripts..."))
			(if (= (gp_boolean_get gp_sc110_complete) FALSE) (wake sc110_beacon_listen))
			(if (= (gp_boolean_get gp_sc120_complete) FALSE) (wake sc120_beacon_listen))
			(if (= (gp_boolean_get gp_sc130_complete) FALSE) (wake sc130_beacon_listen))
			(if (= (gp_boolean_get gp_sc140_complete) FALSE) (wake sc140_beacon_listen))
			(if (= (gp_boolean_get gp_sc150_complete) FALSE) (wake sc150_beacon_listen))
			(sleep 1)
		
	; device machine setup 
		(if debug (print "set device machines..."))
		(cond
			((= (gp_integer_get gp_current_scene) 100)	(begin
													(device_set_position_immediate dm_security_door_open_07 1)
													(device_closes_automatically_set dm_security_door_open_07 FALSE)
												)
			)
			((= (gp_integer_get gp_current_scene) 110)	(begin
													(sleep 1)
												)
			)
			((= (gp_integer_get gp_current_scene) 120)	(begin
													(sleep 1)
												)
			)
			((= (gp_integer_get gp_current_scene) 130)	(begin
													(sleep 1)
												)
			)
			((= (gp_integer_get gp_current_scene) 140)	(begin
													(sleep 1)
												)
			)
			((= (gp_integer_get gp_current_scene) 150)	(begin
													(sleep 1)
												)
			)
		)
		(sleep 1)
		
	; turn on any device groups that were off by default 
		(device_group_set_immediate dg_l100_door_03 1)
		
	; wake locked door markers 
	(locked_door_markers)
		
	; fade from black 
	(cinematic_fade_to_gameplay)
)

;====================================================================================================================================================================================================
;=============================== BEACON LISTEN SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================
(script dormant sc100_beacon_listen
	(object_destroy control_object_sc100)

	(sleep_until
		(begin
			(sleep_until (objects_can_see_object (players) beacon_object_sc100 10) 1)
			(object_create_anew control_object_sc100)
			
			(sleep_until	(or
							(not (objects_can_see_object (players) beacon_object_sc100 10))
							(= (device_group_get dg_beacon_sc100) 1)
						)
			1)
			(object_destroy control_object_sc100)
	
		; exit conditions 
		(= (device_group_get dg_beacon_sc100) 1))
	1)
	
	; set l100 game progression variable to TRUE 
	(gp_boolean_set gp_l100_complete TRUE)

	(f_h100_transition_out
						sc100_int_hb
						set_050
						sc100
	)
)

(script dormant sc110_beacon_listen
	(sleep_until (= (device_group_get dg_beacon_sc110) 1))
	(f_h100_transition_out
						sc110_int_hb
						set_090
						sc110
	)
)

(script dormant sc120_beacon_listen
	(sleep_until (= (device_group_get dg_beacon_sc120) 1))
	(f_h100_transition_out
						sc120_int_hb
						set_040
						sc120
	)
)

(script dormant sc130_beacon_listen
	(sleep_until (= (device_group_get dg_beacon_sc130) 1))
	(f_h100_transition_out
						sc130_int_hb
						set_oni
						sc130
	)
)

(script dormant sc140_beacon_listen
	(sleep_until (= (device_group_get dg_beacon_sc140) 1))
	(f_h100_transition_out
						sc140_int_hb
						set_030
						sc140
	)
)

(script dormant sc150_beacon_listen
	(sleep_until (= (device_group_get dg_beacon_sc150) 1))
	(f_h100_transition_out
						sc150_int_hb
						set_000
						sc150
	)
)

;====================================================================================================================================================================================================
;=============================== CINEMATIC TRANSITION SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================
(global boolean g_cinematic_playing FALSE)


(script static void (f_h100_transition_out
										(script cinematic_outro)			; script name defined in cinematic tag 
										(zone_set cinematic_zone_set)		; switch to proper zone set 
										(string_id scene_name)			; scene to transition to 
				)

	; fade to black 
	(cinematic_fade_to_black)
	(sleep 1)
	
	; switch zone sets 
	(switch_zone_set cinematic_zone_set)
	
		; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						(if debug (print "play outro cinematic..."))

						; cinematic is playing 
;						(set g_cinematic_playing TRUE)

						(evaluate cinematic_outro)
;						(sleep 1)
						
;						(sleep_until (= g_cinematic_playing FALSE))
						
						; cinematic snap to black 
						(cinematic_snap_to_black)
						
					)
				)
				(cinematic_skip_stop)
			)
		)
	
	; set cinematic variable to false 
	(set g_cinematic_playing FALSE)

	; switch to give scene 
	(if debug (print "switch to scene..."))
	(game_level_advance scene_name)
)

(script static void (f_h100_transition_in
					(script cinematic_intro)				; script name defined in cinematic tag 
					(cutscene_flag teleport_player0)		; teleport location for player0 
					(cutscene_flag teleport_player1)		; teleport location for player1 
					(cutscene_flag teleport_player2)		; teleport location for player2 
					(cutscene_flag teleport_player3)		; teleport location for player3 
				)
	
		; teleport players 
		(object_teleport (player0) teleport_player0)
		(object_teleport (player1) teleport_player1)
		(object_teleport (player2) teleport_player2)
		(object_teleport (player3) teleport_player3)
			(sleep 1)



		; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						(if debug (print "play outro cinematic..."))
						(evaluate cinematic_intro)
						
						; cinematic snap to black 
						(cinematic_snap_to_black)
					)
				)
				(cinematic_skip_stop)
			)
		)
	
	; fade from black 
	(cinematic_fade_to_gameplay)
)



;====================================================================================================================================================================================================
;=============================== LOCKED DOORS ==============================================================================================================================================
;====================================================================================================================================================================================================

(script static void locked_door_markers
	(if debug (print "activate temp locked door beacons..."))

	; locked doors  
	(pda_activate_marker player dm_security_door_locked_01 "locked_doors" TRUE)
	(pda_activate_marker player dm_security_door_locked_02 "locked_doors" TRUE)
	(pda_activate_marker player dm_security_door_locked_03 "locked_doors" TRUE)
	(pda_activate_marker player dm_security_door_locked_04 "locked_doors" TRUE)
	(pda_activate_marker player dm_security_door_locked_05 "locked_doors" TRUE)
	(pda_activate_marker player dm_security_door_locked_06 "locked_doors" TRUE)
	(pda_activate_marker player dm_security_door_locked_07 "locked_doors" TRUE)

	(pda_activate_marker player dm_security_door_locked_08 "locked_doors" TRUE)
	(pda_activate_marker player dm_security_door_locked_09 "locked_doors" TRUE)
	(pda_activate_marker player dm_security_door_locked_10 "locked_doors" TRUE)
	(pda_activate_marker player dm_security_door_locked_11 "locked_doors" TRUE)
	(pda_activate_marker player dm_security_door_locked_12 "locked_doors" TRUE)
	(pda_activate_marker player dm_security_door_locked_13 "locked_doors" TRUE)
	(pda_activate_marker player dm_security_door_locked_14 "locked_doors" TRUE)
)

;====================================================================================================================================================================================================
;=============================== TEST TRANSITION SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================

(script static void test_sc100_complete
	(gp_integer_set gp_current_scene 100)
	(gp_boolean_set gp_l100_complete TRUE)
	(gp_boolean_set gp_sc100_complete TRUE)
)
(script static void test_sc110_complete
	(gp_integer_set gp_current_scene 110)
	(gp_boolean_set gp_l100_complete TRUE)
	(gp_boolean_set gp_sc110_complete TRUE)
)
(script static void test_sc120_complete
	(gp_integer_set gp_current_scene 120)
	(gp_boolean_set gp_l100_complete TRUE)
	(gp_boolean_set gp_sc120_complete TRUE)
)
(script static void test_sc130_complete
	(gp_integer_set gp_current_scene 130)
	(gp_boolean_set gp_l100_complete TRUE)
	(gp_boolean_set gp_sc130_complete TRUE)
)
(script static void test_sc140_complete
	(gp_integer_set gp_current_scene 140)
	(gp_boolean_set gp_l100_complete TRUE)
	(gp_boolean_set gp_sc140_complete TRUE)
)
(script static void test_sc150_complete
	(gp_integer_set gp_current_scene 150)
	(gp_boolean_set gp_l100_complete TRUE)
	(gp_boolean_set gp_sc150_complete TRUE)
)


