;	NOTES
;
;	(object_destroy <name of object>)
;	(object_create <name of object>)
;	(object_teleport <name of object> <name of flag>)
;	(recording_play <name of object> <name of recording>)
;	(sleep (recording_time <name of object>))
;	(vehicle_hover <name of object> <1=start hover, 0=stop hover>)
;	(sleep <# of ticks, 30 per second>)
;	(print <"...">)
;	(game_speed <0-5>)

;	NOTES
;	the following section of the script is for
;	a50_vic.scenario

;(script static void pelican_energy_lift
	
;	(object_destroy pelican_energy)
;	(object_create pelican_energy)
;	(object_teleport pelican_energy v_flag_pel_1)
;	(recording_play pelican_energy v_rec_pel_1_in)
;	(sleep (recording_time pelican_energy))
;	(vehicle_hover pelican_energy 1)

; !!	wait for ai to exit
	
;	(print "marines pile out...")
;	(sleep 120)

;	(vehicle_hover pelican_energy 0)
;	(recording_play_and_delete pelican_energy v_rec_pel_1_out)
;)


;(script static void pelican_energy_lift_2
	
;	(object_destroy pelican_energy)
;	(object_create pelican_energy)
;	(object_teleport pelican_energy v_flag_pel_2)
;	(recording_play pelican_energy v_rec_pel_2_in)
;	(sleep (recording_time pelican_energy))
;	(vehicle_hover pelican_energy 1)

; !!	wait for ai to exit
	
;	(print "marines pile out...")
;	(sleep 120)

;	(vehicle_hover pelican_energy 0)
;	(recording_play_and_delete pelican_energy v_rec_pel_2_out)
;)
	
	
;(script static void c_dropship_energy_1
	
;	(object_destroy c_dropship_energy)
;	(object_create c_dropship_energy)
;	(object_teleport c_dropship_energy v_flag_c_dropship_1)
;	(recording_play c_dropship_energy v_rec_c_dropship_1_in)
;	(sleep (recording_time c_dropship_energy))
;	(vehicle_hover c_dropship_energy 1)

; !!	wait for ai to exit
	
;	(print "aliens pile out...")
;	(sleep 120)

;	(vehicle_hover c_dropship_energy 0)
;	(recording_play_and_delete c_dropship_energy v_rec_c_dropship_1_out)
;)

;(script static void pelican_energy_lift_3
	
;	(object_destroy pelican_energy)
;	(object_create pelican_energy)
;	(object_teleport pelican_energy v_flag_pel_3)
;	(recording_play pelican_energy v_rec_pel_3_in)
;	(sleep (recording_time pelican_energy))
;	(vehicle_hover pelican_energy 1)

; !!	wait for ai to exit
	
;	(print "marines pile out...")
;	(sleep 120)

;	(vehicle_hover pelican_energy 0)
;	(recording_play_and_delete pelican_energy v_rec_pel_3_out)
;)

;(script static void pelican_energy_lift_4
	
;	(object_destroy pelican_energy)
;	(object_create pelican_energy)
;	(object_teleport pelican_energy v_flag_pel_4)
;	(recording_play pelican_energy v_rec_pel_4_in)
;	(sleep (recording_time pelican_energy))
;	(vehicle_hover pelican_energy 1)
; !!	wait for ai to exit
	
;	(print "marines pile out...")
;	(sleep 120)

;	(vehicle_hover pelican_energy 0)
;	(recording_play_and_delete pelican_energy v_rec_pel_4_out)
;)

;(script static void c_dropship_energy_2
	
;	(object_destroy c_dropship_energy)
;	(object_create c_dropship_energy)
;	(object_teleport c_dropship_energy v_flag_c_dropship_2)
;	(recording_play c_dropship_energy v_rec_c_dropship_2_in)
;	(sleep (recording_time c_dropship_energy))
;	(vehicle_hover c_dropship_energy 1)

; !!	wait for ai to exit
	
;	(print "aliens pile out...")
;	(sleep 120)

;	(vehicle_hover c_dropship_energy 0)
;	(recording_play_and_delete c_dropship_energy v_rec_c_dropship_2_out)
;)


;	NOTES
;	the following section of the script is for
;	a50_vic2.scenario


(script static void c_dropship_hanger_1
	
	(object_destroy hangar_dropship_b)
	(object_create hangar_dropship_b)
	(object_teleport hangar_dropship_b v_flag_hangar_c_dropship_b)
	(recording_play hangar_dropship_b v_rec_hangar_c_dropship_b)
	(sleep (recording_time hangar_dropship_b))
	(vehicle_hover hangar_dropship_b 1)

; !! wait for ai to exit

	(print "alien dropship b has left the hangar")
	(sleep 120)
)

(script static void pelican_hangar_a
	
	(object_destroy hangar_pelican_a)
	(object_create hangar_pelican_a)
	(object_teleport hangar_pelican_a v_flag_hangar_pelican_a)
	(recording_play hangar_pelican_a v_rec_hangar_pelican_a_in)
	(sleep (recording_time hangar_pelican_a))
	(vehicle_hover hangar_pelican_a 1)
; !!	wait for ai to exit
	
	(print "marines pile in...")
	(sleep 120)

	(vehicle_hover hangar_pelican_a 0)
	(recording_play_and_delete hangar_pelican_a v_rec_hangar_pelican_a_out)
)
