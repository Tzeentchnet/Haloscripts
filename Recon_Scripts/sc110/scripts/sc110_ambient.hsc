(script startup sc110_ambient_stub
	(if debug (print "sc110 ambient stub"))
)

;* temp script for 7/7 presentation

(script dormant sc110_presentation_cinematic

	(print "7/7 presentation cinematic")
	(sound_class_set_gain device 0 0)
	(cinematic_snap_to_black)
	
	(sleep 5)

	(player_enable_input TRUE)
	(player_action_test_reset)
	(sleep_until (player_action_test_accept) 1)
	
	(sound_looping_start sound\music\cpaul\dark_pedal_pulse\dark_pedal_pulse NONE 1)
                
	(game_level_prepare sc130)
	
	(cinematic_set_title title_1)
	(sleep 60)
	(cinematic_set_title title_2)
	(sleep 90)

	(camera_set_field_of_view 80 0)
	(camera_set cam_1 0)
	(camera_set cam_2 200)
	(sleep 90)
	(fade_in 0 0 0 45)
	(sleep 10)
	(camera_set cam_3 300)
	(sleep 150)
	(camera_set cam_4 300)
	(sleep 150)
	(camera_set cam_5 300)
	(sleep 150)
;	(camera_set cam_6 300)
;	(sleep 150)
;	(camera_set cam_7 300)
;	(sleep 150)
;	(camera_set cam_8 300)
;	(sleep 150)
	(camera_set cam_9 450)
	(sleep 350)
	(camera_set cam_10 300)
	(sleep 150)
	(camera_set cam_11 300)
	(sleep 300)
	
	(cinematic_fade_to_gameplay)
	
	(sound_looping_stop sound\music\cpaul\dark_pedal_pulse\dark_pedal_pulse)
	(sound_class_set_gain device 1 15)
	(set g_presentation 1)

	(ai_dialogue_enable FALSE)
	
	(sleep_until (volume_test_players tv_bday) 1)	
	(cinematic_fade_to_black)
	
	(ai_dialogue_enable TRUE)
	
	(game_level_advance sc130)
)*;
