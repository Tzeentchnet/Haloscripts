(global short VarSpawner 0)
(global boolean Verbose 0)

(script startup mission
	(wake Start_Battle)
	(ai_allegiance covenant prophet)
	(ai_allegiance human player)
	(wake Covenant_Reinforcements)
)

(script dormant Start_Battle
	(if (= Verbose 1) (print "Fight!!"))
	
	(ai_place Brute01 1)
	(ai_set_objective Brute01 covenant_objectives)
	(ai_place Jackal01 3)
	(ai_set_objective Jackal01 covenant_objectives)
	(ai_place Grunt01 3)
	(ai_set_objective Grunt01 covenant_objectives)

	(ai_place Brute02 2)
	(ai_set_objective Brute02 covenant_objectives)
	(ai_place Jackal02 3)
	(ai_set_objective Jackal02 covenant_objectives)
	(ai_place Grunt02 3)
	(ai_set_objective Grunt02 covenant_objectives)
	
	(ai_place Grunt03 3)
	(ai_set_objective Grunt03 covenant_objectives)
	(ai_place Brute03 1)
	(ai_set_objective Brute03 covenant_objectives)
	(ai_place Jackal03 3)
	(ai_set_objective Jackal03 covenant_objectives)
				
	(ai_place Brute04 3)
	(ai_set_objective Brute04 covenant_objectives)
	
	(ai_place Marine01 3)
	(ai_set_objective Marine01 marine_objectives)
	(ai_place Marine02 3)
	(ai_set_objective Marine02 marine_objectives)
	(ai_place Marine03 3)
	(ai_set_objective Marine03 marine_objectives)
	(ai_place Marine04 2)
	(ai_set_objective Marine04 marine_objectives)



	(ai_place Turret01)
	(ai_set_objective Turret01 covenant_objectives)
	
	(ai_place Turret02)
	(ai_set_objective Turret02 covenant_objectives)

	(ai_place Turret03)
	(ai_set_objective Turret03 covenant_objectives)
				
	
)

(script static boolean Left_Camp_Empty
	(>= (ai_body_count covenant_objectives/camp_left) 5)

)

(script static boolean Right_Camp_Empty
	(>= (ai_body_count covenant_objectives/camp_right) 5)
)

(script static boolean Underhang_Empty
	(AND
		(>= (ai_body_count covenant_objectives/underhang_right) 12)
		(>= (ai_body_count covenant_objectives/underhang_left) 10)

	)
)

(script static boolean Covenant_Underhang
	(NOT (volume_test_objects fall_back_vol01 (players)))
)


(script dormant Covenant_Reinforcements
	(sleep_until (<= (ai_living_count Covenant_Initial ) 15))
		(if (= Verbose 1) (print "COVENANT_REINFORCEMENTS!!"))
	(sleep_until
		(begin
			(sleep 30)
					
			(if (and (= VarSpawner 1) (< (ai_living_count Total_Covenant) 20))
				(begin		
					(ai_place Brute09 1)
					(ai_set_objective Brute09 covenant_objectives)
					(if (= Verbose 1) (print "SPAWNERMACHINE!!"))
				)
			)
			(if (and (= VarSpawner 2) (< (ai_living_count Total_Covenant) 20))
				(begin
					(ai_place Grunt07 1)
					(ai_set_objective Grunt07 covenant_objectives)
					(if (= Verbose 1) (print "SPAWNERMACHINE!!"))
				)
			)
			(if (and (= VarSpawner 3) (< (ai_living_count Total_Covenant) 20))
				(begin
					(ai_place Jackal07 1)
					(ai_set_objective Jackal07 covenant_objectives)
					(set VarSpawner 0)
					(if (= Verbose 1) (print "SPAWNERMACHINE!!"))
					
				)
			)		
			(set VarSpawner (+ VarSpawner 1))
			(>= (ai_spawn_count Total_Covenant) 60)				
		)
	)
)
