(script startup sc130_ambient_stub
	(if debug (print "sc130 ambient stub"))
)

; ===================================================================================================================================================
; ===================================================================================================================================================
; MISSION DIALOGUE 
; ===================================================================================================================================================
; ===================================================================================================================================================

;*
+++++++++++++++++++++++
 DIALOGUE INDEX 
+++++++++++++++++++++++

md_010_charge_01
md_010_charge_02
md_010_charge_reminder_01
md_010_charge_reminder_02
md_010_final_charge
md_010_bridge_retreat
md_020_watchtower
md_020_defend_bridge
md_030_wait
md_030_civ_detonator
md_030_mickey_detonator
md_030_bridge_blown
md_030_bridge_tunnel
md_030_bridge_exit
md_040_main_arena_start
md_040_hunter
md_040_fall_back
md_040_brute_advance_01
md_040_brute_advance_02
md_050_phantom
md_050_ridge_retreat_01
md_050_ridge_retreat_02
md_050_security_doors
md_060_lobby_conversation
md_060_turret_right_sarge
md_060_turret_left_sarge
md_060_rear_attack_sarge
md_060_turret_right_mickey
md_060_turret_left_mickey
md_060_rear_attack_mickey
md_060_lobby_combat_end
md_060_elev_arrives_sarge
md_060_elev_arrives_mickey
md_060_elev_entry_reminder
md_070_elev_ride
md_080_exit
md_080_exit_reminder
+++++++++++++++++++++++
*;

(global ai brute NONE)
(global ai civilian NONE)
(global ai fem_marine NONE)
(global ai marine_01 NONE)
(global ai marine_02 NONE)
(global ai marine_03 NONE)
(global ai mickey NONE)
(global ai sergeant NONE)

(global boolean b_rear_attack TRUE)

; ===================================================================================================================================================


(script dormant md_010_charge_01
	;(if debug (print "mission dialogue:010:charge:01"))

		; cast the actors
		(set mickey sq_bridge_ODST)
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0010")
		;	(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Follow me! Let�s arm the other charges!"))
		(vs_play_line mickey TRUE SC130_0010)
		(sleep 10)

	(wake md_010_bridge_retreat)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_010_charge_02

	(sleep_until (volume_test_players tv_bridge_00) 1)	

	;(if debug (print "mission dialogue:010:charge:02"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0020")
		;	(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Forget those Wraiths, Dutch! We got explosives to set!"))
		(vs_play_line mickey TRUE SC130_0020)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_010_charge_reminder_01

	(sleep_until (= g_charge_reminder 1) 1)

	;(if debug (print "mission dialogue:010:charge:reminder:01"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 9 "SC130_0030")
		;(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): I got this one. You do the rest!"))
		(vs_play_line mickey TRUE SC130_0030)

	; cleanup
	(vs_release_all)
	
)

; ===================================================================================================================================================

(script dormant md_010_charge_reminder_02
	
	(sleep_until (= g_charge_reminder 2) 1)	
	
	;(if debug (print "mission dialogue:010:charge:reminder:02"))
	
		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 9 "SC130_0040")
		;	(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey  TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Great. I gotta do everything myself�"))
		(vs_play_line mickey TRUE SC130_0040)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================
(global boolean b_bridge_detonation_enable FALSE)

(script dormant md_010_final_charge

(sleep_until 
	(and
		(= (device_group_get dg_charge_01) 1) 
		(= (device_group_get dg_charge_02) 1)
		(= (device_group_get dg_charge_03) 1)
	)
1)

;	shuts down other prompts
	(sleep_forever md_010_charge_reminder_01)
	(sleep_forever md_010_charge_reminder_02)

	;(if debug (print "mission dialogue:010:final:charge"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0050")
		;	(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey FALSE)
	(vs_enable_targeting mickey FALSE)
	(vs_enable_moving mickey FALSE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): That�s the last one, Dutch! Let's get off the bridge!"))
		(vs_play_line mickey TRUE SC130_0050)
		(sleep 20)
		
		(if dialogue (print "MICKEY (radio): Everyone behind those barriers! The bridge is set to blow!"))
		(vs_play_line mickey TRUE SC130_0090)
		
			(vs_go_to_and_face mickey TRUE ps_bridge_ODST/stand_01 ps_bridge_ODST/face_01)
			
			(set b_bridge_detonation_enable TRUE)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_010_bridge_retreat
	;(if debug (print "mission dialogue:010:bridge:retreat"))

		; cast the actors
		(vs_cast gr_bridge_allies TRUE 10 "SC130_0060")
			(set marine_03 (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe marine_03 TRUE)
	(vs_enable_looking marine_03 TRUE)
	(vs_enable_targeting marine_03 TRUE)
	(vs_enable_moving marine_03 TRUE)

	(sleep 1)

		(if dialogue (print "MARINE_03: We'll never stop that armor! Fall back!"))
		(vs_play_line marine_03 TRUE SC130_0060)
		(sleep 30)

		(if dialogue (print "MARINE_03: Clear the bridge! Retreat to the wall!"))
		(vs_play_line marine_03 TRUE SC130_0070)

		;(if dialogue (print "MARINE_03: Back! Fall back! It's hopeless out here!"))
		;(vs_play_line marine_03 TRUE SC130_0080)
		;(sleep 10)

	; cleanup
	(vs_release_all)
	
)

; ===================================================================================================================================================

(script dormant md_020_watchtower
	;(if debug (print "mission dialogue:020:watchtower"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0090")
		;	(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Watchtower, Dutch! Get up there, and pull the trigger!"))
		(vs_play_line mickey TRUE SC130_0100)

	(sleep (* 30 4))
	
	(wake md_020_defend_bridge)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_020_defend_bridge
	;(if debug (print "mission dialogue:020:defend:bridge"))

		; cast the actors
		(vs_cast gr_bridge_allies TRUE 9 "SC130_0110")
			(set marine_03 (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe marine_03 TRUE)
	(vs_enable_looking marine_03 TRUE)
	(vs_enable_targeting marine_03 TRUE)
	(vs_enable_moving marine_03 TRUE)

	(sleep 1)

		(if dialogue (print "MARINE_03: Kill their infantry! Don't let 'em cross the bridge!"))
		(vs_play_line marine_03 TRUE SC130_0110)
		(sleep 30)

		(if dialogue (print "MARINE_03: Watch those Wraiths! They've got us dialed-in!"))
		(vs_play_line marine_03 TRUE SC130_0120)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_wait

	(sleep_until (volume_test_players tv_tower_dialogue) 1)

	;(if debug (print "mission dialogue:030:wait"))

		; cast the actors
		(vs_cast sq_bridge_civ_01/civilian TRUE 10 "SC130_0130")
			(set civilian (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe civilian TRUE)
	(vs_enable_looking civilian TRUE)
	(vs_enable_targeting civilian TRUE)
	(vs_enable_moving civilian TRUE)

	(sleep 1)

		(if dialogue (print "CIVILIAN: Hang on while I check the connection�"))
		(vs_play_line civilian TRUE SC130_0130)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_civ_detonator
	;(if debug (print "mission dialogue:030:civ:detonator"))

		; cast the actors
		(vs_cast sq_bridge_civ_01/civilian TRUE 10 "SC130_0140")
			(set civilian (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe civilian TRUE)
	(vs_enable_looking civilian TRUE)
	(vs_enable_targeting civilian TRUE)
	(vs_enable_moving civilian TRUE)

	(sleep 1)

		(if dialogue (print "CIVILIAN: OK, terminal's all synced-up! Blow the charges!"))
		(vs_play_line civilian TRUE SC130_0140)
			
			(sleep (* 30 10))
		
	(if (= (device_group_get dg_laptop_01) 0)
				
		(begin
			(if dialogue (print "CIVILIAN: Hurry! Before they bring those Wraiths across!"))
			(vs_play_line civilian TRUE SC130_0150)
		)
	)	
			(sleep (* 30 60))
			
	(if (= (device_group_get dg_laptop_01) 0)		

		(begin	
			(if dialogue (print "CIVILIAN: What are you waiting for? Use this terminal to destroy the bridge!"))
			(vs_play_line civilian TRUE SC130_0160)
		)
	)		
			(sleep (* 30 10))
			
	(if (= (device_group_get dg_laptop_01) 0)
	
		(begin		
			(if dialogue (print "CIVILIAN: Out of my way! We need to blow the bridge now!"))
			(vs_play_line civilian TRUE SC130_0170)
		)
	)		
	
	(if (= (device_group_get dg_laptop_01) 0)
	;command script to blow bridge
		(cs_run_command_script sq_bridge_civ_01 sq_bridge_civ_01_laptop_01)
	)

	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_030_mickey_detonator
	(if debug (print "mission dialogue:030:mickey:detonator"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0180")
			(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Hurry up, Dutch! Kill that bridge!"))
		(vs_play_line mickey TRUE SC130_0180)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): We�re out of time! I'll do it myself! Establishing remote connection�"))
		(vs_play_line mickey TRUE SC130_0190)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

*;
; ===================================================================================================================================================

(script dormant md_030_bridge_blown
	;(if debug (print "mission dialogue:030:bridge:blown"))

	;fire off final bridge script	
	(wake bridge_cleanup)

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0200")
		;	(set mickey (vs_role 1))

		(vs_cast gr_bridge_allies FALSE 10 "SC130_0210")
			(set marine_01 (vs_role 2))
			
		(vs_cast gr_bridge_allies FALSE 10 "SC130_0220")
			(set marine_02 (vs_role 3))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_bridge_allies TRUE)
	(vs_enable_looking gr_bridge_allies TRUE)
	(vs_enable_targeting gr_bridge_allies TRUE)
	(vs_enable_moving gr_bridge_allies TRUE)
	
	(vs_enable_pathfinding_failsafe gr_ODST TRUE)
	(vs_enable_looking gr_ODST TRUE)
	(vs_enable_targeting gr_ODST TRUE)
	(vs_enable_moving gr_ODST TRUE)	

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Boom! Yeah! That's the way!"))
		(vs_play_line mickey TRUE SC130_0200)
		(sleep 10)

		(if dialogue (print "MARINE_03 01: Think Brutes can swim?"))
		(vs_play_line marine_01 TRUE SC130_0210)
		(sleep 10)

		(if dialogue (print "MARINE_03 02: Not if they're dead!"))
		(vs_play_line marine_02 TRUE SC130_0220)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_bridge_tunnel
	;(if debug (print "mission dialogue:030:bridge:tunnel"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0230")
		;	(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Phantom! Other side of the wall! Let's move!"))
		(vs_play_line mickey TRUE SC130_0230)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Down the ramp, Dutch! There's a tunnel under the wall!"))
		(vs_play_line mickey TRUE SC130_0240)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_030_bridge_exit
	;(if debug (print "mission dialogue:030:bridge:exit"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0250")
		;	(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): We got friendlies taking heavy fire! Let's give 'em a hand!"))
		(vs_play_line mickey TRUE SC130_0250)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Move it Dutch! Those boys are getting hammered!"))
		(vs_play_line mickey TRUE SC130_0260)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_040_main_arena_start
	;(if debug (print "mission dialogue:040:main:arena:start"))

		; cast the actors
		(vs_cast gr_main_arena_cov FALSE 10 "SC130_0270")
			(set brute (vs_role 1))
			
		(vs_cast gr_main_arena_allies FALSE 10 "SC130_0280")
			(set fem_marine (vs_role 2))			

	; movement properties
	(vs_enable_pathfinding_failsafe gr_main_arena_cov TRUE)
	(vs_enable_looking gr_main_arena_cov TRUE)
	(vs_enable_targeting gr_main_arena_cov TRUE)
	(vs_enable_moving gr_main_arena_cov TRUE)

	(vs_enable_pathfinding_failsafe gr_main_arena_allies TRUE)
	(vs_enable_looking gr_main_arena_allies TRUE)
	(vs_enable_targeting gr_main_arena_allies TRUE)
	(vs_enable_moving gr_main_arena_allies TRUE)

	(sleep 1)

		(if dialogue (print "BRUTE: (Battle roar) We do the Prophets' bidding! Show no fear!"))
		(vs_play_line brute TRUE SC130_0270)
		(sleep 30)

		(if dialogue (print "FEM_MARINE: All teams, hold the ridge! Don't let them near the building!"))
		(vs_play_line fem_marine TRUE SC130_0280)

	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_040_hunter
	(if debug (print "mission dialogue:040:hunter"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0290" "SC130_0300")
			(set brute (vs_role 1))
			(set fem_marine (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "BRUTE: Attack, you worms! Burn the enemy from their holes!"))
		(vs_play_line brute TRUE SC130_0290)
		(sleep 10)

		(if dialogue (print "FEM_MARINE: Flank those Hunters! Stay mobile, and take 'em out!"))
		(vs_play_line fem_marine TRUE SC130_0300)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_040_fall_back
	(if debug (print "mission dialogue:040:fall:back"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0310" "SC130_0320")
			(set mickey (vs_role 1))
			(set fem_marine (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Dutch! Get to one of the turrets up top! Light these bastards up!"))
		(vs_play_line mickey TRUE SC130_0310)
		(sleep 10)

		(if dialogue (print "FEM_MARINE: Man the turrets! Mow 'em down, but watch those Wraiths!"))
		(vs_play_line fem_marine TRUE SC130_0320)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

*;
; ===================================================================================================================================================

(script dormant md_040_brute_advance_01
	;(if debug (print "mission dialogue:040:brute:advance:01"))

		; cast the actors

		(vs_cast gr_main_arena_cov FALSE 10 "SC130_0340")
			(set brute (vs_role 1))
			
		(vs_cast gr_main_arena_allies FALSE 10 "SC130_0350")
			(set fem_marine (vs_role 2))			
			

	; movement properties
	(vs_enable_pathfinding_failsafe gr_main_arena_cov TRUE)
	(vs_enable_looking gr_main_arena_cov TRUE)
	(vs_enable_targeting gr_main_arena_cov TRUE)
	(vs_enable_moving gr_main_arena_cov TRUE)

	(vs_enable_pathfinding_failsafe gr_main_arena_allies TRUE)
	(vs_enable_looking gr_main_arena_allies TRUE)
	(vs_enable_targeting gr_main_arena_allies TRUE)
	(vs_enable_moving gr_main_arena_allies TRUE)

	(sleep 1)

		(if dialogue (print "BRUTE: Courage, warriors! Take this hill or die upon it!"))
		(vs_play_line brute TRUE SC130_0340)
		(sleep 30)

		(if dialogue (print "FEM_MARINE: Fall back! I repeat: fall back to the top of the ridge!"))
		(vs_play_line fem_marine TRUE SC130_0350)

	; cleanup
	(vs_release_all)
)
	
; ===================================================================================================================================================

(script dormant md_040_brute_advance_02
	;(if debug (print "mission dialogue:040:brute:advance:02"))

		; cast the actors
		(vs_cast gr_main_arena_cov TRUE 10 "SC130_0330")
			(set brute (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_main_arena_cov TRUE)
	(vs_enable_looking gr_main_arena_cov TRUE)
	(vs_enable_targeting gr_main_arena_cov TRUE)
	(vs_enable_moving gr_main_arena_cov TRUE)

	(sleep 1)

		(if dialogue (print "BRUTE: Forward! Grind their bones beneath your feet!"))
		(vs_play_line brute TRUE SC130_0330)

	; cleanup
	(vs_release_all)
)	

; ===================================================================================================================================================

(script dormant md_050_phantom
	;(if debug (print "mission dialogue:050:phantom"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0360")
		;	(set mickey (vs_role 1))
			
		(vs_cast gr_main_arena_allies FALSE 10 "SC130_0370")
			(set fem_marine (vs_role 2))			

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)
	
	(vs_enable_pathfinding_failsafe gr_main_arena_allies TRUE)
	(vs_enable_looking gr_main_arena_allies TRUE)
	(vs_enable_targeting gr_main_arena_allies TRUE)
	(vs_enable_moving gr_main_arena_allies TRUE)	

	(sleep 1)

		(if dialogue (print "MICKEY (radio): More Phantoms! Look sharp!"))
		(vs_play_line mickey TRUE SC130_0360)
		(sleep 60)

		(if dialogue (print "FEM_MARINE: We can't hold them forever! We gotta fall back!"))
		(vs_play_line fem_marine TRUE SC130_0370)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_050_ridge_retreat_01
	;(if debug (print "mission dialogue:050:ridge:retreat:01"))

		; cast the actors
		(vs_cast gr_main_arena_allies FALSE 10 "SC130_0380")
			(set fem_marine (vs_role 1))

		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0390")
		;	(set mickey (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_main_arena_allies TRUE)
	(vs_enable_looking gr_main_arena_allies TRUE)
	(vs_enable_targeting gr_main_arena_allies TRUE)
	(vs_enable_moving gr_main_arena_allies TRUE)
	
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)	

	(sleep 1)

		(if dialogue (print "FEM_MARINE: Retreat! Everyone get inside the building!"))
		(vs_play_line fem_marine FALSE SC130_0380)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Too many of 'em Dutch! We gotta scoot!"))
		(vs_play_line mickey TRUE SC130_0390)
		(sleep 10)

		;(if dialogue (print "MICKEY (radio): Dutch! Inside the building! Now! "))
		;(vs_play_line mickey TRUE SC130_0400)
		;(sleep 10)
		
	(wake lobby_entry)	
	
	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_050_ridge_retreat_02
	;(if debug (print "mission dialogue:050:ridge:retreat:02"))

		; cast the actors
		(vs_cast sq_lobby_sarge/sarge TRUE 10 "SC130_0410")
			(set sergeant (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe sergeant TRUE)
	(vs_enable_looking sergeant TRUE)
	(vs_enable_targeting sergeant TRUE)
	(vs_enable_moving sergeant TRUE)

	(sleep 1)

		(if dialogue (print "SERGEANT: Move your asses, troopers! I'm about to lock this building down tight!"))
		(vs_play_line sergeant TRUE SC130_0410)
		
		(sleep (* 30 10))

	(if (= g_lobby_obj_control 0) 
		(begin
			(if dialogue (print "SERGEANT: Through the security doors! Move!"))
			(vs_play_line sergeant TRUE SC130_0420)
		)	
	)
		(sleep (* 30 10))

	(if (= g_lobby_obj_control 0) 
		(begin
			(if dialogue (print "SERGEANT: You hear me, trooper? Get inside! I am closing these doors!"))
			(vs_play_line sergeant TRUE SC130_0430)
		)
	)
		
	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================

(script dormant md_060_lobby_conversation
	;(if debug (print "mission dialogue:060:lobby:conversation"))

		; cast the actors
		(vs_cast sq_lobby_sarge/sarge TRUE 10 "SC130_0440")
			(set sergeant (vs_role 1))
			
		; cast the actors
		;(set mickey sq_bridge_ODST)
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0450")
		;	(set mickey (vs_role 2))
			
			
		; cast the actors
		(vs_cast gr_lobby_allies_left TRUE 10 "SC130_0480")
			(set marine_03 (vs_role 3))

	; movement properties
	(vs_enable_pathfinding_failsafe sergeant TRUE)
	(vs_enable_looking sergeant FALSE)
	(vs_enable_targeting sergeant FALSE)
	(vs_enable_moving sergeant FALSE)

	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey FALSE)
	(vs_enable_targeting mickey FALSE)
	(vs_enable_moving mickey FALSE)
	
	(vs_enable_pathfinding_failsafe marine_03 TRUE)
	(vs_enable_looking marine_03 TRUE)
	(vs_enable_targeting marine_03 TRUE)
	(vs_enable_moving marine_03 TRUE)

	(sleep 1)
	
			(vs_go_to mickey TRUE ps_lobby_entry_ODST/run_01)
			(vs_go_to mickey TRUE ps_lobby_entry_ODST/run_02)	
	
		;variable for the doors to close
		(set g_lobby_entry_ODST 1)	
		
		(sleep_until (= g_lobby_obj_control 2) 5)
			
			(vs_go_to_and_face mickey FALSE ps_lobby_entry_ODST/stand_01 ps_lobby_entry_ODST/face_01)

		(if dialogue (print "SERGEANT: Hurry up, marines! Check those charges! "))
		(vs_play_line sergeant TRUE SC130_0440)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Uh�charges? Interrogative, Sergeant. Aren't we supposed to protect this building?"))
		(vs_play_line mickey FALSE SC130_0450)
		
		(sleep 20)

			(vs_go_to_and_face sergeant TRUE ps_lobby_entry_sarge/stand_01 ps_lobby_entry_sarge/face_01)

		(sleep 30)
		(if dialogue (print "SERGEANT: Trooper, I have orders to deny enemy access to all classifed data housed in this facilty -- by any means necessary. You don�t like it, jump yer ass back into orbit!"))
		(vs_play_line sergeant TRUE SC130_0460)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Only think I don't like, Sergeant, is that my ass is currently inside this facility. How 'bout you slave all those charges to my comm, let me blow 'em from a safe distance?"))
		(vs_play_line mickey TRUE SC130_0470)
		(sleep 10)

			(wake lobby_place_02)

		(if dialogue (print "MARINE_03: They're cutting-through! We're running out of time!"))
		(vs_play_line marine_03 TRUE SC130_0480)
		(sleep 10)

		(if dialogue (print "SERGEANT: Settle-down and find some cover! (pause) OK trooper, you make it out of here alive? I'll let you light the fuse."))
		(vs_play_line sergeant TRUE SC130_0490)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Sergeant, you got yourself a deal."))
		(vs_play_line mickey TRUE SC130_0500)
		(sleep 10)

		(if dialogue (print "SERGEANT: Here they come! Watch the crossfire! And someone man that turret!"))
		(vs_play_line sergeant TRUE SC130_0510)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(global boolean b_turret_line_played FALSE)
(global boolean b_turret_left_01 TRUE)
(global boolean b_turret_left_02 TRUE)
(global boolean b_turret_left_03 TRUE)
(global boolean b_turret_left_04 TRUE)
(global boolean b_turret_right_01 TRUE)
(global boolean b_turret_right_02 TRUE)
(global boolean b_turret_right_03 TRUE)
(global boolean b_turret_right_04 TRUE)

(script dormant turret_dialogue
	;(set mickey sq_bridge_ODST)
	(set sergeant sq_lobby_sarge)
)

(script static void turret_dialogue_left
		(sleep (* 30 8))
	(begin_random
		(begin	
			(if (and (not b_turret_line_played) b_turret_left_01)
				(begin
					(if dialogue (print "SERGEANT: Left side, trooper! Bring that turret 'round!"))
					(ai_play_line sergeant "SC130_0540")
					(set b_turret_left_01 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)			
		)		
		(begin	
			(if (and (not b_turret_line_played) b_turret_left_02)
				(begin
					(if dialogue (print "SERGEANT: They're pouring-in to the left! Adjust your fire!"))
					(ai_play_line sergeant "SC130_0550")
					(set b_turret_left_02 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)			
		)
		(begin	
			(if (and (not b_turret_line_played) b_turret_left_03)
				(begin
					(if dialogue (print "MICKEY (radio): Left side, Dutch!"))
					(ai_play_line mickey "SC130_0600")
					(set b_turret_left_03 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)			
		)
		(begin	
			(if (and (not b_turret_line_played) b_turret_left_04)
				(begin
					(if dialogue (print "MICKEY (radio): They're pouring-in to the left!"))
					(ai_play_line mickey "SC130_0610")
					(set b_turret_left_04 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)			
		)
	)			
	(sleep 1)
	(set b_turret_line_played FALSE)
)		

(script static void turret_dialogue_right
		(sleep (* 30 8))
	(begin_random
		(begin	
			(if (and (not b_turret_line_played) b_turret_right_01)
				(begin
					(if dialogue (print "SERGEANT: Trooper! Bring that turret right!"))
					(ai_play_line sergeant "SC130_0520")
					(set b_turret_right_01 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)			
		)		
		(begin	
			(if (and (not b_turret_line_played) b_turret_right_02)
				(begin
					(if dialogue (print "SERGEANT: Where's that fifty? We got hostiles right!"))
					(ai_play_line sergeant "SC130_0530")
					(set b_turret_right_02 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)			
		)
		(begin	
			(if (and (not b_turret_line_played) b_turret_right_03)
				(begin
					(if dialogue (print "MICKEY (radio): Dutch! Scan right!"))
					(ai_play_line mickey "SC130_0580")
					(set b_turret_right_03 FALSE)
					(set b_turret_line_played TRUE)					
				)	
			)
		)	
		(begin	
			(if (and (not b_turret_line_played) b_turret_right_04)
				(begin
					(if dialogue (print "MICKEY (radio): Focus your fire to the right!"))
					(ai_play_line mickey "SC130_0590")
					(set b_turret_right_04 FALSE)
					(set b_turret_line_played TRUE)
				)						
			)
		)	
	)
	(sleep 1)
	(set b_turret_line_played FALSE)
)

;* ===================================================================================================================================================


(script dormant md_060_turret_right_sarge
	(if debug (print "mission dialogue:060:turret:right:sarge"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0520")
			(set sergeant (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "SERGEANT: Trooper! Bring that turret right!"))
		(vs_play_line sergeant TRUE SC130_0520)
		(sleep 10)

		(if dialogue (print "SERGEANT: Where's that fifty? We got hostiles right!"))
		(vs_play_line sergeant TRUE SC130_0530)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_060_turret_left_sarge
	(if debug (print "mission dialogue:060:turret:left:sarge"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0540")
			(set sergeant (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "SERGEANT: Left side, trooper! Bring that turret 'round!"))
		(vs_play_line sergeant TRUE SC130_0540)
		(sleep 10)

		(if dialogue (print "SERGEANT: They're pouring-in to the left! Adjust your fire!"))
		(vs_play_line sergeant TRUE SC130_0550)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_060_turret_right_mickey
	(if debug (print "mission dialogue:060:turret:right:mickey"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0580")
			(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Dutch! Scan right!"))
		(vs_play_line mickey TRUE SC130_0580)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Focus your fire to the right!"))
		(vs_play_line mickey TRUE SC130_0590)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_060_turret_left_mickey
	(if debug (print "mission dialogue:060:turret:left:mickey"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0600")
			(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Left side, Dutch!"))
		(vs_play_line mickey TRUE SC130_0600)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): They're pouring-in to the left!"))
		(vs_play_line mickey TRUE SC130_0610)
		(sleep 10)

	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================

(script dormant md_060_rear_attack_sarge
	
	; cleanup
	(vs_release_all)	
	
	;(if debug (print "mission dialogue:060:rear:attack:sarge"))

		; cast the actors
		;(vs_cast sq_lobby_sarge/sarge TRUE 10 "SC130_0560")
		;	(set sergeant (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe sergeant TRUE)
	(vs_enable_looking sergeant TRUE)
	(vs_enable_targeting sergeant TRUE)
	(vs_enable_moving sergeant TRUE)

	(sleep 1)


	(begin_random
		(begin
			(if b_rear_attack
				(begin
					(if dialogue (print "SERGEANT: Phantom dropping reinforcements! Cover our rear, trooper!"))
					(vs_play_line sergeant TRUE SC130_0560)
					(set b_rear_attack FALSE)
				)	
			)
		)
		(begin
			(if b_rear_attack
				(begin			
					(if dialogue (print "SERGEANT: Hostiles coming in behind us! Bring that turret around!"))
					(vs_play_line sergeant TRUE SC130_0570)
					(set b_rear_attack FALSE)
				)
			)		
		)
	)			
	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_060_rear_attack_mickey
	(if debug (print "mission dialogue:060:rear:attack:mickey"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0620")
			(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Phantom dropping-in, Dutch! Watch our six!"))
		(vs_play_line mickey TRUE SC130_0620)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Bring that turret around! They�re coming in behind!"))
		(vs_play_line mickey TRUE SC130_0630)
		(sleep 10)

	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================

(script dormant md_060_lobby_combat_end
	(if debug (print "mission dialogue:060:lobby:combat:end"))

		; cast the actors
		;(vs_cast sq_lobby_sarge/sarge TRUE 10 "SC130_0640")
		;	(set sergeant (vs_role 1))
			
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0650")
		;	(set mickey (vs_role 2))			

	; movement properties
	(vs_enable_pathfinding_failsafe sergeant TRUE)
	(vs_enable_looking sergeant TRUE)
	(vs_enable_targeting sergeant TRUE)
	(vs_enable_moving sergeant TRUE)

	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep 1)

		(if dialogue (print "SERGEANT: You still here, Trooper?"))
		(vs_play_line sergeant TRUE SC130_0640)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Affirmative, Sergeant!"))
		(vs_play_line mickey TRUE SC130_0650)
		(sleep 10)

		(if dialogue (print "SERGEANT: Congratulations. Transfering all detonation codes to your comm..."))
		(vs_play_line sergeant TRUE SC130_0660)
		(sleep 10)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_060_elev_arrives_sarge
	(if debug (print "mission dialogue:060:elev:arrives:sarge"))

		; cast the actors
		(vs_cast sq_lobby_civ_01/civilian TRUE 10 "SC130_0670")
			(set civilian (vs_role 1))
			
		;(vs_cast sq_lobby_sarge/sarge TRUE 10 "SC130_0680")
		;	(set sergeant (vs_role 2))
			
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0710")
		;	(set mickey (vs_role 3))						

	; movement properties
	(vs_enable_pathfinding_failsafe civilian TRUE)
	(vs_enable_looking civilian TRUE)
	(vs_enable_targeting civilian TRUE)
	(vs_enable_moving civilian TRUE)

	(vs_enable_pathfinding_failsafe sergeant TRUE)
	(vs_enable_looking sergeant TRUE)
	(vs_enable_targeting sergeant TRUE)
	(vs_enable_moving sergeant TRUE)

	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep 1)

			(vs_go_to_and_face sergeant TRUE ps_elevator_sarge/stand_01 ps_elevator_sarge/face_01)			

		(if dialogue (print "CIVILIAN: We couldn't reach the data-core. Tunnels were all gummed-up or frozen!"))
		(vs_play_line civilian TRUE SC130_0670)
		(sleep 10)

		(if dialogue (print "SERGEANT: You rig the charges in the shaft?"))
		(vs_play_line sergeant TRUE SC130_0680)
		(sleep 10)

		(if dialogue (print "CIVILIAN: Best we could. But the Buggers -- "))
		(vs_play_line civilian TRUE SC130_0690)
		(sleep 10)

		(if dialogue (print "SERGEANT: Everyone on the lift! We're heading for the roof!"))
		(vs_play_line sergeant TRUE SC130_0700)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Don't have to tell me twice!"))
		(vs_play_line mickey TRUE SC130_0710)
		
	(wake md_070_elev_ride)
	(wake md_060_elev_entry_reminder)

	; cleanup
	(vs_release_all)
)

;* ===================================================================================================================================================

(script dormant md_060_elev_arrives_mickey
	(if debug (print "mission dialogue:060:elev:arrives:mickey"))

		; cast the actors
		(vs_cast SQUAD TRUE 10 "SC130_0720" "SC130_0730")
			(set mickey (vs_role 1))
			(set civilian (vs_role 2))

	; movement properties
	(vs_enable_pathfinding_failsafe gr_allies TRUE)
	(vs_enable_looking gr_allies TRUE)
	(vs_enable_targeting gr_allies TRUE)
	(vs_enable_moving gr_allies TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Sergeant's gone, Dutch. But I've got control of the detonators."))
		(vs_play_line mickey TRUE SC130_0720)
		(sleep 10)

		(if dialogue (print "CIVILIAN: Shaft is rigged to blow. But we couldn't reach the core!"))
		(vs_play_line civilian TRUE SC130_0730)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): What core?"))
		(vs_play_line mickey TRUE SC130_0740)
		(sleep 10)

		(if dialogue (print "CIVILIAN: The data-core for  the whole damn city. The buggers --"))
		(vs_play_line civilian TRUE SC130_0750)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Everyone on the lift! We're heading for the roof!"))
		(vs_play_line mickey TRUE SC130_0760)
		(sleep 10)

	; cleanup
	(vs_release_all)
)
*;
; ===================================================================================================================================================

(script dormant md_060_elev_entry_reminder
	(if debug (print "mission dialogue:060:elev:entry:reminder"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0770")
		;	(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep (* 30 10))

		(if dialogue (print "MICKEY (radio): We got Buggers coming up from below! Get over here, Dutch!"))
		(vs_play_line mickey TRUE SC130_0770)

	(sleep (* 30 15))

		(if dialogue (print "MICKEY (radio): On the lift, Dutch! Now!"))
		(vs_play_line mickey TRUE SC130_0780)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_070_elev_ride
	(if debug (print "mission dialogue:070:elev:ride"))

(sleep_until (volume_test_players tv_lobby_04) 5)

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0790")
		;	(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): Evac bird inbound! They see multiple hostiles on the rooftop pad!"))
		(vs_play_line mickey TRUE SC130_0790)
		(sleep 10)

		(if dialogue (print "MICKEY (radio): Brutes on top, Buggers on the bottom...Man, I hate being meat in a bastard sandwich!"))
		(vs_play_line mickey TRUE SC130_0800)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_080_exit
	(if debug (print "mission dialogue:080:exit"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0810")
		;	(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep 1)

		(if dialogue (print "MICKEY (radio): There's our ride! Go, go, go!"))
		(vs_play_line mickey TRUE SC130_0810)

	(wake md_080_exit_reminder)

	; cleanup
	(vs_release_all)
)

; ===================================================================================================================================================

(script dormant md_080_exit_reminder
	(if debug (print "mission dialogue:080:exit:reminder"))

		; cast the actors
		;(vs_cast sq_bridge_ODST/odst TRUE 10 "SC130_0820")
		;	(set mickey (vs_role 1))

	; movement properties
	(vs_enable_pathfinding_failsafe mickey TRUE)
	(vs_enable_looking mickey TRUE)
	(vs_enable_targeting mickey TRUE)
	(vs_enable_moving mickey TRUE)

	(sleep (* 30 10))
	
	(if	
		(or
			(vehicle_test_seat_unit pelican_01 "" (player0))
			(vehicle_test_seat_unit pelican_01 "" (player1))
			(vehicle_test_seat_unit pelican_01 "" (player2))
			(vehicle_test_seat_unit pelican_01 "" (player3))
		)
		(begin
			(if dialogue (print "MICKEY (radio): Let's get out of here, Dutch! Come on!"))
			(vs_play_line mickey TRUE SC130_0820)
		)	
	)

	(sleep (* 30 10))

	(if	
		(or
			(vehicle_test_seat_unit pelican_01 "" (player0))
			(vehicle_test_seat_unit pelican_01 "" (player1))
			(vehicle_test_seat_unit pelican_01 "" (player2))
			(vehicle_test_seat_unit pelican_01 "" (player3))
		)
		(begin
			(if dialogue (print "MICKEY (radio): Building's lost! Nothing more we can do!"))
			(vs_play_line mickey TRUE SC130_0830)
		)
	)
	(sleep (* 30 10))
	
	(if	
		(or
			(vehicle_test_seat_unit pelican_01 "" (player0))
			(vehicle_test_seat_unit pelican_01 "" (player1))
			(vehicle_test_seat_unit pelican_01 "" (player2))
			(vehicle_test_seat_unit pelican_01 "" (player3))
		)
		(begin
			(if dialogue (print "MICKEY (radio): Dutch, you dumb-ass! Get on this Pelican! Now!"))
			(vs_play_line mickey TRUE SC130_0840)
		)
	)	
	; cleanup
	(vs_release_all)
)
