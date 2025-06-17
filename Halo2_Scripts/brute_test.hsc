(global boolean a1_spawn true)

(script startup mission
	(game_can_use_flashlights TRUE)
	(wake First_Room)
	(wake Bridge)
	(wake mid_bridge)
;	(wake end_bridge)
	(wake Second_Room)
	
)

(script dormant First_Room
	(sleep_until (volume_test_objects a1_init (players)))

	(wake a1_backdoorvol)
	
	(ai_place grunts_ledge)
	(ai_set_objective grunts_ledge grunts_ledge_obj)	

	(ai_place brute_door)
	(ai_berserk brute_door FALSE)
;	(ai_set_objective brute_door firstroom)	
	(ai_set_task brute_door firstroom front_door)	
	
	(ai_place squad_left )
	(ai_set_task squad_left firstroom left_front)
;	(ai_set_objective squad_left firstroom)	


	(ai_place middle)
	(ai_berserk squad_middle/brute FALSE)		
	(ai_set_task middle firstroom mid_front)
;	(ai_set_objective middle firstroom)	


	(ai_place squad_right)
	(ai_set_task squad_right firstroom right_front)
;	(ai_set_objective squad_right firstroom)	

	
)

(script dormant Second_Room
	(sleep_until (volume_test_objects a3_init (players)))

	(print "hi")
	(ai_place a3_brute_01)
	(ai_set_task a3_brute_01 secondroom a3_brute01_init)
	(ai_place a3_grunts_01)
	
	(ai_place a3_uppergrunt_01)
	(ai_set_task a3_uppergrunt_01 secondroom a3_grunt_ledge01)
	
	(ai_place a3_uppergrunt_02)
	(ai_set_task a3_uppergrunt_02 secondroom a3_grunt_ledge02)
	
	(ai_place a3_uppergrunt_03)
	(ai_set_task a3_uppergrunt_03 secondroom a3_grunt_ledge03)
	
	(ai_place a3_uppergrunt_04)
	(ai_set_task a3_uppergrunt_04 secondroom a3_grunt_ledge04)

	(sleep_until (volume_test_objects hunters_backdoor (players)))

	(ai_place a3_hunters)
	(ai_set_task a3_hunters secondroom a3_hunters_obj)
	
)	
	

(script dormant Bridge

	(ai_place a2_Turret01)
	(ai_place a2_Turret02)
	(ai_place a2_Turret03)
	(ai_place a2_Turret04)	

	(sleep_until (volume_test_objects a2_init (players)))

	(ai_place a2_Grunts_01)	
	(ai_set_task a2_Grunts_01 bridge a2_grunts_asleep)
	
	(ai_place a2_Brute_01)	
	(ai_set_task a2_Brute_01 bridge a2_brute01_patrol)
	(ai_berserk a2_Brute_01 FALSE)		
	
	(ai_place a2_Jackals_01)	
	(ai_set_task a2_Jackals_01 bridge a2_jackals01_init)
	
)	

(script dormant mid_bridge
	(sleep_until (volume_test_objects mid_bridge_trig (players)))
	(ai_place a2_Grunts_02)
	(ai_set_task a2_Grunts_02 bridge a2_grunts02_turrets)
	
		
	(ai_place a2_Grunts_03)
	(ai_set_task a2_Grunts_03 bridge a2_grunts03_sleep)	
	
	(ai_place a2_Jackals_02)
	(ai_set_task a2_Jackals_02 bridge a2_jackals_02_init)
	
	(wake end_bridge)
	
)

(global boolean a_bridge_rein TRUE)

(script dormant end_bridge


	(sleep_until (or (and (= (ai_living_count a2_Grunts_01) 0)
					  (= (ai_living_count a2_Grunts_02) 0)
					  (= (ai_living_count a2_Grunts_03) 0)
					  (= (ai_living_count a2_Jackals_01) 0)
					  (= (ai_living_count a2_Jackals_02) 0)
					  (= (ai_living_count a2_Brute_01) 0))
				  (volume_test_objects end_bridge_trig (players))))
				  
	(ai_place a2_Brute_02)
	(ai_set_task a2_Brute_02 bridge a2_Brute_02_Init)


	(begin_random
		(if a_bridge_rein
			(begin 
				(ai_place a2_Grunts_04)
				(ai_set_task a2_Grunts_04 bridge a2_reinforcement_init)
				(set a_bridge_rein false)
			)
		)
		(if a_bridge_rein
			(begin 
				(ai_place a2_Jackals_03)
				(ai_set_task a2_Jackals_03 bridge a2_reinforcement_init)
			
				(set a_bridge_rein false)
			)
		)
	)

)

(script dormant a1_backdoorvol

	(sleep_until (volume_test_objects a1_backdoor (players)))
	
	(ai_place back_grunts)
	(ai_set_objective back_grunts firstroom)	
)


