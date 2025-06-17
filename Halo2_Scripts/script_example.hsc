(global boolean debug 1)
(global boolean start 0)

;---------------------------------------------------------------------;
;-------------           INFILTRATE THE BEACH            -------------;
;---------------------------------------------------------------------;

(script dormant stealth_insertion
	(ai_place A_elite_0 2)
	(ai_place A_jackal_0 2)
	(ai_place A_grunt_0 4)
	
	;Wait until the player goes on section B, or until he killed most 
	;of the covenant defense
	(sleep_until
		(OR
			(= (volume_test_objects vol_a_1 (players)) TRUE)
			(= (volume_test_objects vol_b (players)) TRUE)
			;If the covenants are aware of MC and are weakened
			(AND
				(< (ai_strength cov_a) 0.7)
				(> (ai_combat_status cov_a) 1)
			)
		)
	)
	
	;Retreat the covenants to the beach entrance
	(cs_run_command_script cov_a cs_exit)
	(ai_set_orders cov_a B_cov_0)
	(ai_place B_hunter_0 2)
	(game_save)
	
	;Wait until the hunters are dead, or until the player is in section C
	(sleep_until
		(OR
			(AND
				(= (volume_test_objects vol_c (players)) TRUE)
				(= (volume_test_objects vol_b (players)) FALSE)
			)
			(= (ai_living_count B_hunter_0) 0)
		)
	)
	
	;Migrate the troops MC didn't kill to the next phase. 
	(if (> (+ (ai_living_count cov_a) (ai_living_count cov_b)) 0)
		(begin
			(ai_migrate B_hunter_0 G_cov_defender_0)
			;(ai_migrate A_elite_0 E_cov_defender_0)
			;(if (= (ai_living_count E_cov_defender_0) 0)
			;	(ai_migrate A_jackal_0 E_cov_defender_0)
			;	(ai_migrate A_jackal_0 D_cov_defender_0)
			;)
			(ai_migrate A_elite_0 D_cov_defender_0)
			(ai_migrate A_jackal_0 D_cov_defender_0)
			(ai_migrate A_grunt_0 D_cov_defender_0)
		)
	)
	
	(game_save)
	;Start the next phase
	(wake disable_base_power)
)

;---------------------------------------------------------------------;
;-------------    DESTROY THE THREE BASE GENERATORS      -------------;
;---------------------------------------------------------------------;

(global boolean var_generators_down FALSE)
(script dormant disable_base_power
	;Wake up the defensive threads
	(wake defend_D)
	(wake defend_E)
	(wake defend_G)
	(wake part_2_display_nav_points)
	
	(wake ghost_combat)
		
	;*(if (< (ai_living_count all_cov) 11)
		(begin
			(ai_place F_cov_defender_guns 2)
			(ai_place F_cov_defender_0 1)
			(ai_place F_cov_defender_1 1)			
		)
	)*;
	
	(wake gen_defenders_actions)
	
	;Wait for the three generator to be down
	(sleep_until
		(AND
			(<= (object_get_health generator_D) 0)
			(<= (object_get_health generator_E) 0)
			(<= (object_get_health generator_G) 0)
		)
	)
	(set var_generators_down TRUE)
	(print "ALL THREE GENERATORS DOWN!")
	
	(sleep_forever part_2_display_nav_points)
			
	;Launch the next phase
	(wake assault_base)
)

(script dormant base_shields_flicker
	(sleep_until
		(begin
			(device_set_position hall_shield_0 0)
			(device_set_position hall_shield_1 0)
			(device_set_position hall_shield_2 0)
			(device_set_position hall_shield_3 0)
			(device_set_position hall_shield_4 0)
			(device_set_position hall_shield_5 0)
			(device_set_position hall_shield_6 0)
			(sleep (random_range 0 5))
			(device_set_position hall_shield_0 1)
			(device_set_position hall_shield_1 1)
			(device_set_position hall_shield_2 1)
			(device_set_position hall_shield_3 1)
			(device_set_position hall_shield_4 1)
			(device_set_position hall_shield_5 1)
			(device_set_position hall_shield_6 1)
			(sleep (random_range 0 30))
		0)
	)
)

(global boolean var_gen_D_down FALSE)
(global boolean var_gen_E_down FALSE)
(global boolean var_gen_G_down FALSE)
(global boolean var_gen_got_destroyed FALSE)

;Place a nav point on each intact generator after a certain time
(script dormant part_2_display_nav_points
	(sleep_until
		(begin
			(sleep 3000)
			(if (AND (<= (object_get_health generator_D) 0) (= var_gen_D_down FALSE))
				(begin 
					(set var_gen_got_destroyed TRUE)
					(set var_gen_D_down TRUE)
				)
			)
			(if (AND (<= (object_get_health generator_E) 0) (= var_gen_E_down FALSE))
				(begin 
					(set var_gen_got_destroyed TRUE)
					(set var_gen_E_down TRUE)
				)
			)
			(if (AND (<= (object_get_health generator_G) 0) (= var_gen_G_down FALSE))
				(begin 
					(set var_gen_got_destroyed TRUE)
					(set var_gen_G_down TRUE)
				)
			)

			;No relay got destroyed -> mark relays that are still up
			(if (= var_gen_got_destroyed FALSE)
				(begin
					(if (= var_gen_D_down FALSE)
						(activate_team_nav_point_object default player generator_D 0)
					)
					(if (= var_gen_E_down FALSE)
						(activate_team_nav_point_object default player generator_E 0)
					)
					(if (= var_gen_G_down FALSE)
						(activate_team_nav_point_object default player generator_G 0)
					)
					(print "CORTANA: Chief, you must destroy the generators. Look for the light beams!")
				)
			)
			(set var_gen_got_destroyed FALSE)
		0)
	)
)

(script dormant ghost_combat
	;Ghost combat
	(ai_place C_cov_ghost_0 2)
	
	(sleep_until (= (ai_living_count C_cov_ghost_0) 0))
	(game_save)
)

(script dormant defend_D
	;Spawn defenders if they were not migrated from last phase
	(ai_place D_cov_defender_0 (- 4 (ai_living_count D_cov_defender_0)))
	
	(sleep_until
		(OR
			(< (object_get_health generator_D) 0.9)
			(< (ai_strength D_cov_defender_0) 0.6)
		)
	)
	(ai_set_orders D_cov_defender_0 C_cov_1)
	
	;When the defenders are dead, and a player is in the zone
	(sleep_until
		(AND
			(= (volume_test_objects vol_d_start (players)) TRUE)
			(OR
				(= (ai_living_count D_cov_defender_0) 0)
				(<= (object_get_health generator_D) 0)
			)
		)
	)
		
	;Create another wave of defenders if the relay is not already down
	(if (> (object_get_health generator_D) 0)
		(if (= (volume_test_objects vol_c (players)) TRUE)
			(ai_place C_cov_spectre_0)
			(if (= (volume_test_objects vol_D (players)) TRUE)
				(ai_place C_cov_spectre_1)
			)
		)
	)
	
	(ai_set_orders D_cov_defender_0 D_cov_0)
	
	(sleep_until
;		(OR
;			(<= (object_get_health generator_D) 0)
			(AND
				(< (ai_living_count C_cov_spectre) 2)
				(< (ai_living_count D_cov_defender_0) 2)
			)
;		)
	)
	
	(game_save)
	;Call in reinforcement in phantom
	(print "Generator D ready to send phantom")
	(sleep_until (= var_gen_def_active	FALSE))
	(set var_zone_to_defend vol_d_def)
	(set var_gen_to_defend generator_d)
	(set var_defending_order D_cov_def_0)
	(set var_dropping_path cs_gen_def_phantom_D)
	(ai_place gen_def_phantom_C 1)
	(ai_migrate gen_def_phantom_C gen_def_phantom)
	(gen_def_start_dropping)
	
	;Lure the player to generator G after this encounter
	(if  (AND
			(< (ai_living_count all_cov) 11)
			(OR
				(= (volume_test_objects vol_c_left (players)) TRUE)
				(= (volume_test_objects vol_d (players)) TRUE)
			)
		)
		(begin
			(ai_place G_cov_jackal_0 2)
			(sleep_until (< (ai_strength G_cov_jackal_0) 0.8))
			(ai_set_orders G_cov_jackal_0 G_cov_1)
		)
	)
)

(script dormant defend_E
	(sleep_until (= (volume_test_objects vol_e (players)) TRUE))
	;Spawn defenders if they are not enough covenants in section C
	;(should happen most of the times)
	(if (< (ai_living_count D_cov_defender_0) 4)
		(ai_place E_cov_defender_0 (- 4 (ai_living_count E_cov_defender_0)))
		;else migrate the covenants from C to defend section E
		(ai_migrate D_cov_defender_0 E_cov_defender_0)
	)

	(sleep_until
		(OR
			(< (object_get_health generator_E) 0.5)
			(< (ai_strength E_cov_defender_0) 0.5)
		)
	)
	
	;Rush in to defend the generator
	(ai_set_orders E_cov_defender_0 E_cov_1)
	
	(sleep_until 
		;(OR
			(<= (ai_living_count E_cov_defender_0) 1)
		;	(<= (object_get_health generator_E) 0)
		;)
	)
	
	(game_save)
	;Call in reinforcement in phantom
	(print "Generator E ready to send phantom")
	(sleep_until (= var_gen_def_active	FALSE))
	(set var_zone_to_defend vol_e)
	(set var_gen_to_defend generator_e)
	(set var_defending_order E_cov_def_0)
	(set var_dropping_path cs_gen_def_phantom_E)
	(ai_place gen_def_phantom_B 1)
	(ai_migrate gen_def_phantom_B gen_def_phantom)
	(gen_def_start_dropping)
)

(script dormant defend_G
	(sleep_until (= (volume_test_objects vol_g (players)) TRUE))
	;Spawn defenders if they were not migrated from last phase
	(if (= (ai_living_count G_cov_defender_0) 0)
		(ai_place G_cov_defender_0 2)
	)

	(sleep_until 
		;(OR
			(= (ai_living_count G_cov_defender_0) 0)
		;	(<= (object_get_health generator_G) 0)
		;)
	)
	
	(game_save)
	;Call in reinforcement in phantom
	(print "Generator G ready to send phantom")
	(sleep_until (= var_gen_def_active	FALSE))
	(set var_zone_to_defend vol_g)
	(set var_gen_to_defend generator_g)
	(set var_defending_order G_cov_def_0)
	(set var_dropping_path cs_gen_def_phantom_G)
	(ai_place gen_def_phantom_I 1)
	(ai_migrate gen_def_phantom_I gen_def_phantom)
	(gen_def_start_dropping)
)

(global boolean var_gen_def_active FALSE)
(global boolean var_phantom_on_map FALSE)
(global short var_nb_drops 0)
(global object var_gen_to_defend generator_D)
(global trigger_volume var_zone_to_defend vol_d)
(global ai_orders var_defending_order D_cov_def_0)
(global ai_command_script var_dropping_path cs_gen_def_phantom_D)

(script static void gen_def_start_dropping
	(set var_nb_drops (+ var_nb_drops 1))
	
	;If there is already too much troops spawned, skip that covenant drop
	(if (< (ai_living_count all_cov) 11)
		(begin
			(print "Phantom: beginning the droping process...")
			(set var_gen_def_active TRUE)
			;Spawn the troops
			(if (< var_nb_drops 3)
				(begin
					(print "Phantom: spawning elites and grunts")
					(ai_place gen_def_phantom_elite 2)
					(sleep 15)
					(ai_place gen_def_phantom_grunt (min (- 11 (ai_living_count all_cov)) 3))
				)
				(begin
					(print "Phantom: spawning brutes and grunts")
					(ai_place gen_def_phantom_brute (min (- 11 (ai_living_count all_cov)) 3))
					(sleep 15)
					(ai_place gen_def_phantom_grunt (min (- 11 (ai_living_count all_cov)) 3))
				)
			)
			
			(sleep 15)
				
			(vehicle_load_magic (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p_c" (ai_actors gen_def_phantom_elite))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p_c" (ai_actors gen_def_phantom_brute))
			(vehicle_load_magic (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p" (ai_actors gen_def_phantom_grunt))
						
			(cs_run_command_script gen_def_phantom/pilot var_dropping_path)
			
			(sleep_until   
				(AND
					(< (ai_living_count gen_defenders) 2)
					(= var_phantom_on_map FALSE)
				)
			)
			;The defenders are weakened, another phantom can drop troops
			(set var_gen_def_active FALSE)
			(game_save_no_timeout)
			(print "Phantom: Finished the dropping process")
		)
		(print "Phantom: Not dropping troops, too much ennemies on the map")
	)
)

(global boolean var_gen_def_following FALSE)
;Manage the dynamic defenders' actions
(script dormant gen_defenders_actions
	(sleep_until
		(begin
			;If no player are in the zone to defend, or if the generator is destroyed
			(if  (OR
					(<= (object_get_health var_gen_to_defend) 0)
					(= (volume_test_objects var_zone_to_defend (players)) FALSE)
				)
				(if (= var_gen_def_following FALSE)
					(begin
						;Follow the player
						(print "Defenders following the player")
						(ai_set_orders gen_defenders cov_follow_player)
						(set var_gen_def_following TRUE)
					)
				)
				(if (= var_gen_def_following TRUE)
					(begin
						;Else come back in defending position
						(print "Defenders defending the generator")
						(ai_set_orders gen_defenders var_defending_order)
						(set var_gen_def_following FALSE)
					)
				)
			)
			
			(sleep 60)
											
			(OR
				(= var_generators_down TRUE)
				(AND
					(= (ai_living_count gen_defenders) 0)
					(>= var_nb_drops 3)
				)
			)
		)
	)
)

(script static void gen_def_phantom_drop
	(print "Phantom: Droping troops...")
	(object_set_phantom_power (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) TRUE)
	
	(vehicle_unload (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p_a01")
	(sleep 15)
	(vehicle_unload (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p_a02")
	(sleep 15)
	(vehicle_unload (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p_a03")
	
	(sleep 60)

	(vehicle_unload (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p_b01")
	(sleep 15)
	(vehicle_unload (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p_b02")
	(sleep 15)
	(vehicle_unload (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p_b03")

	(sleep 60)

	(vehicle_unload (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p_c01")
	(sleep 15)
	(vehicle_unload (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p_c02")
	(sleep 15)
	(vehicle_unload (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p_c03")	
	
	(object_set_phantom_power (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) FALSE)
	
	(sleep 60)
	(ai_migrate gen_def_phantom_elite gen_defenders)
	(ai_migrate gen_def_phantom_grunt gen_defenders)
	(ai_migrate gen_def_phantom_brute gen_defenders)
	
	(ai_migrate cov_attack_base_elite_0 cov_base_attackers)
	(ai_migrate cov_attack_base_grunt_0 cov_base_attackers)
	(ai_migrate cov_attack_base_jackal_0 cov_base_attackers)
	;(cs_run_command_script cov_base_attackers cs_cov_base_attackers)
	(print "Phantom: Finished droping troops")
)

;---------------------------------------------------------------------;
;-------------            ASSAULT THE BASE               -------------;
;---------------------------------------------------------------------;
(global boolean var_pelican_0_troops_dropped FALSE)
(script dormant assault_base
	(wake base_shields_flicker)
	;Wait until all combat from phase 2 is finished
	(sleep_until 
		(AND
			(>= var_nb_drops 3)
			(< (ai_living_count gen_defenders) 2)
			(= var_phantom_on_map FALSE)
			(= var_gen_def_active FALSE)
		)
	)
	
	;Pelican comes in to drop ally marines and Sgt. Johnson
	(print "placing pelican")
	(place_pelican_0)
	
	(sleep_until (= var_pelican_0_troops_dropped TRUE))
	
	(game_save)
	
	(print "Destroying base shields")
	(sleep_forever base_shields_flicker)
	(destroy_base_shields)
	
	;Place defenders inside the base
	;First deploy the turrets
	(if (< (ai_living_count all_cov) 11)
		(begin
			(ai_place F_cov_turret_0 1)
			(ai_place F_cov_turret_1 1)		
		)
	)
	(sleep 15)
	
	;Migrate other covenants (and spawn defenders) when the player is 
	;near the base or when he killed most of the defenders from 2nd phase
	;*(sleep_until 
		(OR
			(= (volume_test_objects vol_base_out (players)) TRUE)
			(AND
				(>= var_nb_drops 3)
				(< (ai_living_count gen_defenders) 2)
				(= var_phantom_on_map FALSE)
			)
		)
	)*;
	
	(print "migrating troops and spawning base defenders")
	;Prevent defend thread from spawning troops anymore
	(sleep_forever defend_D)
	(sleep_forever defend_E)
	(sleep_forever defend_G)	
	(migrate_from_2_to_3)
	
	;Then spawn some guys for the side defense
	(ai_place H_cov_0 (min 3 (- 8 (ai_living_count all_cov))))
	(sleep 30)
	(ai_place I_cov_0 (min 3 (- 8 (ai_living_count all_cov))))
	(sleep 15)
	
	;And finally place snipers
	;(ai_place F_cov_sniper_0 (min 1 (- 8 (ai_living_count all_cov))))
	;(sleep 15)
	;(ai_place F_cov_sniper_1 (min 1 (- 8 (ai_living_count all_cov))))
	;(sleep 15)

	(wake cov_base_defending)
	
	(sleep 900)
	
	(print "CORTANA: According to my plans, there's a terminal on the upper part of that base. You should be able to hook me on it.")
	
	(sleep_until (AND (< (ai_living_count all_cov) 3) (= var_phase_3_finished TRUE)))
	
	(print "CORTANA: You finished already? I was getting bored here. Alright, put me on the base terminal, inside on the second floor. I'll hack this system and give you access to the stabilizer.")
	
	(sleep_until (= (volume_test_objects vol_cortana (players)) TRUE) 5 1800)
	
	(if (= (volume_test_objects vol_cortana (players)) FALSE)
		(begin
			(print "Chief! You need to put me on the terminal, second floor, inside of the base. There's no way you're getting that stabilizer without my help.")
			(activate_team_nav_point_object default player cortana_pedestral 0)
		)		
	)
	
	(sleep_until (= (volume_test_objects vol_cortana (players)) TRUE) 5)
	(deactivate_team_nav_point_object player cortana_pedestral)
	(object_create_anew cortana_pedestral)
	
	(sleep_forever manage_marines_assault_base)
	(wake defend_base)
)

(script dormant manage_marines_assault_base
	(sleep_until
		(begin
			(if 
				(OR
					(= (volume_test_objects vol_base_in (players)) TRUE)
					(= (ai_living_count H_cov_0) 0)
					(= (ai_living_count I_cov_0) 0)
				)
				(ai_set_orders marines mar_follow_player)
			)
			(if (= (volume_test_objects vol_h (players)) TRUE)
				(ai_set_orders marines mar_attack_base_H)
			)
			(if (= (volume_test_objects vol_i (players)) TRUE)
				(ai_set_orders marines mar_attack_base_I)
			)
		0)
	)
)

(script static void place_pelican_0
	(ai_place pelican_0 1)
	(sleep 15)
	(ai_place mar_0 1)
	(ai_place mar_sgt_johnson 1)
	(vehicle_load_magic (ai_vehicle_get_from_starting_location pelican_0/pilot) "pelican_p" (ai_actors mar_0))
	(vehicle_load_magic (ai_vehicle_get_from_starting_location pelican_0/pilot) "pelican_p" (ai_actors mar_sgt_johnson))
)

(global boolean var_phase_3_finished FALSE)

(script dormant cov_base_defending		
	(sleep_until 
		(OR
			(< (ai_strength H_cov_0) 0.75)
			(< (ai_strength I_cov_0) 0.75)
		)
	)
	(if (< (ai_strength H_cov_0) 0.75)
		(begin
			(ai_set_orders H_cov_0 H_cov_1)
			(ai_set_orders I_cov_0 1st_floor_base_def_0)
		)
		(if (< (ai_strength I_cov_0) 0.75)
			(begin
				(ai_set_orders I_cov_0 I_cov_1)
				(ai_set_orders H_cov_0 1st_floor_base_def_0)
			)	
		)
	)

	(sleep_until (< (ai_living_count cov_base_def) 3))
	
	(ai_vehicle_exit cov_base_def_f)
	;(ai_set_orders cov_base_def_f 1st_floor_base_def_0)
	(ai_set_orders cov_base_def 1st_floor_base_def_0)
	
	(sleep_until (<= (ai_living_count cov_base_def) 0) 30 1800)
	
	(game_save)
	(ai_set_orders marines mar_follow_player)
	(sleep 60)
	
	;Spawn and open doors
	(device_group_change_only_once_more_set in_base_doors_1 TRUE)
	(device_operates_automatically_set in_base_door_2 TRUE)
	(device_operates_automatically_set in_base_door_3 TRUE)
	(sleep 15)
	(ai_place 1st_floor_base_def_grunt_0 3)
	(ai_place 1st_floor_base_def_brute_0 2)
	
	(sleep_until (< (ai_strength cov_base_def) 0.25))
	;(ai_set_orders cov_base_def 1st_floor_base_def)
	
	(sleep_until (< (ai_living_count cov_base_def) 2) 30 1800)
	
	(game_save)
	(ai_place 1st_floor_base_def_grunt_1 3)
	(ai_place 1st_floor_base_def_brute_1 2)
	(device_group_change_only_once_more_set in_base_doors_0 TRUE)
	(device_operates_automatically_set in_base_door_0 TRUE)
	(device_operates_automatically_set in_base_door_1 TRUE)
	(set var_phase_3_finished TRUE)
)

(script static void migrate_from_2_to_3
	(ai_vehicle_exit gen_defenders)
	(ai_vehicle_exit D_cov_defender_0)
	(ai_vehicle_exit D_cov_defender_1)
	(ai_vehicle_exit E_cov_defender_0)
	;(ai_vehicle_exit G_cov_defender_0)
	
	(ai_migrate gen_defenders cov_base_defenders)
	(ai_migrate D_cov_defender_0 cov_base_defenders)
	(ai_migrate D_cov_defender_1 cov_base_defenders)
	(ai_migrate E_cov_defender_0 cov_base_defenders)
	(ai_migrate gen_def_phantom_brute cov_base_defenders)
	(ai_migrate gen_def_phantom_elite cov_base_defenders)
	(ai_migrate gen_def_phantom_grunt cov_base_defenders)
	;(ai_migrate G_cov_defender_0 cov_base_defenders)
)

(script static void destroy_base_shields
	(object_damage_damage_section hall_shield_0 "emitter" 1)
	(object_damage_damage_section hall_shield_1 "emitter" 1)
	(object_damage_damage_section hall_shield_2 "emitter" 1)
	(object_damage_damage_section hall_shield_3 "emitter" 1)
	(object_damage_damage_section hall_shield_4 "emitter" 1)
	(object_damage_damage_section hall_shield_5 "emitter" 1)
	(object_damage_damage_section hall_shield_6 "emitter" 1)		
)


;---------------------------------------------------------------------;
;-------------             DEFEND THE BASE               -------------;
;---------------------------------------------------------------------;
(global boolean var_base_defense_on FALSE)
(script dormant defend_base
	(print "CORTANA: Accessing the core system... Chief, the core database is corrupted; I'll have to work on that thing for a few minutes...")
	(cs_run_command_script mar_sgt_johnson cs_marine_prepare_defense_0)
	(cs_run_command_script mar_0 cs_marine_prepare_defense_1)
	(sleep 150)
	(sleep_until 
		(OR
			(= (volume_test_objects vol_base_ledge (ai_actors marines)) TRUE)
			(= (ai_living_count marines) 0)
		)
	30 1800)
	(wake cov_attack_base)
	(wake cortana_health_watch)
	(wake cortana_nav_flicker)
	(wake base_prog_destruction)
	(print "CORTANA: Chief? Chief, I'm picking up incoming covenant dropships. You've got to protect me while I hack into the system. It shouldn't take me more than a couple of minutes.")
	(sleep 150)
	(print "Sgt. Johnson: You heard the lady marines, protect this place! I want you to look out for the three entrances.")
	(activate_team_nav_point_object default player cortana_pedestral 0)
	(set var_base_defense_on TRUE)
)

(global boolean var_ready_for_next_drop FALSE)
(script dormant cov_attack_base
	(sleep_until (< (ai_living_count all_cov) 3) 30 1800)
	
	;1st level door is opened
	(device_set_position base_door 1.0)
	(unblock_door_pathfinding)
			
	(print "First wave")
	;Assault on the left side, first floor
	;*(ai_place gen_def_phantom_G 1)
	(ai_migrate gen_def_phantom_G gen_def_phantom)
	(ai_place cov_attack_base_elite_0 2)
	(ai_place cov_attack_base_grunt_0 3)
	(load_phantom)
	(cs_run_command_script gen_def_phantom/pilot cs_def_base_phantom_H)
	(ai_set_orders cov_all_base_attackers cov_attack_base_1st_floor)
	
	(sleep_until (< (ai_living_count all_cov) 4) 30 3600)
	(game_save)
	(set var_ready_for_next_drop TRUE)
	
	(spawn_cov_base_attackers_1)
	(wake manage_cov_base_attackers_1)
	
	(set var_destroy_base TRUE)
	(sleep_until (= var_phantom_on_map FALSE))
	
	(print "Second wave")	
	;Assault on the left side, first floor
	(ai_place gen_def_phantom_G 1)
	(ai_migrate gen_def_phantom_G gen_def_phantom)
	(ai_place cov_attack_base_elite_0 (min 1 (- 10 (ai_living_count all_squads))))
	(ai_place cov_attack_base_jackal_0 (min 3 (- 10 (ai_living_count all_squads))))
	(load_phantom)
	(cs_run_command_script gen_def_phantom/pilot cs_def_base_phantom_H)
	
	(sleep_until (< (ai_living_count all_cov) 4) 30 3600)
	(game_save)
	(set var_destroy_base TRUE)
	(set var_ready_for_next_drop TRUE)
	
	(sleep_until (< (ai_living_count all_cov) 4) 30 900)
	(set var_destroy_base TRUE)
	(spawn_cov_base_attackers_0)
	(ai_set_orders cov_base_attackers_1 cov_attack_base_2nd_floor_1)
	(cs_run_command_script cov_base_attackers_1 cs_exit)
	
	(sleep_until (= var_phantom_on_map FALSE))
	(cs_run_command_script cov_all_base_attackers cs_cov_base_attackers)
	(ai_set_orders cov_all_base_attackers cov_reach_cortana)		
	
	(print "Third wave")
	;Assault on the right side
	(ai_place gen_def_phantom_I 1)
	(ai_migrate gen_def_phantom_I gen_def_phantom)
	(ai_place cov_attack_base_elite_0 (min 2 (- 10 (ai_living_count all_squads))))
	(ai_place cov_attack_base_grunt_0 (min 3 (- 10 (ai_living_count all_squads))))
	(load_phantom)
	(cs_run_command_script gen_def_phantom/pilot cs_def_base_phantom_I)

	;(sleep_until (< (ai_living_count all_cov) 3) 30 3600)
	(game_save)
	(set var_ready_for_next_drop TRUE)
	
	(spawn_cov_base_attackers_0)
		
	(sleep_until (= var_phantom_on_map FALSE))
	*;
	(print "Fifth wave")
	;Assault directly into the base
	(ai_place gen_def_phantom_G 1)
	(ai_migrate gen_def_phantom_G gen_def_phantom)
	(ai_place cov_attack_base_elite_0 (min 2 (- 10 (ai_living_count all_squads))))
	(ai_place cov_attack_base_grunt_0 (min 3 (- 10 (ai_living_count all_squads))))
	(load_phantom)
	(cs_run_command_script gen_def_phantom/pilot cs_def_base_phantom_base)
	
	(set var_ready_for_next_drop TRUE)
	
	(sleep 300)
	(spawn_cov_base_attackers_0)
	
	(set var_destroy_base TRUE)
	(sleep 15)
	(set var_destroy_base TRUE)
	(sleep 15)
	(set var_destroy_base TRUE)
	(sleep 15)
	(set var_destroy_base TRUE)
				
	;Place your ride back already so it has time to reach your base
	(place_warthog)
	
	(sleep_until (< (ai_living_count all_cov) 3) 30 3600)
	
	(transition_to_phase_5)
	(wake beach_extraction)
)

(global effect boom "effects\scenarios\solo\alphagasgiant\wall_explosion")
(global boolean var_destroy_base FALSE)
(script dormant base_prog_destruction	
	(sleep_until var_destroy_base)
	(set var_destroy_base FALSE)		
	(effect_new boom flag_fx_1)
	(object_create_anew fx_10)
	(object_create_anew fx_11)
	(object_create_anew fx_12)
	(object_create_anew fx_13)

	(sleep_until var_destroy_base)
	(set var_destroy_base FALSE)
	(effect_new boom flag_fx_2)
	(object_create_anew fx_20)
	(object_create_anew fx_21)
	(object_create_anew fx_22)
	
	(sleep_until var_destroy_base)
	(set var_destroy_base FALSE)
	(effect_new boom flag_fx_0)
	(object_create_anew fx_0)
	(object_create_anew fx_1)
	(object_create_anew fx_2)
	
	(sleep_until var_destroy_base)
	(set var_destroy_base FALSE)
	(object_create_anew fx_30)
	(object_create_anew fx_31)
)

(script dormant manage_cov_base_attackers_1
	(sleep_until (< (ai_living_count all_cov) 4) 30 600)
	(print "covenants fight on the 2nd floor!")
	(ai_set_orders cov_base_attackers cov_attack_base_2nd_floor_0)
	(ai_set_orders cov_base_attackers_2 cov_attack_base_2nd_floor_0)

	(sleep_until (< (ai_living_count all_cov) 5) 30 900)
	(print "humans on 2nd floor, covenants getting close to Cortana!")
	(ai_set_orders cov_base_attackers cov_attack_base_2nd_floor_1)
	(ai_set_orders cov_base_attackers_2 cov_attack_base_2nd_floor_1)
	(ai_set_orders marines mar_2nd_floor)	
)

(global real var_cortana_previous_health 1)
(global boolean var_enable_cortana_nav FALSE)
(global boolean var_cortana_first_hit FALSE)
(global boolean var_cortana_almost_dead FALSE)
(script dormant cortana_health_watch
	(sleep_until
		(begin
			(set var_enable_cortana_nav FALSE)
			(if (< (object_get_health cortana_pedestral) var_cortana_previous_health)
				(begin
					;Cortana asks for help the first time she's hit, and when she's at 50% of her health
					(if (= var_cortana_first_hit FALSE)
						(begin
							;First hit
							(print "I could use some help here Chief, they're attacking me!")
							(set var_cortana_first_hit TRUE)
						)
					)

					(if
						(AND
							(= var_cortana_first_hit TRUE)
							(= var_cortana_almost_dead FALSE)
							(< (object_get_health cortana_pedestral) 0.5)
						)
						(begin
							;Half of her energy gone
							(set var_cortana_almost_dead TRUE)
							(print "Ok it's hard for me to say this, but I really need your help here Chief!")
						)
					)
					
					(set var_enable_cortana_nav TRUE)
					(set var_cortana_previous_health (object_get_health cortana_pedestral))
					(sleep 150)
				)
			)
			;Game over if Cortana dies
			(if (<= (object_get_health cortana_pedestral) 0)
				(begin
					(print "GAME OVER - Cortana died")
					(sleep 60)
					(game_lost TRUE)
				)
			)			
		0)
	)
)

(script dormant cortana_nav_flicker
	(sleep_until
		(begin
			(if var_enable_cortana_nav
				(begin
					(deactivate_team_nav_point_object player cortana_pedestral)
					(sleep 10)
					(activate_team_nav_point_object default player cortana_pedestral 0)
				)
			)
		0)
	10)
)

(script static void unblock_door_pathfinding
	(object_destroy door_blocker_0)
	(object_destroy door_blocker_1)
	(object_destroy door_blocker_2)
	(object_destroy door_blocker_3)
	(object_destroy door_blocker_4)
	(object_destroy door_blocker_5)
	(object_destroy door_blocker_6)
	(object_destroy door_blocker_7)
)

(script static void spawn_cov_base_attackers_0
	(if
		(AND
			(volume_test_objects_all vol_base_out (players))
			(= (objects_can_see_flag (players) cov_base_attacker_0 1) FALSE)
		)
		(begin
			(print "Players not looking - spawning troops at wheel")
			(ai_place cov_attack_base_elite_1 (min 2 (- 10 (ai_living_count all_squads))))
			(ai_place cov_attack_base_jackal_1 (min 2 (- 10 (ai_living_count all_squads))))
			(ai_migrate cov_attack_base_elite_1 cov_base_attackers)
			(ai_migrate cov_attack_base_jackal_1 cov_base_attackers)
			;(cs_run_command_script cov_base_attackers cs_cov_base_attackers)
		)
	)
)

(script static void spawn_cov_base_attackers_1
	(if
		(AND
			(volume_test_objects_all vol_base_out (players))
			(= (objects_can_see_flag (players) cov_base_attacker_1 1) FALSE)
		)
		(begin
			(print "Players not looking - spawning troops far from the base")
			(ai_place cov_attack_base_elite_2 (min 2 (- 10 (ai_living_count all_squads))))
			(ai_place cov_attack_base_grunt_2 (min 3 (- 10 (ai_living_count all_squads))))
			;(ai_migrate cov_attack_base_elite_2 cov_base_attackers)
			;(ai_migrate cov_attack_base_jackal_2 cov_base_attackers)
			;(cs_run_command_script cov_base_attackers cs_cov_base_attackers)
		)
	)
)

(script static void load_phantom
	(vehicle_load_magic (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p_c" (ai_actors cov_attack_base_elite_0))
	(vehicle_load_magic (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p" (ai_actors cov_attack_base_jackal_0))
	(vehicle_load_magic (ai_vehicle_get_from_starting_location gen_def_phantom/pilot) "phantom_p" (ai_actors cov_attack_base_grunt_0))
)

(global boolean var_start_warthog_ride FALSE)
(global boolean var_pelican_gone FALSE)
(script static void transition_to_phase_5
	(sleep_until (= var_pelican_gone TRUE))
	;Create the stabilizer and guide the player there
	(print "There you go Chief: the stabilizer is all yours. It's on the first floor. We better hurry up, the reactor will not last long!")
	(object_create stabilizer)
	(ai_set_orders cov_all_base_attackers cov_attack_base_1st_floor)
	(cs_run_command_script cov_all_base_attackers cs_exit)
	(deactivate_team_nav_point_object player cortana_pedestral)
	(sleep 60)
	(wake part_5_display_nav_point)
	(cs_run_command_script mar_sgt_johnson cs_johnson_gunner)
	(ai_set_orders marines mar_beach)
	(ai_place banshee_0 1)
	(cs_run_command_script banshee_0 cs_banshee_0)
	(set var_start_warthog_ride TRUE)
)

(script static void place_warthog
	(ai_place pelican_1 1)
	(ai_place warthog_0)
	(object_cannot_take_damage (ai_vehicle_get_from_starting_location pelican_1/pilot))
	(vehicle_load_magic (ai_vehicle_get_from_starting_location pelican_1/pilot) "pelican_lc" (ai_vehicle_get_from_starting_location warthog_0/driver))
	(ai_vehicle_reserve (ai_vehicle_get_from_starting_location pelican_1/pilot) TRUE)
	(unit_set_enterable_by_player (ai_vehicle_get_from_starting_location warthog_0/driver) FALSE)
)

;---------------------------------------------------------------------;
;-------------           ESCAPE TO THE BEACH             -------------;
;---------------------------------------------------------------------;
(global boolean var_told_player_get_stabilizer FALSE)
(script dormant beach_extraction
	(sleep_until (= (volume_test_objects vol_g (ai_vehicle_get_from_starting_location warthog_0/driver)) TRUE))
	(game_save)
	(wake destruction_countdown)
	(wake manage_warthog)
	(wake manage_tunnel_elite)
	(wake manage_gate_elite)
	(wake manage_beach_cov)
	(ai_disregard (ai_actors pelican_1) TRUE)
	(ai_disregard (ai_actors marines) TRUE)
	(wake environment_explosions_0)
	
	(sleep_until (= (volume_test_objects vol_c_right (players)) TRUE))
	(ai_place banshee_0 1)
	(cs_queue_command_script banshee_0 cs_banshee_1)
	
	(sleep 90)
	(sleep_forever environment_explosions_0)
	(wake environment_explosions_1)
)

;Create some explosions in the middle part
(script dormant environment_explosions_0
	(sleep_until
		(begin_random
			(begin
				(effect_new boom explosion_0)
				(sleep 30)
			0)
			(begin
				(effect_new boom explosion_1)
				(sleep 30)
			0)
			(begin
				(effect_new boom explosion_2)
				(sleep 30)
			0)
			(begin
				(effect_new boom explosion_3)
				(sleep 30)
			0)
			(begin
				(effect_new boom explosion_4)
				(sleep 30)
			0)
			(begin
				(effect_new boom explosion_5)
				(sleep 30)
			0)
		0)
	)
)

;Create some explosions in the beach part
(script dormant environment_explosions_1
	(sleep_until
		(begin_random
			(begin
				(effect_new boom explosion_6)
				(sleep 30)
			0)
			(begin
				(effect_new boom explosion_7)
				(sleep 30)
			0)
			(begin
				(effect_new boom explosion_8)
				(sleep 30)
			0)
			(begin
				(effect_new boom explosion_9)
				(sleep 30)
			0)
			(begin
				(effect_new boom explosion_10)
				(sleep 30)
			0)
			(begin
				(effect_new boom explosion_11)
				(sleep 30)
			0)
			(begin
				(effect_new boom explosion_12)
				(sleep 30)
			0)			
		0)
	)
)

(script dormant manage_tunnel_elite
	(sleep_until (= (volume_test_objects vol_tunnel (players)) FALSE) 30 1800)
	
	(if (= (volume_test_objects vol_tunnel (players)) FALSE)
		(begin
			(ai_place cov_tunnel_elite_0 1)
			(sleep_until (= (volume_test_objects vol_c (players)) TRUE))
			(ai_set_orders cov_tunnel_elite_0 cov_tunnel_1)
			(sleep_until (= (volume_test_objects vol_b (players)) TRUE))
			(ai_set_orders cov_tunnel_elite_0 cov_escape_follow_player)
		)	
	)
)

(script dormant manage_gate_elite
	(sleep_until (= (volume_test_objects vol_gate (players)) FALSE) 30 1800)
	
	(if (= (volume_test_objects vol_gate (players)) FALSE)
		(begin
			(ai_place cov_gate_elite_0 2)
			(sleep_until (= (volume_test_objects vol_c_right (players)) TRUE))
			(ai_set_orders cov_gate_elite_0 cov_gate_1)
			(sleep_until (= (volume_test_objects vol_a_1 (players)) TRUE))			
			(ai_set_orders cov_gate_elite_0 cov_escape_follow_player)				
		)	
	)
)

(script dormant manage_beach_cov
	(sleep_until 
		(AND
			(= (volume_test_objects vol_c_right (players)) TRUE)
			(= (volume_test_objects vol_b (players)) FALSE)
			(= (volume_test_objects vol_a_0 (players)) FALSE)
			(= (volume_test_objects vol_a_1 (players)) FALSE)
		)
	)
	(ai_place cov_beach_elite_0 1)
	(ai_place cov_beach_jackal_0 1)
	(ai_place cov_beach_jackal_1 1)	
	
	(sleep_until (= (volume_test_objects vol_b (players)) TRUE))
	(ai_place cov_beach_elite_1 (min 1 (- 10 (ai_living_count all_squads))))
	
	(sleep_until (= (volume_test_objects vol_a_1 (players)) TRUE))
	(ai_place cov_beach_elite_2 (min 1 (- 10 (ai_living_count all_squads))))
	
	(sleep_until (= (volume_test_objects vol_a_0 (players)) TRUE))
	(sleep 120)
	(ai_set_orders cov_beach_0 cov_escape_follow_player)
)

(script dormant part_5_display_nav_point
	(sleep_until
		(begin
			(if 
				(OR
					(unit_has_weapon (player0) objects\weapons\multiplayer\assault_bomb\assault_bomb)
					(unit_has_weapon (player1) objects\weapons\multiplayer\assault_bomb\assault_bomb)
				)
				(begin
					(deactivate_team_nav_point_object player stabilizer)
					(activate_team_nav_point_object default player (ai_vehicle_get_from_starting_location pelican_1/pilot) 0)
				)
				(begin
					(deactivate_team_nav_point_object player (ai_vehicle_get_from_starting_location pelican_1/pilot))
					(activate_team_nav_point_object default player stabilizer 0)
				)
			)
		0)
	)
)

(script dormant manage_warthog
	;(set var_stabilizer_warthog_wait 900)
	;(wait_for_stabilizer_in_warthog)
	
	(sleep_until
		(begin
			(if 
				(OR 
					(AND
						(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player0))
						(NOT (unit_has_weapon (player0) objects\weapons\multiplayer\assault_bomb\assault_bomb))
						(= var_told_player_get_stabilizer FALSE)
					)
					(AND
						(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player1))
						(NOT (unit_has_weapon (player1) objects\weapons\multiplayer\assault_bomb\assault_bomb))
						(= var_told_player_get_stabilizer FALSE)
					)
				)
				(begin
					(print "MARINE: I'm not getting outa here without the stabilizer!")
					(set var_told_player_get_stabilizer TRUE)
				)
				
				(begin
			)
			
			(OR 
				(AND
					(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player0))
					(unit_has_weapon (player0) objects\weapons\multiplayer\assault_bomb\assault_bomb)
				)
				(AND
					(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player1))
					(unit_has_weapon (player1) objects\weapons\multiplayer\assault_bomb\assault_bomb)
				)
			)
		)
	30 2700)
	
	;Remember the player he should go in the warthog to get back to the beach
	(if 
		(NOT
			(OR 
				(AND
					(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player0))
					(unit_has_weapon (player0) objects\weapons\multiplayer\assault_bomb\assault_bomb)
				)
				(AND
					(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player1))
					(unit_has_weapon (player1) objects\weapons\multiplayer\assault_bomb\assault_bomb)
				)
			)
		)
		(begin
			(sound_impulse_start sound\dialog\combat\sgt_johnson\09_order\newordr_moveon (ai_get_object mar_sgt_johnson) 1)
			(print "Get into that warthog with the stabilizer if you want a ride!")
		)
	)
	
	;(set var_stabilizer_warthog_wait 300)
	;(wait_for_stabilizer_in_warthog)
	
	(sleep_until
		(begin
			(if 
				(OR 
					(AND
						(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player0))
						(NOT (unit_has_weapon (player0) objects\weapons\multiplayer\assault_bomb\assault_bomb))
						(= var_told_player_get_stabilizer FALSE)
					)
					(AND
						(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player1))
						(NOT (unit_has_weapon (player1) objects\weapons\multiplayer\assault_bomb\assault_bomb))
						(= var_told_player_get_stabilizer FALSE)
					)
				)
				(print "MARINE: I'm not getting outa here without the stabilizer!")
			)
			
			(OR 
				(AND
					(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player0))
					(unit_has_weapon (player0) objects\weapons\multiplayer\assault_bomb\assault_bomb)
				)
				(AND
					(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player1))
					(unit_has_weapon (player1) objects\weapons\multiplayer\assault_bomb\assault_bomb)
				)
			)
		)
	30 300)	
	
	(print "Warthog heading to the beach")
	(set var_player_got_in_warthog TRUE)

)

;*(global short var_stabilizer_warthog_wait 30)
(script static void wait_for_stabilizer_in_warthog
	(sleep_until
		(begin
			(if 
				(OR 
					(AND
						(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player0))
						(NOT (unit_has_weapon (player0) objects\weapons\multiplayer\assault_bomb\assault_bomb))
					)
					(AND
						(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player1))
						(NOT (unit_has_weapon (player1) objects\weapons\multiplayer\assault_bomb\assault_bomb))
					)
				)
				(print "MARINE: I'm not getting outa here without the stabilizer!")
			)
			
			(OR 
				(AND
					(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player0))
					(unit_has_weapon (player0) objects\weapons\multiplayer\assault_bomb\assault_bomb)
				)
				(AND
					(vehicle_test_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" (player1))
					(unit_has_weapon (player1) objects\weapons\multiplayer\assault_bomb\assault_bomb)
				)
			)
		)
	30 var_stabilizer_warthog_wait_time)
)*;

(script dormant destruction_countdown
	(print "CORTANA: I estimate 2 minutes before the core explodes!")
	(sleep 300)
	(print "1 min 50 seconds...")
	(sleep 300)
	(print "1 min 40 seconds...")
	(sleep 300)
	(print "1 min 30 seconds...")
	(sleep 300)
	(print "1 min 20 seconds...")
	(sleep 300)
	(print "1 min 10 seconds...")
	(sleep 300)
	(print "1 minute before the explosion!")
	(sleep 300)
	(print "50 seconds...")
	(sleep 300)
	(print "40 seconds...")
	(sleep 300)
	(print "30 seconds...")
	(sleep 300)
	(print "20 seconds...")
	(sleep 300)
	(print "10 seconds...")
	(sleep 150)
	(print "5 seconds to destruction...!")
	(sleep 150)
	(print "BOOM!")
	(sleep 60)
	(game_lost TRUE)
)

(script startup mission
	(game_can_use_flashlights TRUE)
	
	(object_damage_damage_section cortana_pedestral main 1.0)
	(sleep_until (= start TRUE))
	(print "Starting mission...")
	(wake stealth_insertion)
	;(wake disable_base_power)
	(wake ennemy_counter)
)

(script static void reuse_part_two
	(sleep_forever stealth_insertion)
	(ai_erase all_cov)
	
	(object_teleport (player0) flag_0)
	(wake disable_base_power)
)

(script static void reuse_part_three
	(sleep_forever stealth_insertion)
	(sleep_forever disable_base_power)
	(sleep_forever part_2_display_nav_points)
	(set var_nb_drops 3)
	(ai_erase all_cov)
	
	(object_teleport (player0) flag_1)
	(wake assault_base)
)

(script static void reuse_part_four
	(sleep_forever stealth_insertion)
	(sleep_forever disable_base_power)
	(sleep_forever part_2_display_nav_points)
	(sleep_forever assault_base)
	(ai_erase all_cov)
	(destroy_base_shields)
	
	(ai_place mar_0_temp_spawn 1)
	(ai_place mar_sgt_johnson_temp_spawn 1)
	(ai_migrate mar_0_temp_spawn mar_0)
	(ai_migrate mar_sgt_johnson_temp_spawn mar_sgt_johnson)
	(object_teleport (player0) flag_2)
	(deactivate_team_nav_point_object player cortana_pedestral)
	(object_create_anew cortana_pedestral)	
	(wake defend_base)
)

(script static void reuse_part_five
	(sleep_forever stealth_insertion)
	(sleep_forever disable_base_power)
	(sleep_forever part_2_display_nav_points)
	(sleep_forever assault_base)
	(sleep_forever defend_base)
	(sleep_forever cov_attack_base)
	(sleep_forever cortana_health_watch)
	(sleep_forever cortana_nav_flicker)
	(sleep_forever base_prog_destruction)
		
	(ai_erase all_cov)
	(destroy_base_shields)
	(device_set_position base_door 1.0)
	(unblock_door_pathfinding)
	
	(ai_place mar_0_temp_spawn 1)
	(ai_place mar_sgt_johnson_temp_spawn 1)
	(ai_migrate mar_0_temp_spawn mar_0)
	(ai_migrate mar_sgt_johnson_temp_spawn mar_sgt_johnson)
	(object_teleport (player0) flag_2)
	(place_warthog)
	(transition_to_phase_5)
	(wake beach_extraction)
)

(script dormant ennemy_counter
	(sleep_until
		(begin
			(if (= debug TRUE)
				(begin
					(print "All mobs:")
					(if (<= (ai_living_count all_squads) 10) (print "<= 10")
						(if (<= (ai_living_count all_squads) 12) (print "<= 12")
							(if (<= (ai_living_count all_squads) 14) (print "<= 14")
								(if (<= (ai_living_count all_squads) 16) (print "<= 16")
									(print "> 16")
								)
							)
						)
					)		
				)
			)
			(sleep 300)
			0
		)
	)
)

(script command_script cs_A_elite_patrol_0
	(cs_abort_on_combat_status ai_combat_status_active)
	(cs_enable_pathfinding_failsafe true)
	(sleep_until
		(begin
			(cs_go_to pts_A_elite_patrol_0/p0 1)
			(cs_go_to pts_A_elite_patrol_0/p1 1)
			(sleep (random_range 15 30))
			(cs_go_to pts_A_elite_patrol_0/p2 1)
			(sleep (random_range 15 30))
			(cs_go_to pts_A_elite_patrol_0/p7 1)
			(cs_go_to pts_A_elite_patrol_0/p3 1)
			(sleep (random_range 15 30))
			(cs_go_to pts_A_elite_patrol_0/p4 1)
			(cs_go_to pts_A_elite_patrol_0/p5 1)
			(sleep (random_range 15 30))
			(cs_go_to pts_A_elite_patrol_0/p6 1)
			(sleep (random_range 60 90))		
		false)
	)
)

(script command_script cs_A_elite_patrol_1
	(cs_abort_on_combat_status ai_combat_status_active)
	(cs_enable_pathfinding_failsafe true)
	(cs_go_to pts_A_elite_patrol_0/p4 1)
	(cs_go_to pts_A_elite_patrol_0/p3 1)
	(cs_go_to pts_A_elite_patrol_0/p7 1)
	(sleep (random_range 90 120))
	;(cs_go_to pts_A_elite_patrol_0/p2 1)
	(sleep_until
		(begin
			(cs_go_to pts_A_elite_patrol_0/p7 1)
			(cs_go_to pts_A_elite_patrol_0/p3 1)
			(sleep (random_range 45 60))
			(cs_go_to pts_A_elite_patrol_0/p2 1)
			(sleep (random_range 15 30))
			(cs_go_to pts_A_elite_patrol_0/p1 1)
			(sleep (random_range 45 60))
			(cs_go_to pts_A_elite_patrol_0/p2 1)
			(sleep (random_range 15 30))
		false)
	)
)

(script command_script cs_A_jackal_patrol_0
	(cs_abort_on_combat_status ai_combat_status_active)
	(cs_enable_pathfinding_failsafe true)
	(sleep_until
		(begin
			(cs_go_to pts_A_jackal_patrol_0/p0 1)
			(sleep (random_range 45 60))
			(cs_go_to pts_A_jackal_patrol_0/p1 1)
			(sleep (random_range 45 60))
			(cs_go_to pts_A_jackal_patrol_0/p2 1)
			(sleep (random_range 15 30))
		false)
	)
)

(script command_script cs_A_jackal_patrol_1
	(cs_abort_on_combat_status ai_combat_status_active)
	(cs_enable_pathfinding_failsafe true)
	(sleep_until
		(begin
			(cs_go_to pts_A_jackal_patrol_0/p3 1)
			(sleep (random_range 45 60))
			(cs_go_to pts_A_jackal_patrol_0/p4 1)
			(sleep (random_range 45 60))
			(cs_go_to pts_A_jackal_patrol_0/p5 1)
			(sleep (random_range 15 30))
		false)
	)
)

(script command_script cs_D_spectre_0_driver
	(cs_enable_pathfinding_failsafe true)
	(ai_migrate C_cov_spectre D_cov_defender_0)	
	(cs_go_to pts_D_spectre_0/p0 1)
	(cs_go_to pts_D_spectre_0/p1 1)
	;(cs_go_to pts_D_spectre_0/p2 1)
	(ai_vehicle_reserve_seat (ai_vehicle_get ai_current_actor) "spectre_d" true)
	(ai_vehicle_reserve_seat (ai_vehicle_get ai_current_actor) "spectre_p_r" true)
	(ai_vehicle_reserve_seat (ai_vehicle_get ai_current_actor) "spectre_p_l" true)
	(ai_vehicle_exit D_cov_defender_0 spectre_d)
	;(ai_vehicle_exit C_cov_spectre spectre_p_r)
	(ai_vehicle_exit D_cov_defender_0 spectre_p_l)
)

(script command_script cs_gen_def_phantom_D
	(cs_enable_pathfinding_failsafe true)

	(set var_phantom_on_map TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_by pts_phantom_arrival_C/p0)
	(cs_fly_by pts_phantom_arrival_C/p1)
	;(cs_fly_by pts_phantom_arrival_C/p2)
	
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face pts_phantom_landing_D/p0 pts_phantom_landing_D/look_at 1)
	(gen_def_phantom_drop)
	
	(cs_vehicle_speed 1)
	(cs_fly_by pts_phantom_arrival_B/p3)
	(cs_fly_by pts_phantom_arrival_B/p2)
	(cs_fly_by pts_phantom_arrival_B/p1)
	(cs_fly_by pts_phantom_arrival_B/p0)
	
	(ai_erase gen_def_phantom)
	(set var_phantom_on_map FALSE)
)

(script command_script cs_gen_def_phantom_E
	(cs_enable_pathfinding_failsafe true)

	(set var_phantom_on_map TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_by pts_phantom_arrival_B/p0)
	(cs_fly_by pts_phantom_arrival_B/p1)
	(cs_fly_by pts_phantom_arrival_B/p2)
	(cs_fly_by pts_phantom_arrival_B/p3)
	
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face pts_phantom_landing_E/p0 pts_phantom_landing_E/look_at 1)
	;(cs_fly_to_and_face pts_phantom_landing_E/p1 pts_phantom_landing_E/look_at 1)
	(gen_def_phantom_drop)

	(cs_vehicle_speed 1)
	(cs_fly_by pts_phantom_arrival_B/p3)
	(cs_fly_by pts_phantom_arrival_B/p2)
	(cs_fly_by pts_phantom_arrival_B/p1)
	(cs_fly_by pts_phantom_arrival_B/p0)
	
	(ai_erase gen_def_phantom)
	(set var_phantom_on_map FALSE)
)

(script command_script cs_gen_def_phantom_G
	(cs_enable_pathfinding_failsafe true)

	(set var_phantom_on_map TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_by pts_phantom_arrival_I/p0)
	(cs_fly_by pts_phantom_arrival_I/p1)
	(cs_fly_by pts_phantom_arrival_I/p2)
	
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face pts_phantom_landing_G/p0 pts_phantom_landing_G/look_at 1)
	(gen_def_phantom_drop)
	
	(cs_vehicle_speed 1)
	(cs_fly_by pts_phantom_arrival_I/p2)
	(cs_fly_by pts_phantom_arrival_I/p1)
	(cs_fly_by pts_phantom_arrival_I/p0)
	
	(ai_erase gen_def_phantom)
	(set var_phantom_on_map FALSE)
)

(script command_script cs_F_turret_0
	(cs_enable_pathfinding_failsafe true)
	
	(cs_go_to pts_F_turrets/p0)
	(cs_deploy_turret pts_F_turrets/p0)
)

(script command_script cs_F_turret_1
	(cs_enable_pathfinding_failsafe true)
	
	(cs_go_to pts_F_turrets/p1)
	(cs_deploy_turret pts_F_turrets/p1)
)

(script command_script cs_pelican_0
	(cs_enable_pathfinding_failsafe true)

	(cs_vehicle_speed 1)
	(cs_fly_by pts_pelican_0/p0)
	(cs_fly_by pts_pelican_0/p1)
	(cs_fly_by pts_pelican_0/p2)
	
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face pts_pelican_0/p3 pts_pelican_0/look_at 1)
	
	(vehicle_unload (ai_vehicle_get_from_starting_location pelican_0/pilot) "pelican_p")
	(sleep 60)
	(set var_pelican_0_troops_dropped TRUE)	
	(cs_vehicle_speed 0.7)
	(cs_fly_by pts_pelican_0/p2)
	(cs_fly_by pts_pelican_0/p1)
	(cs_fly_by pts_pelican_0/p0)
	(cs_fly_by pts_pelican_0/p4)
	
	(ai_erase pelican_0)
)

(script command_script cs_johnson_intro
	(sleep_until (= var_pelican_0_troops_dropped TRUE))
	(sleep 60)
	(cs_go_to pts_marines_intro/p0)
	(cs_face_object 1 base_right_front_door)
	(sleep 60)
	(custom_animation (ai_get_unit ai_current_actor) "objects\characters\marine\marine" "combat:missile:point" true)
	;(sleep (unit_get_custom_animation_time (ai_get_unit ai_current_actor)))
	(sound_impulse_start sound\dialog\levels\01_spacestation\mission\L01_0190_jon (ai_get_object mar_sgt_johnson) 1)
	(sleep (sound_impulse_language_time sound\dialog\levels\01_spacestation\mission\L01_0190_jon))
	(ai_set_orders marines mar_follow_player)
	(wake manage_marines_assault_base)
)
(script command_script cs_marine_intro_0
	(sleep_until (= var_pelican_0_troops_dropped TRUE))
	(sleep 60)
	(cs_go_to pts_marines_intro/p1)
	(sleep 120)
)

(script command_script cs_marine_intro_1
	(sleep_until (= var_pelican_0_troops_dropped TRUE))
	(sleep 60)
	(cs_go_to pts_marines_intro/p2)
	(sleep 120)
)

(script command_script cs_marine_prepare_defense_0
	;(cs_abort_on_combat_status ai_combat_status_active)
	(cs_movement_mode ai_movement_combat)
	(cs_go_to pts_marines_defend/p0)
	(cs_go_to pts_marines_defend/p1)
	(cs_face_object 1 cortana_pedestral)
	(sleep_until (= var_base_defense_on TRUE))
	(custom_animation (ai_get_unit ai_current_actor) "objects\characters\marine\marine" "combat:missile:deploy" true)
	(sound_impulse_start sound\dialog\combat\sgt_johnson\09_order\newordr_arrival (ai_get_object mar_sgt_johnson) 1)
	(sleep (sound_impulse_language_time sound\dialog\combat\sgt_johnson\09_order\newordr_arrival))
	(sleep 30)
	(ai_set_orders mar_sgt_johnson mar_I_0)
)

(script command_script cs_marine_prepare_defense_1
	;(cs_abort_on_combat_status ai_combat_status_active)
	(cs_movement_mode ai_movement_combat)
	(cs_go_to pts_marines_defend/p2)
	(cs_go_to pts_marines_defend/p3)
	(cs_face_object 1 cortana_pedestral)
	(sleep_until (= var_base_defense_on TRUE))
	(ai_set_orders mar_0 mar_I_0)
)

(script command_script cs_def_base_phantom_I
	(cs_enable_pathfinding_failsafe true)

	(set var_phantom_on_map TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_by pts_phantom_arrival_I/p0)
	(cs_fly_by pts_phantom_arrival_I/p1)
	(cs_fly_by pts_phantom_arrival_I/p2)
	
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face pts_phantom_landing_I/p0 pts_phantom_landing_I/look_at 1)
	(gen_def_phantom_drop)
	(cs_fly_to_and_face pts_phantom_landing_I/p1 pts_phantom_landing_I/look_at 1)
	(cs_fly_to_and_face pts_phantom_landing_I/p2 pts_phantom_landing_I/look_at 1)
	(cs_fly_to_and_face pts_phantom_landing_I/p3 pts_phantom_landing_I/look_at 1)
	
	(sleep_until 
	;	(OR 
			(= var_ready_for_next_drop TRUE)
	;		(3 turrets destroyed)
	;	)
	)
	(set var_ready_for_next_drop FALSE)
	
	(cs_vehicle_speed 1)
	(cs_fly_by pts_phantom_arrival_B/p3)
	(cs_fly_by pts_phantom_arrival_B/p2)
	(cs_fly_by pts_phantom_arrival_B/p1)
	(cs_fly_by pts_phantom_arrival_B/p0)
	
	(ai_erase gen_def_phantom)
	(set var_phantom_on_map FALSE)
)

(script command_script cs_def_base_phantom_H
	(cs_enable_pathfinding_failsafe true)

	(set var_phantom_on_map TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_by pts_phantom_arrival_G/p0)
	(cs_fly_by pts_phantom_arrival_G/p1)
	(cs_fly_by pts_phantom_arrival_G/p2)
	
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face pts_phantom_landing_H/p0 pts_phantom_landing_H/p4 1)
	(gen_def_phantom_drop)
	(cs_fly_to_and_face pts_phantom_landing_H/p1 pts_phantom_landing_H/p4 1)
	(cs_fly_to_and_face pts_phantom_landing_H/p2 pts_phantom_landing_H/look_at 1)
	(cs_fly_to_and_face pts_phantom_landing_H/p3 pts_phantom_landing_H/look_at 1)
	
	(sleep_until 
	;	(OR 
			(= var_ready_for_next_drop TRUE)
	;		(3 turrets destroyed)
	;	)
	)
	(set var_ready_for_next_drop FALSE)
	
	(cs_vehicle_speed 1)
	(cs_fly_by pts_phantom_arrival_B/p3)
	(cs_fly_by pts_phantom_arrival_B/p2)
	(cs_fly_by pts_phantom_arrival_B/p1)
	(cs_fly_by pts_phantom_arrival_B/p0)
	
	(ai_erase gen_def_phantom)
	(set var_phantom_on_map FALSE)
)

(script command_script cs_def_base_phantom_base
	(cs_enable_pathfinding_failsafe true)

	(set var_phantom_on_map TRUE)
	(cs_vehicle_speed 1)
	(cs_fly_by pts_phantom_arrival_G/p0)
	(cs_fly_by pts_phantom_arrival_G/p1)
	(cs_fly_by pts_phantom_arrival_G/p2)
	
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face pts_phantom_landing_base/p0 pts_phantom_landing_base/p4 1)
	(gen_def_phantom_drop)
	(cs_fly_by pts_phantom_landing_base/p1 1)
	(cs_fly_by pts_phantom_landing_base/p2 1)
	(cs_fly_to_and_face pts_phantom_landing_base/p3 pts_phantom_landing_base/look_at 1)
	
	(sleep_until 
	;	(OR 
			(= var_ready_for_next_drop TRUE)
	;		(3 turrets destroyed)
	;	)
	)
	(set var_ready_for_next_drop FALSE)
	
	(cs_vehicle_speed 1)
	(cs_fly_by pts_phantom_arrival_B/p3)
	(cs_fly_by pts_phantom_arrival_B/p2)
	(cs_fly_by pts_phantom_arrival_B/p1)
	(cs_fly_by pts_phantom_arrival_B/p0)
	
	(ai_erase gen_def_phantom)
	(set var_phantom_on_map FALSE)
)

(script command_script cs_cov_base_attackers_1st_floor
	(cs_enable_pathfinding_failsafe true)
	(cs_enable_moving true)
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_enable_dialogue true)
	
	(cs_go_to pts_cov_base_attackers/p3)
	(cs_run_command_script ai_current_actor cs_cov_base_attackers)
)

(script command_script cs_reach_2nd_floor
	(cs_enable_pathfinding_failsafe true)
	(cs_enable_moving true)
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_enable_dialogue true)
	
	(cs_go_to pts_cov_base_attackers/p4)
)

(script command_script cs_cov_base_attackers_2nd_floor
	(cs_enable_pathfinding_failsafe true)
	(cs_enable_moving true)
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_enable_dialogue true)
	
	(cs_go_to pts_cov_base_attackers/p5)
	(sleep 30)
	(cs_go_to pts_cov_base_attackers/p6)
	(cs_go_to pts_cov_base_attackers/p4)
	(cs_run_command_script ai_current_actor cs_cov_base_attackers)
)

(script command_script cs_cov_base_attackers
	(cs_enable_pathfinding_failsafe true)
	(cs_enable_moving true)
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_enable_dialogue true)
	;(cs_abort_on_combat_status ai_combat_status_dangerous)
	
	(sleep_until
		(begin
			(begin_random
				(if (> (unit_get_shield (unit (ai_get_object ai_current_actor))) 0.1)
					(begin
						(cs_go_to pts_cov_base_attackers/p0)
						(sleep_until (= (volume_test_objects vol_base_ledge ai_current_actor) TRUE) 30 210)
						;(if (objects_can_see_flag ai_current_actor cortana 90)
						;	(begin
								(cs_shoot TRUE cortana_pedestral)
								(sleep 120)
						;	)
						;)
					)
				)
				(if (> (unit_get_shield (unit (ai_get_object ai_current_actor))) 0.1)
					(begin
						(cs_go_to pts_cov_base_attackers/p1)
						(sleep_until (= (volume_test_objects vol_base_ledge ai_current_actor) TRUE) 30 210)
						;(if (objects_can_see_flag ai_current_actor cortana 90)
						;	(begin
								(cs_shoot TRUE cortana_pedestral)
								(sleep 120)
						;	)
						;)
					)
				)
				(if (> (unit_get_shield (unit (ai_get_object ai_current_actor))) 0.1)
					(begin
						(cs_go_to pts_cov_base_attackers/p2)
						(sleep_until (= (volume_test_objects vol_base_ledge ai_current_actor) TRUE) 30 210)
						;(if (objects_can_see_flag ai_current_actor cortana 90)
						;	(begin
								(cs_shoot TRUE cortana_pedestral)
								(sleep 120)
						;	)
						;)
					)
				)
			)
			(<= (unit_get_shield (unit (ai_get_object ai_current_actor))) 0.1)
		)
	)
)

(script command_script cs_pelican_1
	(cs_enable_pathfinding_failsafe true)

	(cs_vehicle_speed 1)
	(cs_fly_by pts_pelican_1/p0)
	(cs_fly_by pts_pelican_1/p1)
	
	(cs_vehicle_speed .5)
	(cs_fly_to_and_face pts_pelican_1/p2 pts_pelican_1/look_at_0 1)
	
	(vehicle_unload (ai_vehicle_get_from_starting_location pelican_1/pilot) "pelican_lc")
	(sleep 90)
	(set var_pelican_gone TRUE)
	(cs_run_command_script warthog_0/driver cs_warthog_escape)
	
	(cs_vehicle_speed 0.5)
	(cs_fly_to_and_face pts_pelican_1/p3 pts_pelican_1/look_at_0 1)
	(sleep 120)
	(cs_fly_to_and_face pts_pelican_1/p4 pts_pelican_1/look_at_1 1)
)


;Script that will put some sparkle before the actual explosion takes place
(script dormant warthog_explosion_intro
	(object_create_anew warthog_sparkle)
	(effect_new boom explosion_3)
)

;Script that will trigger the explosion
(script dormant warthog_explosion
	(print "warthog EXPLOSION!")
	;(damage_object objects\vehicles\wraith\damage_effects\wraith_mortar (ai_vehicle_get_from_starting_location warthog_0/driver))
	;(damage_object objects\weapons\grenade\frag_grenade\damage_effects\frag_grenade_explosion (ai_vehicle_get_from_starting_location warthog_0/driver))
	(damage_new objects\weapons\grenade\frag_grenade\damage_effects\frag_grenade_explosion warthog_explosion)
	(effect_new boom warthog_explosion_effect)
	(object_destroy warthog_sparkle)
	(sleep 60)
	(print "unloading warthog")
	(vehicle_unload (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_g")
	(vehicle_unload (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p")
	(vehicle_unload (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_d")
	(ai_vehicle_exit marines)	
	(sleep 30)
	(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_d" TRUE)
	(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" TRUE)
	(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_g" TRUE)
	(unit_set_enterable_by_player (ai_vehicle_get_from_starting_location warthog_0/driver) FALSE)	
	(sleep 60)
	(object_cannot_take_damage (players))
	(object_damage_damage_section (ai_vehicle_get_from_starting_location warthog_0/driver) "main" 1)
	(object_damage_damage_section (ai_vehicle_get_from_starting_location warthog_0/driver) "hull" 1)
	(object_damage_damage_section (ai_vehicle_get_from_starting_location warthog_0/driver) "bumper" 1)
	(object_damage_damage_section (ai_vehicle_get_from_starting_location warthog_0/driver) "windshield" 1)
	(object_damage_damage_section (ai_vehicle_get_from_starting_location warthog_0/driver) "lf_wheel" 1)
	(object_damage_damage_section (ai_vehicle_get_from_starting_location warthog_0/driver) "rf_wheel" 1)
	(object_damage_damage_section (ai_vehicle_get_from_starting_location warthog_0/driver) "lb_wheel" 1)
	(object_damage_damage_section (ai_vehicle_get_from_starting_location warthog_0/driver) "rb_wheel" 1)	
	(sleep 30)
	(object_can_take_damage (players))
	;(damage_object objects\weapons\grenade\frag_grenade\damage_effects\frag_grenade_explosion (ai_vehicle_get_from_starting_location warthog_0/driver))
	;(sleep 180)
	;(damage_object objects\weapons\grenade\frag_grenade\damage_effects\frag_grenade_explosion (ai_vehicle_get_from_starting_location warthog_0/driver))
	;(sleep 180)
	;(damage_object objects\weapons\grenade\frag_grenade\damage_effects\frag_grenade_explosion (ai_vehicle_get_from_starting_location warthog_0/driver))
)


;Scripted warthog ride
(global boolean var_player_got_in_warthog FALSE)
(script command_script cs_warthog_escape
	(cs_enable_pathfinding_failsafe true)
	;(ai_vehicle_reserve_seat (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_p" FALSE)
	(unit_set_enterable_by_player (ai_vehicle_get_from_starting_location warthog_0/driver) TRUE)
	(cs_vehicle_speed 0.75)
	
	(sleep_until (= var_start_warthog_ride TRUE))
	
	(cs_go_to pts_marines_warthog/p0 2)
	(cs_go_to pts_marines_warthog/p1 2)
	(cs_go_to pts_marines_warthog/p2 2)
	(cs_go_to pts_marines_warthog/p3 2)
	(cs_go_to pts_marines_warthog/p4 2)
	(cs_go_to pts_marines_warthog/p5 2)
	(cs_go_to pts_marines_warthog/p6 2)
	
	(cs_vehicle_speed 0.7)
	
	(sleep_until (= var_player_got_in_warthog TRUE))
	
	(cs_go_to pts_marines_warthog/p7 2)
	(cs_go_to pts_marines_warthog/p4 2)
	(cs_go_to pts_marines_warthog/p3 2)
	(wake warthog_explosion_intro)
	(cs_go_to pts_marines_warthog/p2 2)
	(wake warthog_explosion)

	
	;(damage_object objects\weapons\grenade\frag_grenade\damage_effects\frag_grenade_explosion (ai_vehicle_get_from_starting_location warthog_0/driver))
	;(damage_new objects\weapons\grenade\frag_grenade\damage_effects\frag_grenade_explosion warthog_explosion)
	;(damage_new objects\vehicles\wraith\damage_effects\wraith_mortar warthog_explosion)
	;(cs_go_to pts_marines_warthog/p1)
)

;Sgt johnson hops into the warthog as a gunner and shoots everything in his sight
(script command_script cs_johnson_gunner
	(cs_enable_pathfinding_failsafe true)
	(cs_enable_moving true)
	(cs_enable_targeting true)
	(cs_enable_looking true)
	(cs_enable_dialogue true)	
	
	(cs_go_to pts_marines_warthog/p7)
	
	(sleep_until (= (volume_test_objects vol_g (ai_vehicle_get_from_starting_location warthog_0/driver)) TRUE))
		
	;Try to enter the warthog until he gets in
	(sleep_until 
		(begin
			(ai_vehicle_enter mar_sgt_johnson (ai_vehicle_get_from_starting_location warthog_0/driver) "warthog_g")
			(= (unit_in_vehicle (unit (ai_get_object mar_sgt_johnson))) FALSE)
		)
	30 900)
	
	(sleep_forever)
)

(script command_script cs_banshee_0
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_shoot TRUE)
	(cs_enable_moving TRUE)
	(cs_enable_looking TRUE)
	(cs_vehicle_boost TRUE)
	;(sleep_forever)
	;(sleep_until (< (objects_distance_to_object (players) (ai_get_object ai_current_actor)) 50))
	(cs_fly_by pts_banshees_0/p0)
	(cs_fly_by pts_banshees_0/p2)
	(cs_vehicle_boost FALSE)
	;(cs_shoot_point TRUE pts_banshees_0/shoot_at_0)
	(cs_fly_by pts_banshees_0/p3)
	(cs_fly_by pts_banshees_0/p4)
	
	(sleep_until
		(begin
			(cs_fly_by pts_banshees_0/p5)
			(cs_fly_by pts_banshees_0/p6)
			;(cs_shoot_point TRUE pts_banshees_0/shoot_at_1)
			(cs_fly_by pts_banshees_0/p7)
			(cs_fly_by pts_banshees_0/p8)
			(= var_player_got_in_warthog TRUE)
		)
	)
	
	(cs_fly_by pts_banshees_0/p9)
	;(cs_shoot TRUE (ai_vehicle_get_from_starting_location warthog_0/driver))
	;(sleep_forever)
)

(script command_script cs_banshee_1
	(cs_enable_pathfinding_failsafe TRUE)
	(cs_enable_targeting TRUE)
	(cs_shoot TRUE)
	(cs_enable_moving TRUE)
	(cs_enable_looking TRUE)
	(cs_vehicle_boost TRUE)
	(cs_fly_by pts_banshees_0/p0)
	(cs_fly_by pts_banshees_0/p1)
	(cs_vehicle_boost FALSE)
)

;Starting script so that the elite in the tunnel sees outside
(script command_script cs_tunnel_elite_watch
	(cs_abort_on_combat_status ai_combat_status_active)
	(cs_movement_mode ai_movement_combat)
	(cs_go_to pts_tunnel_elite/p0)
	(cs_face TRUE pts_tunnel_elite/look_at)
	(sleep_forever)
)

;Starting scripts so that the jackals on the beach see the players arrive
(script command_script cs_tunnel_jackal_watch_0
	(cs_abort_on_combat_status ai_combat_status_active)
	(cs_movement_mode ai_movement_combat)
	(cs_go_to pts_beach_cov/p0)
	(cs_face TRUE pts_beach_cov/look_at_0)
	(sleep_forever)
)
(script command_script cs_tunnel_jackal_watch_1
	(cs_abort_on_combat_status ai_combat_status_active)
	(cs_movement_mode ai_movement_combat)
	(cs_go_to pts_beach_cov/p1)
	(cs_face TRUE pts_beach_cov/look_at_1)
	(sleep_forever)
)

;Starting script so that the elite in the crack on the beach waits for the player
(script command_script cs_beach_elite_ambush
	(cs_abort_on_combat_status ai_combat_status_active)
	(cs_movement_mode ai_movement_combat)
	(cs_go_to pts_beach_cov/p2)
	(sleep 60)
	(cs_go_to pts_beach_cov/p3)
	(sleep_forever)
)

;Switch to that script to end a command script on a squad
(script command_script cs_exit
	(sleep 1)
)