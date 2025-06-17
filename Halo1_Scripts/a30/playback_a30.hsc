; NOTE bug 889 FIX

;(script static void foehammer_river_pelican
	
;	(object_destroy foehammer_river)
;	(object_create foehammer_river)
;	(object_teleport foehammer_river v_foeham_river_drop_flag)
;	(recording_play foehammer_river vrec_foeham_river_pelican_in)
;	(sleep (recording_time foehammer_river))
;	(vehicle_hover foehammer_river 1)

; !!	wait for hog to drop
	
;	(print "marines pile out...")
;	(sleep 120)

;	(vehicle_hover foehammer_river 0)
;	(recording_play_and_delete foehammer_river vrec_foeham_river_pelican_exit)

;)

; NOTE bug 1935 FIX

(script static void banshee_1_fly
	
	(object_destroy pass_banshee_1)
	(object_create pass_banshee_1)
	(object_teleport pass_banshee_1 v_pass_banshee_1_flag)
	(recording_play pass_banshee_1 v_rec_pass_banshee_1_in)
	(sleep (recording_time pass_banshee_1))
	(vehicle_hover pass_banshee_1 1)
; !!	AI takes over flying
	
	(print "AI takes over flying...")
	(sleep 120)

)

(script static void banshee_2_fly
	
	(object_destroy pass_banshee_2)
	(object_create pass_banshee_2)
	(object_teleport pass_banshee_2 v_pass_banshee_2_flag)
	(recording_play pass_banshee_2 v_rec_pass_banshee_2_in)
	(sleep (recording_time pass_banshee_2))
	(vehicle_hover pass_banshee_2 1)
; !!	AI takes over flying
	
	(print "AI takes over flying...")
	(sleep 120)

)

; NOTE bug 2388 FIX

(script static void foehammer_rubble_pelican
	
	(object_destroy foehammer_rubble)
	(object_create foehammer_rubble)
	(object_teleport foehammer_rubble foehammer_rubble_flag)
	(recording_play_and_hover foehammer_rubble foehammer_rubble_in)
	(sleep (recording_time foehammer_rubble))
	(vehicle_hover foehammer_rubble 1)

; !!	wait for marines to pile in
	
	(print "marines pile in...")
	(sleep 120)

	(vehicle_hover foehammer_rubble 0)
	(recording_play_and_delete foehammer_rubble foehammer_rubble_out)
)

; NOTE bug 3188 FIX

(script static void v_first_foehammer
	(object_create foehammer_first)
	(object_teleport foehammer_first foehammer_first_flag)
	(recording_play_and_hover foehammer_first v_foehammer_first_in)
	(sleep (recording_time foehammer_first))

	(print "pelican drops hog...")
	(sleep 90)
	(vehicle_hover foehammer_first 0)

	(recording_play_and_hover foehammer_first v_foehammer_first_drop)
	(sleep (recording_time foehammer_first))

	(print "marines pile out...")
	(sleep 90)
	(vehicle_hover foehammer_first 0)

	(recording_play_and_delete foehammer_first v_foehammer_first_exit)
)
