;================================================================================================================================
;================================================= GLOBALS ======================================================================
;================================================================================================================================

(global short g_b1_obj_control 0)
(global short g_b2_obj_control 0)
(global short g_b3_obj_control 0)



;================================================================================================================================
;================================================= STARTUP ======================================================================
;================================================================================================================================

(script startup su_b1_startup
	(print "Banshee Run, Ahoy")
	
	;if survival_mode switch to appropriate scripts
	;(if (campaign_survival_enabled)
	;	(begin 
	;		(launch_survival_mode)
	;		(sleep_forever)
	;	)
	;)
	
	(gp_integer_set gp_current_scene 150)
	
	(wake sc_b1_objective_control)
	(wake sc_b1_ai_placement)
	
	(wake sc_b2_objective_control)
	(wake sc_b2_ai_placement)

	
	;hackery until we get the end of the level in
	(wake hack_end_mission)
	
		; set allegiances 
	(ai_allegiance covenant player)
	(ai_allegiance player covenant)
	(ai_allegiance human player)
	(ai_allegiance player human)
	(ai_allegiance covenant human)
	(ai_allegiance human covenant)
	
)

;================================================================================================================================
;================================================= MAIN =========================================================================
;================================================================================================================================


;=============================================== BASIN 1 ========================================================================
(script dormant sc_b1_objective_control

	(sleep_until (volume_test_players tv_b1_oc1) 1)
		(set g_b1_obj_control 1)
		(print "g_b1_obj_control set to 1")
		
	(sleep_until (volume_test_players tv_b1_oc2) 1)
		(set g_b1_obj_control 2)
		(print "g_b1_obj_control set to 2")
		(game_save)
		
	(sleep_until (volume_test_players tv_b1_oc3) 1)
		(set g_b1_obj_control 3)
		(print "g_b1_obj_control set to 3")
		
	(sleep_until (volume_test_players tv_b1_oc4) 1)
		(set g_b1_obj_control 4)
		(print "g_b1_obj_control set to 4")
		
	(sleep_until (volume_test_players tv_b1_oc5) 1)
		(set g_b1_obj_control 5)
		(print "g_b1_obj_control set to 5")
		(game_save)
		
	(sleep_until (volume_test_players tv_b1_oc6) 1)
		(set g_b1_obj_control 6)
		(print "g_b1_obj_control set to 6")

	(sleep_until (volume_test_players tv_b1_oc7) 1)
		(set g_b1_obj_control 7)
		(print "g_b1_obj_control set to 7")

	(sleep_until (volume_test_players tv_b1_oc8) 1)
		(set g_b1_obj_control 8)
		(print "g_b1_obj_control set to 8")

	(sleep_until (volume_test_players tv_b1_oc9) 1)
		(set g_b1_obj_control 9)
		(print "g_b1_obj_control set to 9")
		(game_save)

	(sleep_until (volume_test_players tv_b1_oc10) 1)
		(set g_b1_obj_control 10)
		(print "g_b1_obj_control set to 10")

	(sleep_until (volume_test_players tv_b1_oc11) 1)
		(set g_b1_obj_control 11)
		(print "g_b1_obj_control set to 11")

	(sleep_until (volume_test_players tv_b1_oc12) 1)
		(set g_b1_obj_control 12)
		(print "g_b1_obj_control set to 12")

	(sleep_until (volume_test_players tv_b1_oc13) 1)
		(set g_b1_obj_control 13)
		(print "g_b1_obj_control set to 13")

	(sleep_until (volume_test_players tv_b1_oc14) 1)
		(set g_b1_obj_control 14)
		(print "g_b1_obj_control set to 14")

	(sleep_until (volume_test_players tv_b1_oc15) 1)
		(set g_b1_obj_control 15)
		(print "g_b1_obj_control set to 15")
		(game_save)
)


(script dormant sc_b1_ai_placement
	(sleep_until (>= g_b1_obj_control 1))
		(ai_place phantom)
		(cs_run_command_script phantom/pilot human_phantom)
		(ai_place sq_b1_shade_05)

	(sleep_until (= g_b1_obj_control 2))
		(ai_place sq_b1_banshee_01)
		(cs_run_command_script sq_b1_banshee_01/b1_banshee_boost_a cs_b1_banshee_boost_a)
		(cs_run_command_script sq_b1_banshee_01/b1_banshee_boost_b cs_b1_banshee_boost_b)
		(cs_run_command_script sq_b1_banshee_01/b1_banshee_boost_c cs_b1_banshee_boost_c)
		
	(sleep_until (= g_b1_obj_control 4))
		(ai_place sq_b1_shade_01)
		(ai_place sq_b1_shade_02)
	
	(sleep_until (= g_b1_obj_control 6))
		(ai_place sq_b1_shade_03)
		(ai_place sq_b1_shade_04)
		
	(sleep_until (= g_b1_obj_control 7))
		(ai_place sq_b1_banshee_02)
		
	(sleep_until (= g_b1_obj_control 10))
		(ai_place sq_b1_banshee_03)
		(ai_place sq_b1_shade_06)
		(ai_place sq_b1_shade_07)
)

(script command_script human_phantom
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 0.5)
	(sleep_until (= g_b1_obj_control 2))
	(cs_fly_to_and_face phantom_path/p0 phantom_path/p1 2)
	(sleep_until (= g_b1_obj_control 3))
	(cs_fly_to_and_face phantom_path/p1 phantom_path/p2 2)
	(sleep_until
		(begin
			(= (ai_living_count sq_b1_banshee_01) 0)
		)
	)		 
	(cs_fly_to phantom_path/p2 2)
	(cs_fly_to phantom_path/p3 2)
	(cs_fly_to_and_face phantom_path/p4 phantom_path/p5 2)
	(sleep_until
		(begin
			(= (ai_living_count sq_b1_shade_01) 0)
		)
	)
	(cs_fly_to phantom_path/p5 2)
	(cs_fly_to phantom_path/p6 2)
	(sleep_until
		(begin
			(and
				(= (ai_living_count sq_b1_banshee_02) 0)
				(= (ai_living_count sq_b1_shade_03) 0)
			)
		)
	)
	(cs_fly_to phantom_path/p7 2)
	(cs_fly_to phantom_path/p8 2)
	(cs_fly_to phantom_path/p9 2)
	(sleep_until
		(begin
			(and
				(= (ai_living_count sq_b1_banshee_03) 0)
				(= (ai_living_count sq_b1_shade_06) 0)
			)
		)
	)
	(cs_fly_to phantom_path/p10 2)
	(cs_fly_to phantom_path/p11 2)
)

(script command_script cs_b1_banshee_boost_a
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_vehicle_boost TRUE)
	(cs_fly_to b1_banshee_boost_a/p0)
	(cs_fly_to b1_banshee_boost_a/p1)
	(cs_fly_to b1_banshee_boost_a/p2)
	(cs_fly_to b1_banshee_boost_a/p3)
	(cs_fly_to b1_banshee_boost_a/p4)
)

(script command_script cs_b1_banshee_boost_b
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_vehicle_boost TRUE)
	(cs_fly_to b1_banshee_boost_b/p0)
	(cs_fly_to b1_banshee_boost_b/p1)
	(cs_fly_to b1_banshee_boost_b/p2)
)

(script command_script cs_b1_banshee_boost_c
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_vehicle_boost TRUE)
	(cs_fly_to b1_banshee_boost_c/p0)
	(cs_fly_to b1_banshee_boost_c/p1)
	(cs_fly_to b1_banshee_boost_c/p2)
	(cs_fly_to b1_banshee_boost_c/p3)
	(cs_fly_to b1_banshee_boost_c/p4)
)

;============================================ BASIN 2 ============================================================================


(script dormant sc_b2_objective_control
	(sleep_until (volume_test_players tv_b2_oc1) 1)
		(set g_b2_obj_control 1)
		(print "g_b2_obj_control set to 1")
		
	(sleep_until (volume_test_players tv_b2_oc2) 1)
		(set g_b2_obj_control 2)
		(print "g_b2_obj_control set to 2")

	(sleep_until (volume_test_players tv_b2_oc3) 1)
		(set g_b2_obj_control 3)
		(print "g_b2_obj_control set to 3")

	(sleep_until (volume_test_players tv_b2_oc4) 1)
		(set g_b2_obj_control 4)
		(print "g_b2_obj_control set to 4")

	(sleep_until (volume_test_players tv_b2_oc5) 1)
		(set g_b2_obj_control 5)
		(print "g_b2_obj_control set to 5")

	(sleep_until (volume_test_players tv_b2_oc6) 1)
		(set g_b2_obj_control 6)
		(print "g_b2_obj_control set to 6")

	(sleep_until (volume_test_players tv_b2_oc7) 1)
		(set g_b2_obj_control 7)
		(print "g_b2_obj_control set to 7")

	(sleep_until (volume_test_players tv_b2_oc8) 1)
		(set g_b2_obj_control 8)
		(print "g_b2_obj_control set to 8")

	(sleep_until (volume_test_players tv_b2_oc9) 1)
		(set g_b2_obj_control 9)
		(print "g_b2_obj_control set to 9")

	(sleep_until (volume_test_players tv_b2_oc10) 1)
		(set g_b2_obj_control 10)
		(print "g_b2_obj_control set to 10")

	(sleep_until (volume_test_players tv_b2_oc11) 1)
		(set g_b2_obj_control 11)
		(print "g_b2_obj_control set to 11")

	(sleep_until (volume_test_players tv_b2_oc12) 1)
		(set g_b2_obj_control 12)
		(print "g_b2_obj_control set to 12")

	(sleep_until (volume_test_players tv_b2_oc13) 1)
		(set g_b2_obj_control 13)
		(print "g_b2_obj_control set to 13")

	(sleep_until (volume_test_players tv_b2_oc14) 1)
		(set g_b2_obj_control 14)
		(print "g_b2_obj_control set to 14")

	(sleep_until (volume_test_players tv_b2_oc15) 1)
		(set g_b2_obj_control 15)
		(print "g_b2_obj_control set to 15")

	(sleep_until (volume_test_players tv_b2_oc16) 1)
		(set g_b2_obj_control 16)
		(print "g_b2_obj_control set to 16")
)

(script dormant sc_b2_ai_placement
	(sleep_until
		(>= g_b2_obj_control 1))
			(ai_place sq_b2_banshee_01)
			(ai_place sq_b2_shade_01)
			(ai_place sq_b2_phantom_01)
	
	(sleep_until		
		(= g_b2_obj_control 2))
			(ai_place sq_b2_banshee_02)
)

(script command_script cs_b2_phantom_01
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_to b2_phantom_01/p0)
	(cs_fly_to b2_phantom_01/p1)
	(cs_fly_to b2_phantom_01/p2)
	(cs_fly_to b2_phantom_01/p3)
	(cs_fly_to b2_phantom_01/p4)
)

;================================================= HACKERY ====================================================================

;hack for Paul to end mission for progression globals
(script dormant hack_end_mission

	(sleep_until (volume_test_players tv_hack_end) 1)
		(gp_boolean_set gp_sc150_complete TRUE)
		(sleep 1)
		(end_scene)
)