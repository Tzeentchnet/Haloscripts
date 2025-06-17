; ===================================================================================================================================================
; ===================================================================================================================================================
; MISSION DIALOGUE 
; ===================================================================================================================================================
; ===================================================================================================================================================

;*
+++++++++++++++++++++++
 DIALOGUE INDEX 
+++++++++++++++++++++++

md_010_first_pad
md_010_first_pad_reminder
md_020_cell_1a
md_020_cell_1a_turret
md_020_cell_1a_alt
md_030_cell_1b
md_040_cell_lobby
md_050_cell_2a
md_050_cell_2a_post
md_060_cell_2b
md_050_cell_2b_post
md_070_cell_banshee_platform
md_070_cell_banshee_bridge
md_080_cell_construction_site
+++++++++++++++++++++++
*;

(global ai v_buck NONE)
(global boolean bridge_talk TRUE)

; ===================================================================================================================================================


(script dormant md_010_first_pad
	(sleep 60)
	(if debug (print "mission dialogue:010:first:pad"))

		; cast the actors
		(vs_cast buck TRUE 10 "SC140_0010")
			(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK (radio): Back inside! Let's find that Pelican!"))
		(vs_play_line v_buck TRUE SC140_0010)
		;(sleep (ai_play_line_on_object NONE SC140_0010))				
		(sleep 10)

		(if dialogue (print "ROMEO (helmet): What about all those Covenant we sidestepped on the way up?"))
		(sleep (ai_play_line_on_object NONE SC140_0020))
		(sleep 10)

		(if dialogue (print "BUCK (radio): Now we get kill them."))
		(vs_play_line v_buck TRUE SC140_0030)
		;(sleep (ai_play_line_on_object NONE SC140_0030))						
		(sleep 10)

		(if dialogue (print "ROMEO (helmet): Terrific�"))
		(sleep (ai_play_line_on_object NONE SC140_0040))
		(sleep 10)

	; cleanup
	(vs_release_all)
	
	(wake md_010_first_pad_reminder)
)

; ===================================================================================================================================================

(script dormant md_010_first_pad_reminder
	(sleep 2400) ; reminder delay before it gets executed
	(if debug (print "mission dialogue:010:first:pad:reminder"))

		; cast the actors
		;(vs_cast buck FALSE 10 "SC140_0050")
			;(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK (radio): Do you ever get tired of bitching, Romeo?"))
		(vs_play_line v_buck TRUE SC140_0050)
		;(sleep (ai_play_line_on_object NONE SC140_0050))		
		(sleep 10)

		(if dialogue (print "ROMEO (helmet): You ever get tired of busting my balls?"))
		(sleep (ai_play_line_on_object NONE SC140_0060))
		(sleep 10)

		(if dialogue (print "BUCK (radio): Point taken."))
		(vs_play_line v_buck TRUE SC140_0070)
		;(sleep (ai_play_line_on_object NONE SC140_0070))		
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_020_cell_1a
	(sleep 90)
	(if debug (print "mission dialogue:020:cell:1a"))

		; cast the actors
		;(vs_cast buck TRUE 10 "SC140_0080")
			;(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep_until (volume_test_players cell_1a_md01_vol) 1)

		(if dialogue (print "BUCK (radio): They haven't seen us. Pick a target. Take it out."))
		(vs_play_line v_buck TRUE SC140_0080)
		;(sleep (ai_play_line_on_object NONE SC140_0080))
		
		(sleep 10)
	(sleep_until (> (ai_combat_status cell1a_group) 3) 5)
		(if dialogue (print "BUCK (radio): That did it! Shoot and scoot!"))
		(vs_play_line v_buck TRUE SC140_0090)
		;(sleep (ai_play_line_on_object NONE SC140_0090))
		
		(sleep 10)
	
	; cleanup
	(vs_release_all)

	(wake md_020_cell_1a_turret)
)

; ===================================================================================================================================================

(script dormant md_020_cell_1a_turret
	(sleep 90)

	(if (> (ai_in_vehicle_count 1a_turret01) 0)
		(begin
			(if debug (print "mission dialogue:020:cell:1a:turret"))
		
				; cast the actors
				;(vs_cast buck TRUE 10 "SC140_0100")
					;(set v_buck (vs_role 1))
		
			; movement properties
			(vs_enable_pathfinding_failsafe gr_allies TRUE)
			(vs_enable_looking gr_allies  TRUE)
			(vs_enable_targeting gr_allies TRUE)
			(vs_enable_moving gr_allies TRUE)
		
			(sleep 1)
		
				(if dialogue (print "BUCK (radio): I'll draw that turret's fire! When it turns, kill the operator!"))
				(vs_play_line v_buck TRUE SC140_0100)
				;(sleep (ai_play_line_on_object NONE SC140_0100))
				
				(sleep 10)
		
			; cleanup
			(vs_release_all)
		)
	)
)

; ===================================================================================================================================================

(script dormant md_020_cell_1a_alt ; called from cs_1a_phantom_path_a

	(if debug (print "mission dialogue:020:cell:1a:alt"))

		; cast the actors
		;(vs_cast buck TRUE 10 "SC140_0110")
			;(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK (radio): Romeo! Phantom! Landing on the pad!"))
		(vs_play_line v_buck TRUE SC140_0110)
		;(sleep (ai_play_line_on_object NONE SC140_0110))		
		(sleep 10)

		(if dialogue (print "ROMEO (helmet): I'm on it!"))
		(sleep (ai_play_line_on_object NONE SC140_0120))
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_cell_1b

	(sleep_until (volume_test_players cell_1b_md01_vol) 5)
	(if debug (print "mission dialogue:030:cell:1b"))

		; cast the actors
		(vs_cast buck TRUE 10 "SC140_0130")
			(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK (radio): More turrets up high! Stay low, take 'em out!"))
		(vs_play_line v_buck TRUE SC140_0130)
		;(sleep (ai_play_line_on_object NONE SC140_0130))				
		(sleep 10)
		(sleep 1200)
		(if (and (= (ai_living_count 1b_turret02) 1) 
			(= (ai_living_count 1b_turret03) 1))
			(begin
				(if dialogue (print "BUCK (radio): C'mon, Romeo! We gotta kill those turrets!"))
				(vs_play_line v_buck TRUE SC140_0140)
				;(sleep (ai_play_line_on_object NONE SC140_0140))				
				(sleep 10)
		
				(if dialogue (print "ROMEO (helmet): Give me a sec, would ya?"))
				(sleep (ai_play_line_on_object NONE SC140_0150))
				(sleep 10)
			)
		)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_040_cell_lobby
	(if debug (print "mission dialogue:040:cell:lobby"))

		; cast the actors
		(vs_cast buck TRUE 10 "SC140_0160")
			(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 60)

		(if dialogue (print "BUCK (radio): Dutch! Mickey! What's your location, over?"))
		(vs_play_line v_buck TRUE SC140_0160)
		;(sleep (ai_play_line_on_object NONE SC140_0160))				

		(sleep 10)
		(if dialogue (print "DUTCH (radio, static): Rooftop, northeast of your location! Getting to us won't be easy�"))
		(sleep (ai_play_line_on_object NONE SC140_0170))
		(sleep 10)

		(if dialogue (print "BUCK (radio): We'll get there. You just stay put. "))
		(vs_play_line v_buck TRUE SC140_0180)
		;(sleep (ai_play_line_on_object NONE SC140_0180))				
		
		(sleep 10)
		(sleep_until (volume_test_players lobby_md01_vol))
		(if dialogue (print "BUCK (radio) : Gather weapons and ammo, Romeo. These boys won't need 'em."))
		(vs_play_line v_buck TRUE SC140_0190)
		;(sleep (ai_play_line_on_object NONE SC140_0190))						
		(sleep 10)
		
		(sleep_until (volume_test_players lobby_md01_vol))

		(if dialogue (print "ROMEO (helmet): Must have been a last stand..."))
		(sleep (ai_play_line_on_object NONE SC140_0200))
		(sleep 10)

		(if dialogue (print "BUCK (radio): Looks like it. Stay sharp."))
		(vs_play_line v_buck TRUE SC140_0210)
		;(sleep (ai_play_line_on_object NONE SC140_0210))								
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_050_cell_2a
	(sleep_until (volume_test_players cell_2a_md01_vol)1)
	(if debug (print "mission dialogue:050:cell:2a"))

		; cast the actors
		;(vs_cast buck TRUE 10 "SC140_0220")
			;(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK (radio): Sniper! Twelve o'clock high!"))
		(vs_play_line v_buck TRUE SC140_0220)
		;(sleep (ai_play_line_on_object NONE SC140_0220))										
		(sleep 10)
		(if (< (ai_combat_status cell2a_group) 3)
			(begin

				(if dialogue (print "BUCK (radio): You go loud, you make sure you drop him!"))
				(vs_play_line v_buck TRUE SC140_0230)
				;(sleep (ai_play_line_on_object NONE SC140_0230))												
				(sleep 10)
		
				(if dialogue (print "BUCK (radio): More of 'em! Go to work!"))
				(vs_play_line v_buck TRUE SC140_0240)
				;(sleep (ai_play_line_on_object NONE SC140_0240))												
				(sleep 10)
			)
		)

	(sleep_until 
		(or
			(< (ai_living_count cell2a_jackals) (* v_2a_group_num 0.6))
			(= g_2a_obj_control 1)
		)5)
		(sleep 120)
		(if dialogue (print "BUCK (radio): Jetpack Brutes! We gotta step it up!"))
		(vs_play_line v_buck TRUE SC140_0250)
		;(sleep (ai_play_line_on_object NONE SC140_0250))												
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_050_cell_2a_post

(sleep_until (< (ai_living_count cell2a_group) 1))
	(sleep 1200)
	(if debug (print "mission dialogue:050:cell:2a:post"))

		; cast the actors
		;(vs_cast buck TRUE 10 "SC140_0260")
			;(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BUCK (radio): Keep pressing! Stay mobile!"))
		(vs_play_line v_buck TRUE SC140_0260)
		;(sleep (ai_play_line_on_object NONE SC140_0260))												
		(sleep 10)

		(if dialogue (print "BUCK (radio): Move your ass, Romeo! Let's go!"))
		(vs_play_line v_buck TRUE SC140_0270)
		;(sleep (ai_play_line_on_object NONE SC140_0270))												
		(sleep 10)

	; cleanup`
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_060_cell_2b
	(sleep_until (volume_test_players cell_2a_md02_vol) 5)
	(sleep_forever md_050_cell_2a_post)

	(if debug (print "mission dialogue:060:cell:2b"))

		; cast the actors
		(vs_cast buck TRUE 10 "SC140_0280")
			(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 90)

		(if dialogue (print "BUCK (radio): Hunters! Find some cover and flank 'em!"))
		(vs_play_line v_buck TRUE SC140_0280)
		;(sleep (ai_play_line_on_object NONE SC140_0280))												
		(sleep 600)
		
		(if (> (ai_living_count cell2b_group) 1)
			(begin
		
				(if dialogue (print "BUCK (radio): Come on, Romeo! Little help, for crying out loud!"))
				(vs_play_line v_buck TRUE SC140_0290)
				;(sleep (ai_play_line_on_object NONE SC140_0290))												
				(sleep 10)
		
				(if dialogue (print "ROMEO (helmet): Alright already! I hear ya!"))
				(sleep (ai_play_line_on_object NONE SC140_0300))
				(sleep 10)
			)
		)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_050_cell_2b_post

	(sleep_until (volume_test_players cell_2b_md01_vol)5)
	
	(if debug (print "mission dialogue:050:cell:2b:post"))

		; cast the actors
		;(vs_cast buck TRUE 10 "SC140_0330")
			;(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "DUTCH (radio): Gunny, you read me? We found a way for you to cross to our position!"))
		(sleep (ai_play_line_on_object NONE SC140_0310))		
		(sleep 10)

		(if dialogue (print "MICKEY (radio): But you better hurry, 'cuz we got company!"))
		(sleep (ai_play_line_on_object NONE SC140_0320))
		(sleep 10)

		(if dialogue (print "BUCK (radio): Roger that! Romeo, let's keep up the pace!"))
		(vs_play_line v_buck TRUE SC140_0330)
		;(sleep (ai_play_line_on_object NONE SC140_0330))												
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script command_script cs_buck_run_old
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_go_to marine_banshee_script_run/p0)
	(cs_go_to marine_banshee_script_run/p1)
	(cs_go_to marine_banshee_script_run/p2)
	(cs_go_to marine_banshee_script_run/p3)	
)

(script dormant md_070_cell_banshee_platform
	(sleep_until (volume_test_players cell_2b_md02_vol) 5)
	
	(if debug (print "mission dialogue:070:cell:banshee:platform"))

		; cast the actors
		(vs_cast buck TRUE 10 "SC140_0350")
			(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "ROMEO (helmet): Well that looks safe�"))
		(sleep (ai_play_line_on_object NONE SC140_0340))
		(sleep 10)
		(vs_go_to v_buck true marine_banshee_script_run/p0)
		(if dialogue (print "BUCK (radio): Good. 'Cuz you're going first."))
		(vs_play_line v_buck TRUE SC140_0350)
		;(sleep (ai_play_line_on_object NONE SC140_0350))												
		(sleep 10)
		
		(sleep 300)
		(if dialogue (print "BUCK (radio): It's stable, Romeo! Jump down, hustle to the other side!"))
		(vs_play_line v_buck TRUE SC140_0360)
		;(sleep (ai_play_line_on_object NONE SC140_0360))												
		(sleep 10)
		(sleep 900)

		(if dialogue (print "BUCK (radio): I know you're not scared of heights, trooper! "))
		(vs_play_line v_buck TRUE SC140_0370)
		;(sleep (ai_play_line_on_object NONE SC140_0370))												
		(sleep 10)
		(sleep 900)

		(if dialogue (print "BUCK (radio): Aw for pete's sake! Move! I�ll go first!"))
		(vs_play_line v_buck TRUE SC140_0380)
		;(sleep (ai_play_line_on_object NONE SC140_0380))												
		(sleep 10)
		(vs_go_to v_buck true marine_banshee_script_run/p1)
		(ai_set_objective buck marine_banshee_obj)

	; cleanup
	(vs_release_all)
		
)

(script dormant md_070_cell_banshee_plat_end
	(sleep_until (volume_test_players construction_md01_vol)5)
	(sleep_forever md_070_cell_banshee_platform)
	(ai_set_objective buck marine_banshee_obj)
)
(script dormant md_070_cell_banshee_bridge

	; called at banshee_flyby
	(if debug (print "mission dialogue:070:cell:banshee:bridge"))

		; cast the actors
		;(vs_cast buck TRUE 10 "SC140_0410")
			;(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

		(if dialogue (print "ROMEO (radio): To our left! Banshees fast and low!"))
		(sleep (ai_play_line_on_object NONE SC140_0390))
		(sleep 10)

		(if dialogue (print "ROMEO (helmet): That was too damn close!"))
		(sleep (ai_play_line_on_object NONE SC140_0400))
		(sleep 10)

		(if dialogue (print "BUCK (radio): Agreed! Go, go, go!"))
		(vs_play_line v_buck TRUE SC140_0410)
		;(sleep (ai_play_line_on_object NONE SC140_0410))												
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_080_cell_construction_site
	(sleep_until (volume_test_players construction_md02_vol) 5)
	(if debug (print "mission dialogue:080:cell:construction:site"))

		; cast the actors
		;(vs_cast buck TRUE 10 "SC140_0420")
			;(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)
	
		(if dialogue (print "BUCK (radio): What's your status?"))
		(vs_play_line v_buck TRUE SC140_0420)
		;(sleep (ai_play_line_on_object NONE SC140_0420))												
		(sleep 10)

		(if dialogue (print "DUTCH (radio): Bird's wasted. Lost our pilot on impact. Rest of us are fine."))
		(sleep (ai_play_line_on_object NONE SC140_0430))
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Not for long�we got inbound Phantoms!"))
		(sleep (ai_play_line_on_object NONE SC140_0440))
		(sleep 10)
		(if dialogue (print "BUCK (radio): Romeo! Pick a turret! Things are about to get hot!"))
		(vs_play_line v_buck TRUE SC140_0450)
		;(sleep (ai_play_line_on_object NONE SC140_0450))												
		(sleep 10)

		(if dialogue (print "ROMEO (helmet): Why am I not surprised�"))
		(sleep (ai_play_line_on_object NONE SC140_0460))
		(sleep 10)
	; cleanup
	(vs_release_all)
	(game_save)
)
(script dormant md_080_cell_const_snipers
	(if debug (print "mission 
	dialogue:080:cell:const:snipers"))

		; cast the actors
		;(vs_cast buck TRUE 10 "SC140_0470")
			;(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)
		(if dialogue (print "DUTCH (radio): Watch for snipers in those towers!"))
		(sleep (ai_play_line_on_object NONE SC140_0470))
		(sleep 600)
		; (if (> (ai_living_count jackals) 1)
		;	(begin))
		(if dialogue (print "DUTCH (radio): Still taking sniper-fire! Romeo, you see 'em?"))
		(sleep (ai_play_line_on_object NONE SC140_0500))
		(sleep 10)

	; cleanup
	(vs_release_all)
		
)

(script dormant md_080_cell_const_reinf
	(if debug (print "mission 
	dialogue:080:cell:const:reinf"))

		; cast the actors
		;(vs_cast buck TRUE 10 "SC140_0480")
			;(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)
		(if dialogue (print "BUCK (radio): Hostiles on the lower level! Romeo, clear 'em out!"))
		(vs_play_line v_buck TRUE SC140_0480)
		;(sleep (ai_play_line_on_object NONE SC140_0480))												
		(sleep 150)

		(if dialogue (print "MICKEY (radio): That Phantom's gonna tear us to pieces!"))
		(sleep (ai_play_line_on_object NONE SC140_0520))
		(sleep 10)
		

	; cleanup
	(vs_release_all)
		
)

(script dormant md_080_cell_const_chief
	(if debug (print "mission 
	dialogue:080:cell:const:chief"))

		; cast the actors
		;(vs_cast buck TRUE 10 "SC140_0490")
			;(set v_buck (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies  TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)
		(if dialogue (print "MICKEY (radio): Another Phantom coming in! Aw hell! It's a Chieftain!"))
		(sleep (ai_play_line_on_object NONE SC140_0490))
		(sleep 300)

		(if dialogue (print "BUCK (radio): Focus your fire on those jetpack Brutes!"))
		(vs_play_line v_buck TRUE SC140_0510)
		;(sleep (ai_play_line_on_object NONE SC140_0510))												
		(sleep 300)
		(if dialogue (print "BUCK (radio): Pour it on! We're almost through this!"))
		(vs_play_line v_buck TRUE SC140_0530)
		;(sleep (ai_play_line_on_object NONE SC140_0530))												
		(sleep 10)		
	; cleanup
	(vs_release_all)		
)

; ===================================================================================================================================================





; temp script for 7/7 presentation

(script dormant sc140_presentation_cinematic

	(print "7/7 presentation cinematic")
	(cinematic_snap_to_black)
	(zone_set_trigger_volume_enable begin_zone_set:sc140_010_020_030 false)
	(zone_set_trigger_volume_enable zone_set:sc140_010_020_030 false)	
;	(zone_set_trigger_volume_enable begin_zone_set:sc140_all false)
;	(zone_set_trigger_volume_enable zone_set:sc140_all false)
	(sleep 5)
	(player_enable_input TRUE)
	(player_action_test_reset)
	(sleep_until (player_action_test_accept) 1)

	(sound_looping_start sound\music\cpaul\rooftops_intro_temp\rooftops_intro_temp NONE 1)
	(sleep 60)
	(cinematic_set_title title_1)
	(sleep 60)
	(cinematic_set_title title_2)
	(sleep 90)
	
;	(object_destroy_containing sand_cube)

		(camera_set_field_of_view 80 0)
		(camera_set cam_1 0)
		(camera_set cam_2 200)
		(sleep 30)
		(fade_in 0 0 0 45)
		(sleep 70)
		(camera_set cam_3 300)
		(sleep 150)
		(camera_set cam_4 300)
		(sleep 150)
		(camera_set cam_5 300)
		(sleep 150)
		(camera_set cam_6 300)
		(sleep 150)
		(camera_set cam_7 300)
		(sleep 150)
		(camera_set cam_8 300)
		(sleep 150)
		(camera_set cam_9 200)
		(sleep 100)
		(camera_set cam_10 200)
		(sleep 100)
		(camera_set cam_11 200)
		(sleep 100)
		(camera_set cam_12 200)
		(sleep 200)
	
	(cinematic_fade_to_gameplay)
	
;	(object_create_containing sand_cube)
;	(sound_looping_stop sound\music\cpaul\rooftops_intro_temp\rooftops_intro_temp)
;	(set g_presentation 1)
)

(script dormant ambient_air_cell1
	(sleep_until
		(begin
		(set random_point_a (random_range 0 2))
			(if (= random_point_a 0)
				(begin
					(ai_place ambient_phantom01/pilot)
					(ambient_track_a ambient_phantom01/pilot)
					(sleep_until (not (cs_command_script_running ambient_phantom01/pilot 
					cs_ambient_path_a))5)
					(ai_erase ambient_phantom01)
				)
				(begin
					(ai_place ambient_phantom01/pilot)
					(ambient_track_b ambient_phantom01/pilot)
					
					(sleep_until (not (cs_command_script_running ambient_phantom01/pilot 
					cs_ambient_path_b))5)
					(ai_erase ambient_phantom01)
				)
			)
		(random_range 150 450))
	)
)
(script static void (ambient_track_a (ai vehicle_starting_location))
	(set v_ambient_air01 (ai_vehicle_get_from_starting_location vehicle_starting_location))

	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(object_teleport_to_ai_point v_ambient_air01 background_air_a/p0a))
		((= random_point_a 1) 
		(object_teleport_to_ai_point v_ambient_air01 background_air_a/p0b))
		((= random_point_a 2) 
		(object_teleport_to_ai_point v_ambient_air01 background_air_a/p0c))
	)
	(cs_run_command_script vehicle_starting_location cs_ambient_path_a)
)
(script static void (ambient_track_b (ai vehicle_starting_location))
	(set v_ambient_air02 (ai_vehicle_get_from_starting_location vehicle_starting_location))

	(set random_point_a (random_range 0 3))
	(cond
		((= random_point_a 0)
		(object_teleport_to_ai_point v_ambient_air02 background_air_a/p3a))
		((= random_point_a 1) 
		(object_teleport_to_ai_point v_ambient_air02 background_air_a/p3b))
		((= random_point_a 2) 
		(object_teleport_to_ai_point v_ambient_air02 background_air_a/p3c))
	)
	(cs_run_command_script vehicle_starting_location cs_ambient_path_b)
)
(script command_script cs_ambient_path_a
	(cs_enable_pathfinding_failsafe TRUE)
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.5)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.7)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 1.0)	
		)		
	)
	; path change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_a/p1a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_a/p1b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_a/p1c 4)
		)		
	)
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.4)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.6)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 0.8)	
		)		
	)
	; path change	
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_a/p2a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_a/p2b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_a/p2c 4)
		)		
	)	
	(cs_vehicle_speed 1.0)	
	(cs_vehicle_boost TRUE)
	(cs_fly_to background_air_a/p3a 10)	
	
)

(script command_script cs_ambient_path_b
	(cs_enable_pathfinding_failsafe TRUE)
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.5)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.7)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 1.0)	
		)		
	)
	; path change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_a/p2a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_a/p2b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_a/p2c 4)
		)		
	)
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.4)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.6)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 0.8)	
		)		
	)
	; path change	
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_a/p1a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_a/p1b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_a/p1c 4)
		)		
	)	
	; speed change
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_vehicle_speed 0.4)	
		)
		((= random_point_a 1)
		(cs_vehicle_speed 0.6)	
		)
		((= random_point_a 2)
		(cs_vehicle_speed 0.8)	
		)		
	)	
	; path change	
	(set random_point_a (random_range 0 3))
	(cond 
		((= random_point_a 0)
		(cs_fly_by background_air_a/p0a 4)
		)
		((= random_point_a 1)
		(cs_fly_by background_air_a/p0b 4)
		)
		((= random_point_a 2)
		(cs_fly_by background_air_a/p0c 4)
		)		
	)	
	
)