;===================================================================================================================================================
;======================= LINEAR 100 MISSION SCRIPTS ================================================================================================
;===================================================================================================================================================
(global short g_start_pitch_l100 -52)

(global looping_sound m_l100_intro "sound\music\cpaul\reason_pad\reason_pad")
(global looping_sound sfx_phone_ring "sound\levels\temp\prototypes\h100\phone_ring_looping\phone_ring_looping")

(script dormant l100_mission
	; mechanics training 
	(if debug (print "L100 Activated..."))
	
	; set current scene location 
	(gp_integer_set gp_current_scene 1)

	; initialize hub state 
	(initialize_l100)
	(sleep 1)
		
	; l110 camera setup 
	(l100_begin)
	(sleep 1)
	
	; set up player 0's pod 
	(f_setup_pod
					(player0)
					pod_odst_00
					pod00_control_01
					pod00_control_02
					pod00_control_03
					pod00_control_04
	)
	(wake blow_hatch_00)

		; create additional odst pods 
		(if (>= (game_coop_player_count) 2)	(begin
											(f_setup_pod
																(player1)
																pod_odst_01
																pod01_control_01
																pod01_control_02
																pod01_control_03
																pod01_control_04
											)
											(wake blow_hatch_01)
										)
		)
		(if (>= (game_coop_player_count) 3)	(begin
											(f_setup_pod
																(player2)
																pod_odst_02
																pod02_control_01
																pod02_control_02
																pod02_control_03
																pod02_control_04
											)
											(wake blow_hatch_02)
										)
		)
		(if (>= (game_coop_player_count) 4)	(begin
											(f_setup_pod
																(player3)
																pod_odst_03
																pod03_control_01
																pod03_control_02
																pod03_control_03
																pod03_control_04
											)
											(wake blow_hatch_03)
										)
		)
		(sleep 1)
		
		
	; wake secondary scripts 
	(wake pda_breadcrumbs)
	
	; play chapter title 
	(chapter_01)

		; spawn ambient phantoms 
		(ai_place sq_l100_phantom_01)
		(ai_place sq_l100_phantom_02)
		
	; delay timer 
	(sleep (* 30 3))
	
	; wake up the rookie 
	(l100_wake_up)
	
	; this is totally just a hack 
	(sleep_until (volume_test_players tv_l100_temp) 30 (* 30 60 1.5))
		
		; activate telepone 
		(device_group_set_immediate dg_l100_phone 1)
		(sound_looping_start sfx_phone_ring arg_device_l100_phone_01 1)
)



;===================================================================================================================================================
;=============================== LINEAR 100 POD LOAD SCRIPTS =======================================================================================
;===================================================================================================================================================
(script static void	(f_setup_pod
									(unit		player_name)
									(object_name	odst_pod)
									(object_name	pod_control_01)
									(object_name	pod_control_02)
									(object_name	pod_control_03)
									(object_name	pod_control_04)
				)
	(if debug (print "*** setup odst pod ***"))
	
	; create pod 
	(object_create odst_pod)
	
	; create controls 
	(object_create pod_control_01)
	(object_create pod_control_02)
	(object_create pod_control_03)
	(object_create pod_control_04)
	(sleep 1)

	; look training hack to allow players in vehicles to activate device machines 
	(player_set_look_training_hack player_name TRUE)

	; attach all control to pods 
	(objects_attach odst_pod "release_top"		pod_control_01 "")
	(objects_attach odst_pod "release_bottom"	pod_control_02 "")
	(objects_attach odst_pod "release_left"		pod_control_03 "")
	(objects_attach odst_pod "release_right"	pod_control_04 "")
	
	; load odst into pod 
	(vehicle_load_magic odst_pod "pod_d" player_name)
	
	; set the players pitch 
		(player0_set_pitch g_start_pitch_l100 0)
		(player1_set_pitch g_start_pitch_l100 0)
		(player2_set_pitch g_start_pitch_l100 0)
		(player3_set_pitch g_start_pitch_l100 0)
)

(script dormant blow_hatch_00
	(sleep_until	(and
					(<= (device_get_position pod00_control_01) 0)
					(<= (device_get_position pod00_control_02) 0)
					(<= (device_get_position pod00_control_03) 0)
					(<= (device_get_position pod00_control_04) 0)
				)
	1)
	
	(f_blow_hatch
				(player0)
				pod_odst_00
				pod00_control_01
				pod00_control_02
				pod00_control_03
				pod00_control_04
	)
)
(script dormant blow_hatch_01
	(sleep_until	(and
					(<= (device_get_position pod01_control_01) 0)
					(<= (device_get_position pod01_control_02) 0)
					(<= (device_get_position pod01_control_03) 0)
					(<= (device_get_position pod01_control_04) 0)
				)
	1)
	
	(f_blow_hatch
				(player1)
				pod_odst_01
				pod01_control_01
				pod01_control_02
				pod01_control_03
				pod01_control_04
	)
)
(script dormant blow_hatch_02
	(sleep_until	(and
					(<= (device_get_position pod02_control_01) 0)
					(<= (device_get_position pod02_control_02) 0)
					(<= (device_get_position pod02_control_03) 0)
					(<= (device_get_position pod02_control_04) 0)
				)
	1)
	
	(f_blow_hatch
				(player2)
				pod_odst_02
				pod02_control_01
				pod02_control_02
				pod02_control_03
				pod02_control_04
	)
)
(script dormant blow_hatch_03
	(sleep_until	(and
					(<= (device_get_position pod03_control_01) 0)
					(<= (device_get_position pod03_control_02) 0)
					(<= (device_get_position pod03_control_03) 0)
					(<= (device_get_position pod03_control_04) 0)
				)
	1)
	
	(f_blow_hatch
				(player3)
				pod_odst_03
				pod03_control_01
				pod03_control_02
				pod03_control_03
				pod03_control_04
	)
)

(script static void (f_blow_hatch
							(unit	player_name)
							(object	odst_pod)
							(object	control_01)
							(object	control_02)
							(object	control_03)
							(object	control_04)
				)
	(sleep 30)
	
	(fade_out 1 1 1 3)
	(sleep 1)
	
	; play sound 
	(sound_impulse_start "sound\visual_fx\h3_lrg_explosion" NONE 1)
	(object_set_permutation odst_pod "" "off")
	
	; destroy switches 
	(object_destroy control_01)
	(object_destroy control_02)
	(object_destroy control_03)
	(object_destroy control_04)
	
	; look training hack to allow players in vehicles to activate device machines 
	(player_set_look_training_hack player_name FALSE)
	(sleep 1)

	(fade_in 1 1 1 5)
	(sleep 30)
	
	; eject player from vehicle 
	(vehicle_unload odst_pod "")
)

; ========================================================================
(global animation_graph  g_anim_graph_odst_recon "objects\characters\odst_recon\odst_recon")

(script static void animate_player
	(custom_animation_relative_loop (player0) g_anim_graph_odst_recon "warthog_d:idle" FALSE pod_odst_00)
)



;===================================================================================================================================================
;=============================== LINEAR 100 AMBIENT SCRIPTS ========================================================================================
;===================================================================================================================================================
(global looping_sound sfx_chapter_fx "sound\game_sfx\pda\pda_zooming\pda_zooming")
(global sound sfx_virgil_in "sound\device_machines\virgil\virgil_in")
(global sound sfx_virgil_out "sound\device_machines\virgil\virgil_out")

; ========================================================================
(script static void l100_begin
	(if debug (print "*** begin l100 ***"))

		; the ai will disregard all players 
		(ai_disregard (players) TRUE)

		; players cannot take damage 
		(object_cannot_take_damage (players))

	; fade screen to black 
	(fade_out 0 0 0 0)
		(sleep 1)

	; scale player input to zero 
	(player_control_fade_out_all_input 0)
		
		; hide players 
		(object_hide (player0) TRUE)
		(object_hide (player1) TRUE)
		(object_hide (player2) TRUE)
		(object_hide (player3) TRUE)
	
	; fade out the chud 
	(chud_cinematic_fade 0 0)
	
	; pause the meta-game timer 
	(campaign_metagame_time_pause TRUE)
)

; ========================================================================
(script static void chapter_01
	; delay timer 
	(sleep 60)
	(sound_impulse_start sfx_virgil_in NONE 1)
	(sleep 60)

	; play the chapter title sequence 
	(cinematic_set_title title_1)
		(chapter_sound_fx)
	(cinematic_set_title title_2)
		(chapter_sound_fx)
	(cinematic_set_title title_3)
		(chapter_sound_fx)
		(sleep 90)
	
	; play out sound 
	(sound_impulse_start sfx_virgil_out NONE 1)
)

(script static void chapter_sound_fx
	(sound_looping_start sfx_chapter_fx NONE 1)
	(sleep 45)
	(sound_looping_stop sfx_chapter_fx)
	(sleep 45)
)

; ========================================================================
(script static void l100_wake_up
	(fade_out 0 0 0 0)
	(sleep (* 30 3))

		; single slow fade in 
		(fade_in 0 0 0 270)
		(sleep 45)
		(fade_out 0 0 0 10)

	; keep black 
	(sleep (* 30 3))

		; flicker 
		(fade_out 0 0 0 20)
		(sleep 5)
		(fade_in 0 0 0 20)
		(sleep 5)
		(fade_out 0 0 0 35)
		(sleep 10)
		(fade_in 0 0 0 20)
		(sleep 5)
		(fade_out 0 0 0 20)

	; keep black 
	(sleep (* 30 3))

		; slow fade in 
		(fade_in 0 0 0 150)

	; scale player input to one 
	(player_control_fade_in_all_input 1)

	; fade in the HUD 
	(chud_cinematic_fade 1 1)
		
	; pause the meta-game timer 
	(campaign_metagame_time_pause FALSE)

		; the ai will disregard all players 
		(ai_disregard (players) 	FALSE)
	
		; players cannot take damage 
		(object_can_take_damage (players))
)

;=============================== LINEAR 100 ENCOUNTER SCRIPTS ======================================================================================
;===================================================================================================================================================


(global looping_sound sfx_servo_loop "sound\device_machines\servo_looping\servo_looping")
(global sound sfx_timer "sound\game_sfx\multiplayer\countdown_timer")


(script static void l100_answer_phone
	(if debug (print "*** you have answered the phone ***"))
	
	; do all kinds of cool shit here 
	(sound_looping_stop sfx_phone_ring)
	(sleep 15)
	
	; start hack visual / audio 
	(fade_out 0 0 0 0)
	(sleep 15)
	(sound_looping_start sfx_servo_loop NONE 1)
	(sleep 45)
	(sound_looping_stop sfx_servo_loop)
	(sleep 15)
	
	; virgil in 
	(sound_impulse_start sfx_virgil_in NONE 1)
		(sleep 30)
	
		; opening blink 
		(cinematic_set_title title_blink)
		(sound_impulse_start sfx_timer NONE 1)
			(sleep 30)
		(cinematic_set_title title_blink)
		(sound_impulse_start sfx_timer NONE 1)
			(sleep 30)
		(cinematic_set_title title_blink_long)
		(sound_impulse_start sfx_timer NONE 1)
			(sleep 30)

	; access terminals 
	(cinematic_set_title title_access)
		(chapter_sound_fx)
	(cinematic_set_title title_establish)
		(chapter_sound_fx)
	(cinematic_set_title title_download)
		(chapter_sound_fx)
	(cinematic_set_title title_interrupted)
		(chapter_sound_fx)
		
		; closing blink 
		(cinematic_set_title title_blink_end)
		(sound_impulse_start sfx_timer NONE 1)
			(sleep 30)
		(cinematic_set_title title_blink_end)
		(sound_impulse_start sfx_timer NONE 1)
			(sleep 30)
		(cinematic_set_title title_blink_end)
		(sound_impulse_start sfx_timer NONE 1)
			(sleep 90)
		
	; virgil out 
	(sound_impulse_start sfx_virgil_out NONE 1)
		(sleep 60)

	(device_group_set_immediate dg_l100_door_01 1)
	(device_group_set_immediate dg_l100_door_02 2)
	
	(fade_in 0 0 0 0)
)

(script static void sound_fx_servo
	(sound_looping_start sfx_servo_loop NONE 1)
	(sleep 45)
	(sound_looping_stop sfx_servo_loop)
	(sleep 45)
)

; ======= secondary scripts =======================================================================
(global vehicle v_l100_phantom_01 NONE)
(global vehicle v_l100_phantom_02 NONE)


(script command_script cs_l100_phantom_01
	(set v_l100_phantom_01 (ai_vehicle_get_from_starting_location sq_l100_phantom_01/phantom))
		(sleep 1)
		
	; move phantom into place 
	(cs_enable_pathfinding_failsafe TRUE)
		(sleep 1)

	; hold phanto in place 
	(sleep (* 30 2))
	
	; move out 
	(cs_fly_by ps_l100_phantom/ph01_00)
	(cs_fly_by ps_l100_phantom/ph01_01 5)
	(cs_fly_by ps_l100_phantom/ph01_02 5)
	(cs_fly_by ps_l100_phantom/ph01_03 5)
	(cs_fly_by ps_l100_phantom/ph01_04 5)
	(cs_fly_by ps_l100_phantom/ph01_05 5)

		; begin opening music 
		(sound_looping_start m_l100_intro NONE 1)
		
	(cs_fly_by ps_l100_phantom/ph01_06)
	(cs_fly_by ps_l100_phantom/ph01_07)

	(cs_fly_by ps_l100_phantom/ph01_08)
	(cs_fly_by ps_l100_phantom/ph01_erase)
	
	; erase phantom 
	(ai_erase ai_current_squad)
)
		



(script command_script cs_l100_phantom_02
	(set v_l100_phantom_02 (ai_vehicle_get_from_starting_location sq_l100_phantom_02/phantom))
		(sleep 1)

	; move phantom into place 
	(cs_enable_pathfinding_failsafe TRUE)
		(sleep 1)

	; move out 
	(cs_fly_by ps_l100_phantom/ph02_00)
		(cs_vehicle_speed 0.3)
	(cs_fly_by ps_l100_phantom/ph02_01)
	(cs_fly_by ps_l100_phantom/ph02_02)
		(cs_vehicle_speed 0.6)
	(cs_fly_by ps_l100_phantom/ph02_03)
	(cs_fly_by ps_l100_phantom/ph02_04)
		(cs_vehicle_speed 1)
	(cs_fly_by ps_l100_phantom/ph02_05)
	(cs_fly_by ps_l100_phantom/ph02_erase)
	
	; erase phantom 
	(ai_erase ai_current_squad)
)

(script static void test_look_training
	(cinematic_snap_to_black)
	(sleep 1)
	
	(l100_look_training)
)