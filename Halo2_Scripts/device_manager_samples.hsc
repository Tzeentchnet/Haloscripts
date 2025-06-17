;----------------------------------------------------------------------
;----------------------------------------------------------------------
;THIS FIRST ONE IS THE KEY RIDE!!!
;----------------------------------------------------------------------
;----------------------------------------------------------------------

(script dormant key_main
	; For Joe
	(wake key_ride_door0_main)

	; When awakened, this script starts the key in the correct place and
	; drives it for the rest of the mission. Progress is inexorable--everything
	; adjusts to the omnipotent key. All fear the key! THE KEY WILL DESTROY YOU

	; Make it always active
	(pvs_set_object key)

	;- Horizontal Section ---------------------------------------
	
	; Start the sound
	(sound_looping_start "sound\ambience\device_machines\shq__key\shq__key" none 1.0)

	; Set the track and go
	(device_set_position_track key track_horiz0 0)
	
	; Get it to the initial position
	(device_animate_position key 0.3 0.0 0 0 false)
	(sleep 5)

	; Teleport the players onto the key 
	(object_teleport (player0) key_ent0)
	(object_teleport (player1) key_ent1)
	(sleep 5)

	; Begin the first leg, to the interior cruise
	(device_animate_position key 0.6 75 0 0 false)
	(set g_key_started true)
	
	; Sleep until the key is in position to begin opening the next door
	(sleep_until 
		(>= (device_get_position key) 0.35)
		3
	)

	; Begin opening the first door
	(wake key_ride_door0_main)

	; Sleep until the key is entering the first lock
	(sleep_until 
		(>= (device_get_position key) 0.4)
		3
	)
	(set g_key_lock0_first_loadpoint true)

	; Flag that we're entering the first lock
	(set g_key_lock0_entered true)
	
	; Sleep until the key is passing the first loading point
	(sleep_until 
		(>= (device_get_position key) 0.43)
		3
	)
	(set g_key_lock0_first_loadpoint true)
	
	; Sleep until the key is in position for a bsp swap
	(sleep_until 
		(>= (device_get_position key) 0.48)
		3
	)
	
	; Swap BSPs
	(switch_bsp_by_name sen_hq_bsp_6)
	
	; Sleep until the key is approaching the next load point
	(sleep_until 
		(>= (device_get_position key) 0.50)
		3
	)
	(set g_key_lock0_second_loadpoint true)
	
	; Sleep until we should start the Human key
	(sleep_until 
		(>= (device_get_position key) 0.50)
		3
	)
	(set g_key_lock0_begin_human true)
		
	; Sleep until the key is in position to begin opening the next door
	(sleep_until 
		(>= (device_get_position key) 0.53)
		3
	)
	(set g_key_lock0_door1 true)
	
	; Begin opening the door
	(wake key_ride_door1_main)

	; Sleep until the key is entering the interior cruise
	(sleep_until 
		(>= (device_get_position key) 0.58)
		3
	)
	(set g_key_cruise_entered true)
	
	; Accelerate
	(device_animate_position key 1.0 45 5 10 true)
	
	; Sleep until the key is near the first loadpoint, then the second
	(sleep_until 
		(>= (device_get_position key) 0.67)
		3
	)
	(set g_key_cruise_first_loadpoint true)
	(sleep_until 
		(>= (device_get_position key) 0.84)
		3
	)
	(set g_key_cruise_halfway true)
	
	; Sleep until the key is into the vertical rise
	(sleep_until 
		(>= (device_get_position key) 1.0)
		3
	)
	(set g_key_shaft_entered true)
	
	;- Vertical Section -----------------------------------------

	; Short pause
	(sleep 30)

	; Set the tracks and go
	(device_set_position_track key track_rise 0)
	(device_set_overlay_track key overlay_transform)
	
	; Start the alt track
	(sound_looping_set_alternate "sound\ambience\device_machines\shq__key\shq__key" true)

	; TRANSFORM AND ROLL OUT!!!1
	(device_animate_overlay key 1.0 5 0 0)
	(sleep 180)
	
	; Start it moving
	(device_animate_position key 1.0 90 20 10 false)	
	(set g_key_shaft_rising true)
	(set g_music_06b_06 1)

	; Sleep until the key is near the interior->exterior shaft transition
	(sleep_until 
		(>= (device_get_position key) 0.3)
		3
	)
	(set g_key_shaft_near_exterior true)

	; Sleep until the key is in position to begin opening the third door
	(sleep_until 
		(>= (device_get_position key) 0.73)
		3
	)

	; Begin opening the door
	(wake key_ride_door2_main)

	; Sleep until the key is in position to transform back
	(sleep_until 
		(>= (device_get_position key) 1.0)
		3
	)
	(set g_key_lock1_entered true)
	
	; Start the alt track
	(sound_looping_stop "sound\ambience\device_machines\shq__key\shq__key")

	;- Horizontal Section ---------------------------------------

	; Short pause
	(sleep 30)

	; Set the track and go
	(device_set_position_track key track_horiz1 0)
	
	; Start the sound
	(sound_looping_start "sound\ambience\device_machines\shq__key\shq__key" none 1.0)

	; TRANSFORM AND ROLL OUT!!!1
	(device_animate_overlay key 0.0 5 0 0)
	(sleep 180)
	
	; Start it moving
	(device_animate_position key 1.0 75 10 10 false)

	; Sleep until the key is near the first arch
	(sleep_until 
		(>= (device_get_position key) 0.15)
		3
	)
	(set g_key_lock1_first_arch true)
	
	; Sleep until the key is near the second arch
	(sleep_until 
		(>= (device_get_position key) 0.4)
		3
	)
	(set g_key_lock1_second_arch true)
	
	; Sleep until the key is in position to begin opening the last door
	(sleep_until 
		(>= (device_get_position key) 0.49)
		3
	)

	; Begin opening the door
	(wake key_ride_door3_main)

	; Sleep until the key is entering the library
	(sleep_until 
		(>= (device_get_position key) 0.65)
		3
	)
	(set g_key_library_entered true)

	; Sleep until the key is halfway in
	(sleep_until 
		(>= (device_get_position key) 0.85)
		3
	)
	
	; Begin tilting up the outriggers
	(device_animate_overlay key 1.0 5 0 0)

	; Ride it out
	(sleep_until 
		(>= (device_get_position key) 1.0)
		3
	)
	(set g_key_library_arrival true)
	(wake chapter_familiar)
	(wake sc_dock)
	(set g_music_06b_05 0)

	; Start the alt track
	(sound_looping_stop "sound\ambience\device_machines\shq__key\shq__key")
)

(script dormant key_ride_human_key_main
	; Do the exterior stuff
	
	; Sleep until the player is near the interior cruise
	(sleep_until g_key_lock0_begin_human 10)
	
	; Place the key, and move it into position
	(object_create_anew key_human)
	
	; Make it always active
	(pvs_set_object key_human)

	; Set the track and go
	(device_set_position_track key_human track_horiz0 0)
	
	; Get it to the initial position
	(device_animate_position key_human 0.58 0.5 0 0 false)
	(sleep 15)
	(device_animate_position key_human 1.0 55 5 10 false)

	; Sleep until the key is into the vertical rise
	(sleep_until 
		(>= (device_get_position key_human) 1.0)
		3
	)
	
	;- Vertical Section -----------------------------------------

	; Short pause
	(sleep 30)

	; Set the tracks and go
	(device_set_position_track key_human track_rise 0)
	(device_set_overlay_track key_human overlay_transform)
	
	; TRANSFORM AND ROLL OUT!!!1
	(device_animate_overlay key_human 1.0 5 0 0)
	(sleep 180)
	
	; Start it moving
	(device_animate_position key_human 1.0 80 20 10 false)	

	; Sleep until the key is in position to begin opening the door
	(sleep_until 
		(>= (device_get_position key_human) 0.71)
		3
	)

	; Begin opening the door
	(wake key_ride_human_door2_main)

	; Sleep until the key is in position to transform back
	(sleep_until 
		(>= (device_get_position key_human) 1.0)
		3
	)

	;- Horizontal Section ---------------------------------------

	; Short pause, let the other key catch up
	(sleep 120)

	; Set the track and go
	(device_set_position_track key_human track_horiz1 0)
	
	; TRANSFORM AND ROLL OUT!!!1
	(device_animate_overlay key_human 0.0 5 0 0)
	(sleep 180)
	
	; Start it moving
	(device_animate_position key_human 1.0 75 10 10 false)	

	; Sleep until the key is out of sight, and then end this charade
	(sleep_until 
		(>= (device_get_position key_human) 0.191)
		3
	)
	(object_destroy key_human)
	
	; Set the overlay of the docked key
	(object_create_anew key_docked)
	(sleep 1)
	(device_set_overlay_track key_docked overlay_transform)
	(device_animate_overlay key_docked 1.0 0.1 0 0)
)

;----------------------------------------------------------------------
;----------------------------------------------------------------------
;AND THIS ONE IS THE GASGIANT ELEVATOR!!!
;----------------------------------------------------------------------
;----------------------------------------------------------------------

;Scripts for controlling movement of elevator
(script static void silo_crane_01
	(device_set_overlay_track elev_silo crane_left)
	(device_animate_overlay elev_silo 1 30 1 1)
	(sleep 360)
	(object_destroy stop_01)
	(object_create_anew dummy_can)
	(objects_attach elev_silo can_entry dummy_can can_top)
	(sleep 285)
	(object_destroy dummy_can)
	(sleep 270)
)
(script static void silo_crane_02
	(device_set_overlay_track elev_silo crane_right)
	(device_animate_overlay elev_silo 1 30 1 1)
	(sleep 360)
	(object_destroy stop_02)
	(object_create_anew dummy_can)
	(objects_attach elev_silo can_entry dummy_can can_top)
	(sleep 285)
	(object_destroy dummy_can)
	(sleep 270)
)
(script static void silo_crane_03
	(device_set_overlay_track elev_silo crane_right)
	(device_animate_overlay elev_silo 1 30 1 1)
	(sleep 360)
	(object_destroy stop_03)
	(object_create_anew dummy_can)
	(objects_attach elev_silo can_entry dummy_can can_top)
	(sleep 285)
	(object_destroy dummy_can)
	(sleep 270)
)
(script static void silo_crane_04
	(device_set_overlay_track elev_silo crane_center)
	(device_animate_overlay elev_silo 1 18 1 1)
	(sleep 195)
	(object_destroy stop_04)
	(object_create_anew dummy_can)
	(objects_attach elev_silo can_entry dummy_can can_top)
	(sleep 255)
	(object_destroy dummy_can)
	(sleep 60)
)
(script static void silo_crane_05
	(device_set_overlay_track elev_silo crane_left)
	(device_animate_overlay elev_silo 1 30 1 1)
	(sleep 360)
	(object_destroy stop_05)
	(object_create_anew dummy_can)
	(objects_attach elev_silo can_entry dummy_can can_top)
	(sleep 285)
	(object_destroy dummy_can)
	(sleep 270)
)
(script static void silo_crane_06
	(device_set_overlay_track elev_silo crane_center)
	(device_animate_overlay elev_silo 1 18 1 1)
	(sleep 195)
	(object_destroy stop_06)
	(object_create_anew dummy_can)
	(objects_attach elev_silo can_entry dummy_can can_top)
	(sleep 255)
	(object_destroy dummy_can)
	(sleep 60)
)

(script static void silo_down_200
	(device_set_position_track elev_silo down_200 0)
	(device_animate_position elev_silo 1 5 1 1 FALSE)
)
(script static void silo_down_400
	(device_set_position_track elev_silo down_400 0)
	(device_animate_position elev_silo 1 10 1 1 FALSE)
)
(script static void silo_down_600
	(device_set_position_track elev_silo down_600 0)
	(device_animate_position elev_silo 1 15 1 1 FALSE)
)
(script static void silo_down_800
	(device_set_position_track elev_silo down_800 0)
	(device_animate_position elev_silo 1 20 1 1 FALSE)
)
(script static void silo_rot_90_plus
	(device_set_position_track elev_silo rot_90_clockwise 0)
	(device_animate_position elev_silo 1 5 1 1 FALSE)
)
(script static void silo_rot_90_minus
	(device_set_position_track elev_silo rot_90_counterclockwise 0)
	(device_animate_position elev_silo 1 5 1 1 FALSE)
)
(script static void silo_rot_180_plus
	(device_set_position_track elev_silo rot_180_clockwise 0)
	(device_animate_position elev_silo 1 10 1 1 FALSE)
)
(script static void silo_rot_180_minus
	(device_set_position_track elev_silo rot_180_counterclockwise 0)
	(device_animate_position elev_silo 1 10 1 1 FALSE)
)
(script static void silo_tray01
	(objects_attach elev_silo tray01 tray01 can_exit)
	(object_create can01)
	(objects_attach tray01 can_exit can01 can_base)
	(device_set_position tray01 1)
	(sleep_until (= (device_get_position tray01) 1) 30 900)
	(objects_detach tray01 can01)
	(device_set_position_immediate tray01 0)
	(object_destroy tray01)
)
(script static void silo_tray02
	(objects_attach elev_silo tray02 tray02 can_exit)
	(object_create can02)
	(objects_attach tray02 can_exit can02 can_base)
	(device_set_position tray02 1)
	(sleep_until (= (device_get_position tray02) 1) 30 300)
	(objects_detach tray02 can02)
	(device_set_position_immediate tray02 0)
	(object_destroy tray02)
)
(script static void silo_tray03
	(objects_attach elev_silo tray03 tray03 can_exit)
	(object_create can03)
	(objects_attach tray03 can_exit can03 can_base)
	(device_set_position tray03 1)
	(sleep_until (= (device_get_position tray03) 1) 30 300)
	(objects_detach tray03 can03)
	(device_set_position_immediate tray03 0)
	(object_destroy tray03)
)
(script static void silo_tray04
	(objects_attach elev_silo tray04 tray04 can_exit)
	(object_create can04)
	(objects_attach tray04 can_exit can04 can_base)
	(device_set_position tray04 1)
	(sleep_until (= (device_get_position tray04) 1) 30 300)
	(objects_detach tray04 can04)
	(device_set_position_immediate tray04 0)
	(object_destroy tray04)
)
(script static void silo_tray05
	(objects_attach elev_silo tray05 tray05 can_exit)
	(object_create can05)
	(objects_attach tray05 can_exit can05 can_base)
	(device_set_position tray05 1)
	(sleep_until (= (device_get_position tray05) 1) 30 300)
	(objects_detach tray05 can05)
	(device_set_position_immediate tray05 0)
	(object_destroy tray05)
)
(script static void silo_tray06
	(objects_attach elev_silo tray06 tray06 can_exit)
	(object_create can06)
	(objects_attach tray06 can_exit can06 can_base)
	(device_set_position tray06 1)
	(sleep_until (= (device_get_position tray06) 1) 30 300)
	(objects_detach tray06 can06)
	(device_set_position_immediate tray06 0)
	(object_destroy tray06)
)

;Moves the elevator and its associated parts
(script dormant elev_go

	(silo_crane_01)
	(silo_tray01)
	(sleep 30)
	
	(sleep_until 
		(AND
			(= (volume_test_objects_all vol_specimen_storage (players)) TRUE)
			(> (player_count) 0)
		)
	)
	(print "down 400")
	
	(wake silo_saving)
	(wake music_04b_02_stop)
	
	(silo_down_400)
	(sleep 300)
	;(wake silo_infection_rain_01)
	
	(silo_rot_90_plus)
	(sleep 150)
	
	(silo_crane_02)
	(silo_tray02)
	(sleep 30)

	(sleep_until 
		(AND
			(= (volume_test_objects_all vol_specimen_storage (players)) TRUE)
			(> (player_count) 0)
		)
	30 300)
	(print "down 600")
	(silo_down_600)
	(sleep 450)
	;(sleep_forever silo_infection_rain_01)
	;(set silo_sentinels_total 10)
	;(set silo_flood_total 10)
	;(wake silo_infection_rain_02)
	
	(silo_rot_90_minus)
	(sleep 150)

	(silo_crane_03)
	(silo_tray03)
	(sleep 30)
	
	(data_mine_set_mission_segment "04b_4_silo_mid")
	(set silo_try_save TRUE)

	;(wake silo_infection_rain_02)
	;(set silo_flood_total 0)

	(sleep_until 
		(AND
			(= (volume_test_objects_all vol_specimen_storage (players)) TRUE)
			(> (player_count) 0)
		)
	30 300)
	(print "down 200")

	(wake music_04b_01_stop)

	(silo_down_200)
	(sleep 150)
	(ai_place silo_sentinels_below 4)

	(silo_rot_90_plus)
	(sleep 150)

	(silo_crane_04)
	(silo_tray04)
	(sleep 30)

	(sleep_until 
		(AND
			(= (volume_test_objects_all vol_specimen_storage (players)) TRUE)
			(> (player_count) 0)
		)
	30 300)
	(print "down 800 - kill disabled")
	(kill_volume_disable kill_silo_toggle)
		
	(silo_down_800)
	(sleep 600)
	;(sleep_forever silo_infection_rain_02)
	;(wake silo_infection_rain_03)
	
	(silo_rot_180_minus)
	(sleep 300)
	
	(silo_crane_05)
	(silo_tray05)
	(sleep 30)

	(sleep_until 
		(AND
			(= (volume_test_objects_all vol_specimen_storage (players)) TRUE)
			(> (player_count) 0)
		)
	30 300)
;	(set silo_sentinels_total 0)
	(print "down 400")
	(silo_down_400)
	(sleep 300)

	(silo_rot_90_plus)
	(sleep 150)

	(silo_crane_06)
	(silo_tray06)
	(sleep 30)

	(sleep_until 
		(AND
			(= (volume_test_objects_all vol_specimen_storage (players)) TRUE)
			(> (player_count) 0)
		)
	30 300)
	(set silo_almost_there TRUE)
	(print "down 600")
	(silo_down_600)
	(sleep 300)
	;(sleep_forever silo_infection_rain_03)
	;(wake silo_infection_rain_04)
;	(set silo_almost_there TRUE)
	(sleep 150)
)