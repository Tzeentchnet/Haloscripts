; temp script for 7/7 presentation
;*
(script dormant l200_presentation_intro


	(cinematic_snap_to_black)
	
	(sleep 5)
	(player_enable_input TRUE)
	(player_action_test_reset)
	(sleep_until (player_action_test_accept) 1)
	
	(sound_looping_start sound\music\cpaul\dissonant_amb2\dissonant_amb2 NONE 1)	

	(sleep 60)
	(cinematic_set_title title_1)
	(sleep 60)
	(cinematic_set_title title_2)
	(sleep 180)
	
	(cinematic_fade_to_gameplay)
	
	(sleep_until (volume_test_players tv_camera_track1) 1)

	(cinematic_fade_to_black)
	
	(ai_place odst)

	(camera_set_field_of_view 80 0)
	(camera_set cam_1 0)
	(camera_set cam_2 200)
	(sleep 15)
	(fade_in 0 0 0 45)
	(sleep 10)
	(camera_set cam_3 300)
	(sleep 100)
	(camera_set cam_4 300)
	(sleep 100)
	(camera_set cam_5 300)
	(sleep 100)
	(camera_set cam_6 300)
	(sleep 100)
	(camera_set cam_7 300)
	(sleep 100)
	(camera_set cam_8 300)
	(sleep 100)
	(camera_set cam_9 200)
	(sleep 100)
	(camera_set cam_10 200)
	(sleep 200)
             
	(cinematic_fade_to_black)
	
	(object_teleport (player0) fl_player0)
	
	(cinematic_fade_to_gameplay)

)
