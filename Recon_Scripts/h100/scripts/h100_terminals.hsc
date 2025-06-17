; ===========================================================================================================================
; ================ HUB TERMINALS ============================================================================================
; ===========================================================================================================================
;*

ARG index values
game progression variable = gp_arg_index 


gp_circle1_arc1 = 1 
gp_circle1_arc2 = 2 
gp_circle1_arc3 = 3 

gp_circle2_arc1 = 4 
gp_circle2_arc2 = 5 
gp_circle2_arc3 = 6 

gp_circle3_arc1 = 7 
gp_circle3_arc2 = 8 
gp_circle3_arc3 = 9 

gp_circle4_arc1 = 10 
gp_circle4_arc2 = 11 
gp_circle4_arc3 = 12 

gp_circle5_arc1 = 13 
gp_circle5_arc2 = 14 
gp_circle5_arc3 = 15 

gp_circle6_arc1 = 16 
gp_circle6_arc2 = 17 
gp_circle6_arc3 = 18 

gp_circle7_arc1 = 19 
gp_circle7_arc2 = 20 
gp_circle7_arc3 = 21 

gp_circle8_arc1 = 22 
gp_circle8_arc2 = 23 
gp_circle8_arc3 = 24 

gp_circle9_arc1 = 25 
gp_circle9_arc2 = 26 
gp_circle9_arc3 = 27 
gp_circle9_arc4 = 28 
gp_circle9_arc5 = 29 
gp_circle9_arc6 = 30 

*;

(script dormant arg_main
		; main arg logic 
		; turns on arg elements based on what scene beacon the player has selected 
		
		; initialize markers 
		(arg_initialize_device_groups)
		
		; wake  arg markers 
		(wake arg_sc110_markers)
		
)

; ===========================================================================================================================
; ================ SC110 ELEMENTS ===========================================================================================
; ===========================================================================================================================

(script dormant arg_sc110_markers
	(if debug (print "activate temp pda beacons..."))

	(if (= (gp_boolean_get gp_sc110_complete) TRUE)
		; if scene has been completed turn on all markers that haven't been accessed 
		(begin
			(if (= (gp_boolean_get gp_sc110_terminal_01_complete) FALSE) (pda_activate_marker player arg_device_sc110_01 "arg_waypoints" TRUE))
			(if (= (gp_boolean_get gp_sc110_terminal_02_complete) FALSE) (pda_activate_marker player arg_device_sc110_02 "arg_waypoints" TRUE))
			(if (= (gp_boolean_get gp_sc110_terminal_03_complete) FALSE) (pda_activate_marker player arg_device_sc110_03 "arg_waypoints" TRUE))
			(if (= (gp_boolean_get gp_sc110_terminal_04_complete) FALSE) (pda_activate_marker player arg_device_sc110_04 "arg_waypoints" TRUE))
			(if (= (gp_boolean_get gp_sc110_terminal_05_complete) FALSE) (pda_activate_marker player arg_device_sc110_05 "arg_waypoints" TRUE))
			(if (= (gp_boolean_get gp_sc110_terminal_06_complete) FALSE) (pda_activate_marker player arg_device_sc110_06 "arg_waypoints" TRUE))
		)
		
		; otherwise turn markers on/off based on what scene beacon is selected 
		(sleep_until
			(begin	
	
				; sleep until beacon is selected then turn on markers for elements that have not been accessed 
				(sleep_until (pda_beacon_is_selected (player0) fl_beacon_sc110))
				
				(if (= (gp_boolean_get gp_sc110_terminal_01_complete) FALSE) (pda_activate_marker player arg_device_sc110_01 "arg_waypoints" TRUE))
				(if (= (gp_boolean_get gp_sc110_terminal_02_complete) FALSE) (pda_activate_marker player arg_device_sc110_02 "arg_waypoints" TRUE))
				(if (= (gp_boolean_get gp_sc110_terminal_03_complete) FALSE) (pda_activate_marker player arg_device_sc110_03 "arg_waypoints" TRUE))
				(if (= (gp_boolean_get gp_sc110_terminal_04_complete) FALSE) (pda_activate_marker player arg_device_sc110_04 "arg_waypoints" TRUE))
				(if (= (gp_boolean_get gp_sc110_terminal_05_complete) FALSE) (pda_activate_marker player arg_device_sc110_05 "arg_waypoints" TRUE))
				(if (= (gp_boolean_get gp_sc110_terminal_06_complete) FALSE) (pda_activate_marker player arg_device_sc110_06 "arg_waypoints" TRUE))
				
				; sleep until beacon is not selected then turn off markers 
				(sleep_until (not (pda_beacon_is_selected (player0) fl_beacon_sc110)))
				
				(pda_activate_marker player arg_device_sc110_01 "arg_waypoints" FALSE)
				(pda_activate_marker player arg_device_sc110_02 "arg_waypoints" FALSE)
				(pda_activate_marker player arg_device_sc110_03 "arg_waypoints" FALSE)
				(pda_activate_marker player arg_device_sc110_04 "arg_waypoints" FALSE)
				(pda_activate_marker player arg_device_sc110_05 "arg_waypoints" FALSE)
				(pda_activate_marker player arg_device_sc110_06 "arg_waypoints" FALSE)
	
			FALSE)
		1)
	)
)

; SC110 01 =========================================================
(script static void arg_sc110_01_tap
	(if debug (print "arg sc110 tap..."))
	(f_arg_accessed
					dg_arg_sc110_power_01
					gp_sc110_terminal_01_complete
					arg_device_sc110_01
	)
)

(script static void arg_sc110_01_hold
	(if debug (print "arg sc110 hold..."))
	(f_arg_accessed
					dg_arg_sc110_power_01
					gp_sc110_terminal_01_complete
					arg_device_sc110_01
	)
	
	; play arg element 
	(play_arg_element)
)
; SC110 02 =========================================================
(script static void arg_sc110_02_tap
	(if debug (print "arg sc110 tap..."))
	(f_arg_accessed
					dg_arg_sc110_power_02
					gp_sc110_terminal_02_complete
					arg_device_sc110_02
	)
)

(script static void arg_sc110_02_hold
	(if debug (print "arg sc110 hold..."))
	(f_arg_accessed
					dg_arg_sc110_power_02
					gp_sc110_terminal_02_complete
					arg_device_sc110_02
	)
	
	; play arg element 
	(play_arg_element)
)
; SC110 03 =========================================================
(script static void arg_sc110_03_tap
	(if debug (print "arg sc110 tap..."))
	(f_arg_accessed
					dg_arg_sc110_power_03
					gp_sc110_terminal_03_complete
					arg_device_sc110_03
	)
)

(script static void arg_sc110_03_hold
	(if debug (print "arg sc110 hold..."))
	(f_arg_accessed
					dg_arg_sc110_power_03
					gp_sc110_terminal_03_complete
					arg_device_sc110_03
	)
	
	; play arg element 
	(play_arg_element)
)
; SC110 04 =========================================================
(script static void arg_sc110_04_tap
	(if debug (print "arg sc110 tap..."))
	(f_arg_accessed
					dg_arg_sc110_power_04
					gp_sc110_terminal_04_complete
					arg_device_sc110_04
	)
)

(script static void arg_sc110_04_hold
	(if debug (print "arg sc110 hold..."))
	(f_arg_accessed
					dg_arg_sc110_power_04
					gp_sc110_terminal_04_complete
					arg_device_sc110_04
	)
	
	; play arg element 
	(play_arg_element)
)
; SC110 05 =========================================================
(script static void arg_sc110_05_tap
	(if debug (print "arg sc110 tap..."))
	(f_arg_accessed
					dg_arg_sc110_power_05
					gp_sc110_terminal_05_complete
					arg_device_sc110_05
	)
)

(script static void arg_sc110_05_hold
	(if debug (print "arg sc110 hold..."))
	(f_arg_accessed
					dg_arg_sc110_power_05
					gp_sc110_terminal_05_complete
					arg_device_sc110_05
	)
	
	; play arg element 
	(play_arg_element)
)
; SC110 06 =========================================================
(script static void arg_sc110_06_tap
	(if debug (print "arg sc110 tap..."))
	(f_arg_accessed
					dg_arg_sc110_power_06
					gp_sc110_terminal_06_complete
					arg_device_sc110_06
	)
)

(script static void arg_sc110_06_hold
	(if debug (print "arg sc110 hold..."))
	(f_arg_accessed
					dg_arg_sc110_power_06
					gp_sc110_terminal_06_complete
					arg_device_sc110_06
	)
	
	; play arg element 
	(play_arg_element)
)

; =============================================================================================================

(script static void (f_arg_accessed
									(device_group terminal_group)
									(string_id terminal_boolean)
									(object_name arg_device)
				)
	; turn off the power to associated devices 
	(device_group_set_immediate terminal_group 0)
	
	; turn off pda marker 
	(pda_activate_marker player arg_device "arg_waypoints" FALSE)
	
	; mark this terminal as accessed 
	(gp_boolean_set terminal_boolean TRUE)
	
	; increment the global ARG index 
	(gp_integer_set gp_arg_index (+ (gp_integer_get gp_arg_index) 1))
	
	; make sure everything registers 
	(sleep 1)
)

(script static void arg_initialize_device_groups
	; if you have accesse a terminal at any time in the past then turn off the power to the devices 

	; SC110 power groups 
	(if (= (gp_boolean_get gp_sc110_terminal_01_complete) TRUE) (device_group_set_immediate dg_arg_sc110_power_01 0))
	(if (= (gp_boolean_get gp_sc110_terminal_02_complete) TRUE) (device_group_set_immediate dg_arg_sc110_power_02 0))
	(if (= (gp_boolean_get gp_sc110_terminal_03_complete) TRUE) (device_group_set_immediate dg_arg_sc110_power_03 0))
	(if (= (gp_boolean_get gp_sc110_terminal_04_complete) TRUE) (device_group_set_immediate dg_arg_sc110_power_04 0))
	(if (= (gp_boolean_get gp_sc110_terminal_05_complete) TRUE) (device_group_set_immediate dg_arg_sc110_power_05 0))
	(if (= (gp_boolean_get gp_sc110_terminal_06_complete) TRUE) (device_group_set_immediate dg_arg_sc110_power_06 0))

	; SC120 power groups 
	(if (= (gp_boolean_get gp_sc120_terminal_01_complete) TRUE) (device_group_set_immediate dg_arg_sc120_power_01 0))
	(if (= (gp_boolean_get gp_sc120_terminal_02_complete) TRUE) (device_group_set_immediate dg_arg_sc120_power_02 0))
	(if (= (gp_boolean_get gp_sc120_terminal_03_complete) TRUE) (device_group_set_immediate dg_arg_sc120_power_03 0))
	(if (= (gp_boolean_get gp_sc120_terminal_04_complete) TRUE) (device_group_set_immediate dg_arg_sc120_power_04 0))
	(if (= (gp_boolean_get gp_sc120_terminal_05_complete) TRUE) (device_group_set_immediate dg_arg_sc120_power_05 0))
	(if (= (gp_boolean_get gp_sc120_terminal_06_complete) TRUE) (device_group_set_immediate dg_arg_sc120_power_06 0))
)

; ============================================================================================================
(script static void play_arg_element
	(if debug (print "play arg sound file..."))

	(cond
		((= (gp_integer_get gp_arg_index) 1)	(pda_play_arg_sound "gp_arg_slot_01"))
		((= (gp_integer_get gp_arg_index) 2)	(pda_play_arg_sound "gp_arg_slot_02"))
		((= (gp_integer_get gp_arg_index) 3)	(pda_play_arg_sound "gp_arg_slot_03"))
		
		((= (gp_integer_get gp_arg_index) 4)	(pda_play_arg_sound "gp_arg_slot_04"))
		((= (gp_integer_get gp_arg_index) 5)	(pda_play_arg_sound "gp_arg_slot_05"))
		((= (gp_integer_get gp_arg_index) 6)	(pda_play_arg_sound "gp_arg_slot_06"))
		
		((= (gp_integer_get gp_arg_index) 7)	(pda_play_arg_sound "gp_arg_slot_07"))
		((= (gp_integer_get gp_arg_index) 8)	(pda_play_arg_sound "gp_arg_slot_08"))
		((= (gp_integer_get gp_arg_index) 9)	(pda_play_arg_sound "gp_arg_slot_09"))
		
		((= (gp_integer_get gp_arg_index) 10)	(pda_play_arg_sound "gp_arg_slot_10"))
		((= (gp_integer_get gp_arg_index) 11)	(pda_play_arg_sound "gp_arg_slot_11"))
		((= (gp_integer_get gp_arg_index) 12)	(pda_play_arg_sound "gp_arg_slot_12"))
		
		((= (gp_integer_get gp_arg_index) 13)	(pda_play_arg_sound "gp_arg_slot_13"))
		((= (gp_integer_get gp_arg_index) 14)	(pda_play_arg_sound "gp_arg_slot_14"))
		((= (gp_integer_get gp_arg_index) 15)	(pda_play_arg_sound "gp_arg_slot_15"))
		
		((= (gp_integer_get gp_arg_index) 16)	(pda_play_arg_sound "gp_arg_slot_16"))
		((= (gp_integer_get gp_arg_index) 17)	(pda_play_arg_sound "gp_arg_slot_17"))
		((= (gp_integer_get gp_arg_index) 18)	(pda_play_arg_sound "gp_arg_slot_18"))
		
		((= (gp_integer_get gp_arg_index) 19)	(pda_play_arg_sound "gp_arg_slot_19"))
		((= (gp_integer_get gp_arg_index) 20)	(pda_play_arg_sound "gp_arg_slot_20"))
		((= (gp_integer_get gp_arg_index) 21)	(pda_play_arg_sound "gp_arg_slot_21"))
		
		((= (gp_integer_get gp_arg_index) 22)	(pda_play_arg_sound "gp_arg_slot_22"))
		((= (gp_integer_get gp_arg_index) 23)	(pda_play_arg_sound "gp_arg_slot_23"))
		((= (gp_integer_get gp_arg_index) 24)	(pda_play_arg_sound "gp_arg_slot_24"))
		
		((= (gp_integer_get gp_arg_index) 25)	(pda_play_arg_sound "gp_arg_slot_25"))
		((= (gp_integer_get gp_arg_index) 26)	(pda_play_arg_sound "gp_arg_slot_26"))
		((= (gp_integer_get gp_arg_index) 27)	(pda_play_arg_sound "gp_arg_slot_27"))
		((= (gp_integer_get gp_arg_index) 28)	(pda_play_arg_sound "gp_arg_slot_28"))
		((= (gp_integer_get gp_arg_index) 29)	(pda_play_arg_sound "gp_arg_slot_29"))
		((= (gp_integer_get gp_arg_index) 30)	(pda_play_arg_sound "gp_arg_slot_30"))
	)
)

