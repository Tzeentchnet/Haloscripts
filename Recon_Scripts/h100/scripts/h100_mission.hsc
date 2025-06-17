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

; starting player pitch 
(global short g_player_start_pitch -16)

(global boolean g_null FALSE)

(global real g_nav_offset 0.55)

;====================================================================================================================================================================================================
;================================== GAME PROGRESSION VARIABLES ================================================================================================================================================
;====================================================================================================================================================================================================
;*
these variables are defined in the .game_progression tag in \globals 


====== INTEGERS ======

g_scene_transition 

- set the scene transition integer equal to the scene number
- when transitioning from sc120 set g_scene_transition = 120 

====== BOOLEANS ======
gp_l100_complete 

gp_h100_complete 

gp_sc100_complete 
gp_sc110_complete 
gp_sc120_complete 
gp_sc130_complete 
gp_sc140_complete 
gp_sc150_complete 
gp_sc160_complete 

gp_l200_complete 

gp_h200_complete 
gp_l300_complete 

*;

;====================================================================================================================================================================================================
;====================================================================================================================================================================================================
;=============================== HUB 100 STARTUP SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================
(script startup h100_startup
	(fade_out 0 0 0 0)
	
	; set allegiances 
	(ai_allegiance covenant player)
	(ai_allegiance player covenant)
	(ai_allegiance human player)
	(ai_allegiance player human)
	(ai_allegiance covenant human)
	(ai_allegiance human covenant)
	
	; turn off the shield indicator 
	(chud_show_shield FALSE)
	
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
		; === PLAYER IN WORLD TEST =====================================================
)

(script static void start
	; condition block to start the proper script 
	(cond
		((= (campaign_survival_enabled) TRUE)			(wake h100_survival))			; in file h100_survival.hsc 
		((= (gp_boolean_get gp_l100_complete) FALSE)		(wake l100_mission))			; in file h100_mission_l100.hsc 
		(TRUE									(wake h100_mission))			; in current file 
	)
	
)

;====================================================================================================================================================================================================
;=============================== HUB 100 MISSION SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================
(script dormant h100_mission
	; script for all things hub  
	(if debug (print "H100 Activated..."))
	
	; snap to black 
	(cinematic_snap_to_black)
	
		; initialize hub state 
		(initialize_h100)
		
		; wake arg threads 
		(wake arg_main)
		
		; wake pda breadcrumbs 
		(wake pda_breadcrumbs)
		
		; wake a bunch of random shit here 
		(wake temp_delete_super)
		(wake temp_auto_close_door)
		
	; temp sleep until i get something in here
	(sleep_until (volume_test_players tv_null))
)

(script dormant temp_delete_super
	(sleep_until (volume_test_players tv_temp_delete_super))
	
	; delete all interior superintendant objects 
	(object_destroy dm_l100_door01_super01)
	(object_destroy dm_l100_door03_super01)
)


(script dormant temp_auto_close_door
	(sleep_until (volume_test_players tv_temp_close_door))
	
	; allow door to close 
	(device_closes_automatically_set dm_security_door_open_07 TRUE)
)
;====================================================================================================================================================================================================
;=============================== GLOBAL SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================


