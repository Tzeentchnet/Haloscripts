; NOTE bug 3655 FIX

(script static void midcliff_1_cship
	
	(object_destroy v_midcliff_1_cship)
	(object_create v_midcliff_1_cship)
	(object_teleport v_midcliff_1_cship v_midcliff_1_flag)
	(recording_play v_midcliff_1_cship vrec_midcliff_1_cship_exit)
	(sleep (recording_time v_midcliff_1_cship))
	(vehicle_hover v_midcliff_1_cship 1)
	
	(print "midcliff_1_cship goes away")
	(object_destroy v_midcliff_1_cship)
)

(script static void midcliff_2_cship
	
	(object_destroy v_midcliff_2_cship)
	(object_create v_midcliff_2_cship)
	(object_teleport v_midcliff_2_cship v_midcliff_2_flag)
	(recording_play v_midcliff_2_cship vrec_midcliff_2_cship_exit)
	(sleep (recording_time v_midcliff_2_cship))
	(vehicle_hover v_midcliff_2_cship 1)
	
	(print "midcliff_2_cship goes away")
	(object_destroy v_midcliff_2_cship)
)

(script static void midriver_1_cship
	
	(object_destroy v_midriver_1_cship)
	(object_create v_midriver_1_cship)
	(object_teleport v_midriver_1_cship v_midriver_1_flag)
	(recording_play v_midriver_1_cship vrec_midriver_1_cship_exit)
	(sleep (recording_time v_midriver_1_cship))
	(vehicle_hover v_midriver_1_cship 1)
	
	(print "midriver_1_cship goes away")
	(object_destroy v_midriver_1_cship)
)

(script static void midrubble_1_cship
	
	(object_destroy v_midrubble_1_cship)
	(object_create v_midrubble_1_cship)
	(object_teleport v_midrubble_1_cship v_midrubble_1_flag)
	(recording_play v_midrubble_1_cship vrec_midrubble_1_cship_exit)
	(sleep (recording_time v_midrubble_1_cship))
	(vehicle_hover v_midrubble_1_cship 1)
	
	(print "v_midrubble_1_cship goes away")
	(object_destroy v_midrubble_1_cship)
)
