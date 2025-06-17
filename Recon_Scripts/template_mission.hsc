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

(global real g_nav_offset 0.55)

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
;=============================== MISSION SCRIPT ==============================================================================================================================================
;====================================================================================================================================================================================================
;====================================================================================================================================================================================================

(script startup mission_startup
	(if debug (print "mission script") (print "NO DEBUG"))
	;setup allegiance
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
	
		; === PLAYER IN WORLD TEST =====================================================
		(if	(and
				(not editor)
				(> (player_count) 0)
			)
			; if game is allowed to start 
			(start)
			
			(fade_in 0 0 0 0)
			
		)
;This script spawns AIs to take the place of Co-op players (if needed)
	(if (not (game_is_cooperative))
		(begin
			(print "placing Starting AIs")
		)
	)
		
		; === PLAYER IN WORLD TEST =====================================================

			(sleep_until (>= g_insertion_index 1) 1)
			
			(if (= g_insertion_index 1) (wake enc_1))
			(sleep_until	(or
							(volume_test_players enc_2_vol)
							(>= g_insertion_index 2)
						)
			1)
			
			(if (<= g_insertion_index 2) (wake enc_2))	

			(sleep_until	(or
							(volume_test_players enc_3_vol)
							(>= g_insertion_index 3)
						)
			1)
			
			(if (<= g_insertion_index 3) (wake enc_3))

			(sleep_until	(or
							(volume_test_players enc_4_vol)
							(>= g_insertion_index 4)
						)
			1)
			
			(if (<= g_insertion_index 4) (wake enc_4))				

			(sleep_until	(or
							(volume_test_players enc_5_vol)
							(>= g_insertion_index 5)
						)
			1)
			
			(if (<= g_insertion_index 5) (wake enc_5))	

			(sleep_until	(or
							(volume_test_players enc_6_vol)
							(>= g_insertion_index 6)
						)
			1)
			
			(if (<= g_insertion_index 6) (wake enc_6))
			
			(sleep_until	(or
							(volume_test_players enc_7_vol)
							(>= g_insertion_index 7)
						)
			1)
			(if (<= g_insertion_index 7) (wake enc_7))
			
			(sleep_until	(or
							(volume_test_players enc_8_vol)
							(>= g_insertion_index 8)
						)
			1)

			(if (<= g_insertion_index 8) (wake enc_8))
*;							
)

(script static void start
	(print "starting")

	; play cinematic 
		(if (= g_play_cinematics TRUE)
			(begin
				(if (cinematic_skip_start)
					(begin
						;fade to black
						(cinematic_snap_to_black)
						(if debug (print "mission_intro_cinematic"))
; cinematic titles							
							(sleep 60)	
						(cinematic_set_title title_1)
							(sleep 60)
						(cinematic_set_title title_2)
						(sleep (* 30 5))
; call the cinematic here
;						(cinematic_intro)
					)
				)
				(cinematic_skip_stop)
			)
		)
	(sleep 1)
	(cinematic_fade_to_gameplay)
; call the first insertion from the insertion script here
	(ins_level_start)
	
)
	

(script dormant enc_1
	(print "enc_cell01")
		; place allies 	
		; wake global scripts 
		; wake navigation point scripts 		
		; mission dialogue scripts
		; wake vignettes
		; wake ai background threads 
		; wake music scripts 
		; start Objective Control checks
)
(script dormant enc_2
	(print "enc_cell02")
		; place allies 	
		; wake global scripts 
		; wake navigation point scripts 		
		; mission dialogue scripts
		; wake vignettes
		; wake ai background threads 
		; wake music scripts 
		; start Objective Control checks
)
(script dormant enc_3
	(print "enc_cell03")
		; place allies 	
		; wake global scripts 
		; wake navigation point scripts 		
		; mission dialogue scripts
		; wake vignettes
		; wake ai background threads 
		; wake music scripts 
		; start Objective Control checks
)
(script dormant enc_4
	(print "enc_cell04")
		; place allies 	
		; wake global scripts 
		; wake navigation point scripts 		
		; mission dialogue scripts
		; wake vignettes
		; wake ai background threads 
		; wake music scripts 
		; start Objective Control checks
)
(script dormant enc_5
	(print "enc_cell05")
		; place allies 	
		; wake global scripts 
		; wake navigation point scripts 		
		; mission dialogue scripts
		; wake vignettes
		; wake ai background threads 
		; wake music scripts 
		; start Objective Control checks
)
(script dormant enc_6
	(print "enc_cell06")
		; place allies 	
		; wake global scripts 
		; wake navigation point scripts 		
		; mission dialogue scripts
		; wake vignettes
		; wake ai background threads 
		; wake music scripts 
		; start Objective Control checks
)
(script dormant enc_7
	(print "enc_cell07")
		; place allies 	
		; wake global scripts 
		; wake navigation point scripts 		
		; mission dialogue scripts
		; wake vignettes
		; wake ai background threads 
		; wake music scripts 
		; start Objective Control checks
)
(script dormant enc_8
	(print "enc_cell07")
		; place allies 	
		; wake global scripts 
		; wake navigation point scripts 		
		; mission dialogue scripts
		; wake vignettes
		; wake ai background threads 
		; wake music scripts 
		; start Objective Control checks
)