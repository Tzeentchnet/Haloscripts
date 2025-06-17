(global boolean hallway false)

(script startup mission
	
	(print "startup!")
	(ai_place cov_Init 5)
	(ai_set_objective cov_Init main_objective)
	(ai_place cov_Enc02a 5)
	(ai_set_objective cov_Enc02a main_objective)

	
;	(wake HallwayTrig)
	(wake JackalTrig)
	(wake BruteTrig)

)


(script dormant JackalTrig
	(sleep_until (volume_test_objects jackal_trig (players)) 5)
	(ai_place cov_Enc02b 3)
	(ai_set_task cov_Enc02b main_objective encounter02b_init)
)

(script dormant BruteTrig
	(sleep_until (OR (volume_test_objects brute_trig02 (players)) (<= (ai_living_count group_cov_init) 1))5)
	(ai_place cov_Brute02 3)
	(ai_set_objective cov_Brute02 main_objective)		
)

(script static boolean init_fall_back
	(<= (ai_strength cov_Init) 0.75)
)

(script static boolean enc02a_fall_back
	(<= (ai_strength cov_Enc02a) 0.75)
)

(script static boolean enc02b_fall_back
	(<= (ai_strength cov_Enc02b) 0.75)
)

(script static boolean brute02_fall_back
	(<= (ai_strength cov_Brute02) 0.75)
)

