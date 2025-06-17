; Scripts for Parade Ground

(script dormant start_obstacles
	; starts the characters running through the obstacle course
	(print "getting in warthog")
	(ai_vehicle_enter squad_A/elite_a test_hog warthog_d)
	(ai_vehicle_enter squad_A/elite_b test_hog warthog_p)
	(ai_vehicle_enter squad_A/elite_c test_hog warthog_g)
	(wake drive)
	
)

(script dormant drive
	
	; check to make sure elites are all in the hog before moving on

	(print "sleeping until elites are in warthog")
	(sleep_until 
		(and
			(!= (vehicle_driver test_hog) none)
			(!= (ai_vehicle_get squad_A/elite_b) none)
			(!= (ai_vehicle_get squad_A/elite_c) none)
		)
	)

	(print "waking up and activating driving script")
	(cs_queue_command_script squad_A/elite_a drive_to_waypoints)
	(cs_run_command_script squad_A/elite_b shoot_box)
	(cs_run_command_script squad_A/elite_c shoot_box)
)

(script command_script drive_to_waypoints
	(cs_enable_pathfinding_failsafe TRUE)
	(print "driving to waypoints")
	(sleep_until
		(begin
			(cs_go_to obstacle_points/point_1 .9)
			(cs_go_to obstacle_points/point_2)
			(cs_go_to obstacle_points/point_3)
			(cs_go_to obstacle_points/point_4)
			(cs_go_to obstacle_points/point_5)
			(cs_go_to obstacle_points/point_6)
			(cs_go_to obstacle_points/point_7)
			(cs_go_to obstacle_points/point_8)
		false
		)

	)
	(wake get_out)
)

(script command_script shoot_box
	(print "shooting at box")
	(cs_enable_targeting TRUE)
	(cs_aim_object TRUE target_box)
	(cs_shoot TRUE target_box)
	(sleep_until
		(= (ai_vehicle_get squad_A/elite_c) none)
	)
	(print "stop shooting at box")
)

(script dormant get_out
	(sleep_until (= (cs_moving) 0))
	(print "getting out")
	(vehicle_unload test_hog "")
)