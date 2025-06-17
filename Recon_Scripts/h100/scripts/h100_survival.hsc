;====================================================================================================================================================================================================
;=============================== HUB 100 SURVIVAL SCRIPTS ==============================================================================================================================================
;====================================================================================================================================================================================================

(script dormant h100_survival
	; script for survival mode in the hub 
	(if debug (print "H100 Survial Mode Activated..."))
	
		; initialize hub state 
		(initialize_h100)
	
	; wake locked door markers 
	(locked_door_markers)
		
	; fade from black 
	(cinematic_fade_to_gameplay)

	; temp sleep until i get something in here
	(sleep_until (volume_test_players tv_null))
)
