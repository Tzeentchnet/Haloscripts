; ===================================================================================================================================================
; ===================================================================================================================================================
; MISSION DIALOGUE 
; ===================================================================================================================================================
; ===================================================================================================================================================

;*
+++++++++++++++++++++++
 DIALOGUE INDEX 
+++++++++++++++++++++++

md_010_initial
md_010_marine_dialog
md_020_grunt_sleep
md_020_brute
md_020_turret
md_020_post
md_030_mid_jackal
md_030_door
md_040_init
md_040_dare_location
md_040_dare_hunter
md_050_pod_reminder
+++++++++++++++++++++++
*;

(global ai brute NONE)
(global ai fem NONE)
(global ai marine NONE)

; ===================================================================================================================================================


(script dormant md_010_initial
	(if debug (print "mission dialogue:010:initial"))

	(sleep 1)

		(if dialogue (print "DARE (radio): Buck, can you see my beacon?"))
		(sleep (ai_play_line_on_object NONE SC100_0010))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): It's in my visor if I need it."))
		(sleep (ai_play_line_on_object NONE SC100_0020))
		(sleep 10)

		(if dialogue (print "DARE (radio): We missed our LZ. This grid's packed with Covenant. Be careful."))
		(sleep (ai_play_line_on_object NONE SC100_0030))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): I appreciate the concern."))
		(sleep (ai_play_line_on_object NONE SC100_0040))
		(sleep 10)

		(if dialogue (print "DARE (radio): Won't be much a rescue if you're dead."))
		(sleep (ai_play_line_on_object NONE SC100_0050))
		(sleep 10)
	(wake md_010_marine_dialog)

)

; ===================================================================================================================================================

(script dormant md_010_marine_dialog
	(sleep_until (< (ai_living_count Training01_Group) 1) 5)
	(if debug (print "mission dialogue:010:marine:call"))	
	(sleep_until (< (objects_distance_to_object (players) (ai_get_object marine)) 20))	
	(print "distance acquired")
		; cast the actors
		(vs_cast Training01_Marines01 TRUE 10 "SC100_0060")
			(set marine (vs_role 1))
	(print "CAST COMPLETE")
	; movement properties
	(vs_enable_pathfinding_failsafe marine TRUE)
	(vs_enable_looking marine TRUE)


	(sleep 1)

	(vs_face_player marine TRUE)
		(if dialogue (print "MARINE: Trooper! Over here!"))
		(vs_play_line marine TRUE SC100_0060)
		(sleep 10)
	(vs_face_player marine FALSE)
	(vs_approach_player marine TRUE 3 7 10)
		
	(sleep 1)
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object marine)) 2.5)5)
	(vs_face_player marine TRUE)
		
		(if dialogue (print "MARINE: Saw your pod hit. You're one lucky SOB."))
		(vs_play_line marine TRUE SC100_0070)
		(sleep 10)
	(vs_approach_stop marine)
	(vs_face_player marine FALSE)
	(vs_enable_targeting marine FALSE)
	(vs_enable_moving marine FALSE)		
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object marine)) 2.5)5)
	(vs_face_player marine TRUE)

		(if dialogue (print "BUCK 01 (helmet): Seen any more come down?"))
		(sleep (ai_play_line_on_object NONE SC100_0080))
		(sleep 10)
	(vs_face_player marine FALSE)
		
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object marine)) 2.5)5)
	(vs_face_player marine TRUE)

		(if dialogue (print "MARINE: Negative. But I didn't see much of anything after that flash."))
		(vs_play_line marine TRUE SC100_0090)
		(sleep 10)
	(vs_face_player marine FALSE)
		
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object marine)) 2.5)5)
	(vs_face_player marine TRUE)

		(if dialogue (print "BUCK 02 (helmet): I gotta head out. You be alright?"))
		(sleep (ai_play_line_on_object NONE SC100_0100))
		(sleep 10)
	(vs_face_player marine FALSE)
		
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object marine)) 2.5)5)
	(vs_face_player marine TRUE)

		(if dialogue (print "MARINE: Yeah."))
		(vs_play_line marine TRUE SC100_0110)
		(sleep 10)
	(vs_face_player marine FALSE)

	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object marine)) 2.5)5)
	(vs_face_player marine TRUE)
		
		(if dialogue (print "MARINE: But listen. Some of these buildings are open."))
		(vs_play_line marine TRUE SC100_0120)
		(sleep 10)
	(vs_face_player marine FALSE)
		
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object marine)) 2.5)5)
	(vs_face_player marine TRUE)

		(if dialogue (print "MARINE: Should be able to get inside, flank the Covenant on the streets."))
		(vs_play_line marine TRUE SC100_0130)
		(sleep 10)
	(vs_face_player marine FALSE)
		
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object marine)) 2.5)5)
	(vs_face_player marine TRUE)

		(if dialogue (print "BUCK (helmet): Roger that. Thanks."))
		(sleep (ai_play_line_on_object NONE SC100_0140))
		(sleep 10)
	(vs_face_player marine FALSE)

	(sleep 1)
	(sleep 600)
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object marine)) 2.5)5)
	(vs_face_player marine TRUE)

		(if dialogue (print "MARINE: Go on! We'll be alright!"))
		(vs_play_line marine TRUE SC100_0150)
		(sleep 10)
	(vs_face_player marine FALSE)
		
	(sleep 900)
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object marine)) 2.5)5)
	(vs_face_player marine TRUE)
		
		(if dialogue (print "MARINE: Don't worry about us, Gunny! Get moving!"))
		(vs_play_line marine TRUE SC100_0160)
		(sleep 10)
	(vs_face_player marine FALSE)
	(vs_enable_targeting marine TRUE)
	(vs_enable_moving marine TRUE)
	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_020_grunt_sleep
	(sleep_until (volume_test_players training02_md01_vol) 5)
	(if debug (print "mission dialogue:020:grunt:sleep"))
	
	(sleep 1)
	(if (= (ai_combat_status Training02_Squad06) 0)
		(begin
			(if dialogue (print "BUCK (helmet): Naptime, huh? Let Daddy pat you on the back�"))
			(sleep (ai_play_line_on_object NONE SC100_0170))
			(sleep 10)
		)
	)
)

; ===================================================================================================================================================

(script dormant md_020_brute
	(sleep_until (volume_test_players training02_md02_vol) 5)
	(if debug (print "mission dialogue:020:brute"))

		; cast the actors
		(vs_cast Training02_Squad01/actor TRUE 10 "SC100_0180")
			(set brute (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe brute TRUE)
	(vs_enable_looking brute TRUE)
	(vs_enable_targeting brute TRUE)
	(vs_enable_moving brute TRUE)

	(sleep 1)

		(if dialogue (print "BRUTE: Faster, you whelps! Secure that building!"))
		(vs_play_line brute TRUE SC100_0180)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_020_turret
	(sleep_until (volume_test_players training02_md03_vol) 5)
	(if debug (print "mission dialogue:020:turret"))
	(sleep 200)
	(if (= (ai_living_count Training02_Squad04) 1)
		(begin
			(sleep 1)
			(if dialogue (print "BUCK (helmet): Damn turret! One grenade outta do it�"))
			(sleep (ai_play_line_on_object NONE SC100_0190))
			(sleep 10)
		)
	)
)

; ===================================================================================================================================================

(script dormant md_020_post
	(sleep_until (or (= (ai_living_count Training02_Group)0)
	(volume_test_players training02_md04_vol))5)
	(sleep_until (game_safe_to_save))
	(if debug (print "mission dialogue:020:post"))

	(sleep 1)		
		(if dialogue (print "BUCK (helmet): What's with all the Brutes?"))
		(sleep (ai_play_line_on_object NONE SC100_0200))
		(sleep 10)

		(if dialogue (print "DARE (radio): What do you mean?"))
		(sleep (ai_play_line_on_object NONE SC100_0210))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): I heard Mombasa was full of Elites. What happened?"))
		(sleep (ai_play_line_on_object NONE SC100_0220))
		(sleep 10)

		(if dialogue (print "DARE (radio): It's...classified."))
		(sleep (ai_play_line_on_object NONE SC100_0230))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): Some things never change�"))
		(sleep (ai_play_line_on_object NONE SC100_0240))
		(sleep 10)

)

; ===================================================================================================================================================

(script dormant md_030_mid_jackal
	; checking to make sure jackal shields are still alive and if the 
	; player is in the trigger volume for this dialog
	(sleep_until (and 
					(or 
						(> (ai_living_count Training03_Squad02) 0)
						(> (ai_living_count Training03_Squad03) 0)
						(> (ai_living_count Training03_Squad04) 0)
					)
					(volume_test_players training03_md01_vol)
				)
	5)
	(if debug (print "mission dialogue:030:mid:jackal"))

	(sleep 1)

		(if dialogue (print "BUCK (helmet): Got a little Jackal problem!"))
		(sleep (ai_play_line_on_object NONE SC100_0250))
		(sleep 10)

		(if dialogue (print "DARE (radio): An overcharged plasma-pistol shot will neutralize their shields."))
		(sleep (ai_play_line_on_object NONE SC100_0260))
		(sleep 10)

		(if dialogue (print "DARE (radio): Should also take-down a Brute's armor."))
		(sleep (ai_play_line_on_object NONE SC100_0270))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): Oh yeah? Where were you a minute ago?"))
		(sleep (ai_play_line_on_object NONE SC100_0280))
		(sleep 10)

		(if dialogue (print "DARE (radio): Still trapped inside my pod."))
		(sleep (ai_play_line_on_object NONE SC100_0290))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): I hear you�"))
		(sleep (ai_play_line_on_object NONE SC100_0300))
		(sleep 10)

)

; ===================================================================================================================================================

(script dormant md_030_door
	(sleep_until (< (ai_living_count Training03_Group) 1) 5)
	(sleep 600)
	(sleep_until (volume_test_players training03_md02_vol) 5)
	
	(if (= (device_get_position hub_door_080_01 ) 0)
		(begin
			(if debug (print "mission dialogue:030:door"))
		
			(sleep 1)
		
				(if dialogue (print "BUCK (helmet): Gotta get through this door�"))
				(sleep (ai_play_line_on_object NONE SC100_0310))
				(sleep 10)
		
				(if dialogue (print "BUCK (helmet): Should be a switch around here somewhere�"))
				(sleep (ai_play_line_on_object NONE SC100_0320))
				(sleep 10)
		)
	)

)

; ===================================================================================================================================================

(script dormant md_040_init

	(if debug (print "mission dialogue:040:init"))

		; cast the actors
		(vs_cast Training04_Marines02 TRUE 10 "SC100_0330")
			(set fem (vs_role 1))

	(sleep 1)
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object fem)) 2.5)5)
		(if dialogue (print "FEM: Gunny! Where'd you come from?"))
		(vs_play_line fem TRUE SC100_0330)
		(sleep 5)
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object fem)) 2.5)5)
		(if dialogue (print "BUCK: Orbit. (pause) What's the plan Staff Sergeant?"))
		(sleep (ai_play_line_on_object NONE SC100_0340))
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object fem)) 2.5)5)		
		(sleep 5)

		(if dialogue (print "FEM: Need someone to cut through this building, hit 'em from behind."))
		(vs_play_line fem TRUE SC100_0350)
		(sleep 5)
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object fem)) 2.5)5)
		(if dialogue (print "BUCK: I'm on it. That's the way I'm headed anyways."))
		(sleep (ai_play_line_on_object NONE SC100_0360))		
		(sleep 5)
	(sleep_until (< (objects_distance_to_object (players) 
	(ai_get_object fem)) 2.5)5)
		(if dialogue (print "FEM: Good luck! We'll keep you covered!"))
		(vs_play_line fem TRUE SC100_0370)
		(sleep 5)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_040_dare_location
	(sleep_until (or (volume_test_players training04_md01_vol)
				(volume_test_players training04_md02_vol)))
	(sleep 600)
	(if debug (print "mission dialogue:040:dare:location"))	
	(sleep_until (script_finished md_040_init)30 120)
	(sleep_forever md_040_init)

	(sleep_until (or (volume_test_players training04_md01_vol)
				(volume_test_players training04_md02_vol)))
		(if dialogue (print "DARE (radio): Buck. Location."))
		(sleep (ai_play_line_on_object NONE SC100_0380))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): Almost there. What's wrong?"))
		(sleep (ai_play_line_on_object NONE SC100_0390))
		(sleep 10)

		(if dialogue (print "DARE (radio): Multiple hostiles. Closing on my position."))
		(sleep (ai_play_line_on_object NONE SC100_0400))
		(sleep 10)

		(if dialogue (print "DARE (radio): Listen carefully. If I don�t make it --"))
		(sleep (ai_play_line_on_object NONE SC100_0410))
		(sleep 10)

		(if dialogue (print "BUCK: Whoa! Hang on! I'll be right there --"))
		(sleep (ai_play_line_on_object NONE SC100_0420))		
		
		(sleep 10)
	(sleep_until (or (volume_test_players training04_md01_vol)
				(volume_test_players training04_md02_vol)))
		(if dialogue (print "DARE (radio): Too late! They spotted me!"))
		(sleep (ai_play_line_on_object NONE SC100_0430))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): Dammit! No!"))
		(sleep (ai_play_line_on_object NONE SC100_0440))
		(sleep 10)

		(if dialogue (print "BUCK (helmet): Veronica! (pause) Talk to me!"))
		(sleep (ai_play_line_on_object NONE SC100_0450))
		(sleep 10)
	(sleep_until (or (volume_test_players training04_md01_vol)
				(volume_test_players training04_md02_vol)))
		(if dialogue (print "BUCK (helmet): Don't move! I'm coming, you hear?"))
		(sleep (ai_play_line_on_object NONE SC100_0460))
		(sleep 10)

)

; ===================================================================================================================================================

(script dormant md_040_dare_hunter
	; holy crap conditional to see if hunters are in view but not 
	; while in the player is in buildings!
	(sleep_until (and
		(or 		
(objects_can_see_object (player0) (ai_get_object 
Training04_Squad13) 15) 
(objects_can_see_object (player0) (ai_get_object 
Training04_Squad14) 15)
		)
		(not (volume_test_objects training04_md01_vol (player0)))
		(not (volume_test_objects training04_md02_vol (player0)))
		(not (volume_test_objects training04_md03_vol (player0)))
		
		)
		5)
		
	(if debug (print "mission dialogue:040:dare:hunter"))
	(sleep 1)

		(if dialogue (print "BUCK (helmet) : Hunters?! Oh no, I do NOT have time for this!"))
		(sleep (ai_play_line_on_object NONE SC100_0470))		
		
		(sleep 10)

		(if dialogue (print "BUCK (helmet) : Turn around you bastards! Let me shoot you in the back!"))
		(sleep (ai_play_line_on_object NONE SC100_0480))				
		(sleep 10)

)

; ===================================================================================================================================================

(script dormant md_050_pod_reminder
	(sleep_until (and (volume_test_players 
	training05_md01_vol)(objects_can_see_object (player0) dare_pod 
	15))5)
	(if debug (print "mission dialogue:050:pod:reminder"))
	(sleep 1)

		(if dialogue (print "BUCK: There's her pod. Need to find a way down�"))
		(sleep (ai_play_line_on_object NONE SC100_0490))						
		(sleep 10)
	(sleep_until (volume_test_players training05_md02_vol) 5)
		(if dialogue (print "BUCK: Looks clear, Buck. Go!"))
		(sleep (ai_play_line_on_object NONE SC100_0500))								
		(sleep 10)

)

; ===================================================================================================================================================
