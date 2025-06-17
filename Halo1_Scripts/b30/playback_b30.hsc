; NOTE bug 518 FIX

(script static void shafta_cship_exit
	
	(object_destroy shafta_cship)
	(object_create shafta_cship)
	(object_teleport shafta_cship v_shafta_cship_flag)
	(recording_play shafta_cship v_rec_shafta_cship_exit)
	(sleep (recording_time shafta_cship))
	(vehicle_hover shafta_cship 1)
	
; !!	shafta_cship leaves area
	
	(print "shafta_cship goes away")
	(object_destroy shafta_cship)
	
)

; NOTE bug 594 FIX

;(script static void shafta_inv_cship_exit
	
;	(object_destroy shafta_inv_cship)
;	(object_create shafta_inv_cship)
;	(object_teleport shafta_inv_cship v_shaftA_inv_cship_flag)
;	(recording_play shafta_inv_cship v_rec_shafta_inv_cship_exit)
;	(sleep (recording_time shafta_inv_cship))
;	(vehicle_hover shafta_inv_cship 1)
	
; !!	shafta_inv_cship leaves area
	
;	(print "shafta_inv_cship goes away")
;	(object_destroy shafta_inv_cship)
	
;)

; NOTE bug 567 FIX

(script static void hog_pelican_drop
	
	(object_destroy hog_pelican)
	(object_create hog_pelican)
	(object_teleport hog_pelican v_hog_pelican_flag_1)
	(recording_play hog_pelican v_rec_hog_pelican_in)
	(sleep (recording_time hog_pelican))
	(vehicle_hover hog_pelican 1)

; !!	wait for hog to drop
	
	(print "pelican drops hog...")
	(sleep 120)

	(vehicle_hover hog_pelican 0)
	(recording_play_and_delete hog_pelican v_rec_hog_pelican_exit)

)
