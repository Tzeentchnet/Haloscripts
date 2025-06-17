;=============================================================================================================================
;================================================== GLOBALS ==================================================================
;=============================================================================================================================

;*(global boolean g_su_wave_spawn TRUE)
(global short g_survival_wave 0)
(global short g_skull 0)
(global short round_number 0)
(global short g_set_all 24)
(global short g_su_wave_limit 0)
(global short g_su_wave_count 0)
(global short g_wave_timer 0)

; starting player pitch 
(global short g_player_start_pitch -16)

;=============================================================================================================================
;============================================== STARTUP SCRIPTS ==============================================================
;=============================================================================================================================

(script static void launch_survival_mode

	(wake start_survival)
)

;=============================================================================================================================
;============================================ SURVIVAL SCRIPTS ===============================================================
;=============================================================================================================================

;starting up survival mode
(script dormant start_survival
	(fade_out 0 0 0 0)

	(wake survival_difficulty)
	(wake survival_timer)
	(cond
		((<= (game_difficulty_get) normal) (survival_mode_lives_set 20))
		((= (game_difficulty_get) heroic) (survival_mode_lives_set 15))
		((= (game_difficulty_get) legendary) (survival_mode_lives_set 10))
	)
	
	(print "L200 Survival")
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(print "switching zone sets...")
			(switch_zone_set pipe_room)
		)
	)
	(sleep 1)

	; snap to black 
	;(cinematic_snap_to_black)

		(sleep 1)

			; set player pitch 
			(player0_set_pitch g_player_start_pitch 0)
			(player1_set_pitch g_player_start_pitch 0)
			(player2_set_pitch g_player_start_pitch 0)
			(player3_set_pitch g_player_start_pitch 0)
				(sleep 1)

	;(cinematic_fade_to_gameplay)
	(fade_in 0 0 0 30)
	
	(sleep 120)
	(ai_place sq_survival_intro01)
	(ai_place sq_survival_intro02)
	(ai_place sq_survival_intro03)

	(sleep_until 
		(begin
			(print "waiting for living count to go to 0")
			(and
				(= (ai_living_count sq_survival_intro01) 0)
				(= (ai_living_count sq_survival_intro02) 0)
				(= (ai_living_count sq_survival_intro03) 0)
			)
		)
	)	
	;(wake players_alive)
	(wake survival_mode_round)
	(sleep_forever)
)


;displaying round and skull information in the CHUD
(script dormant survival_mode_round
	(sleep_until
		(begin			
			(sleep 60)
			(cinematic_set_chud_objective begin_round)
				(ai_su_wave_spawner
								sq_survival_wave1a
								sq_survival_wave1b
								sq_survival_wave1c
								sq_survival_wave1d
								sq_survival_wave1e
				)
				(garbage_collect_now)
			(cinematic_set_chud_objective wave_complete)
				(ai_su_wave_spawner
								sq_survival_wave2a
								sq_survival_wave2b
								sq_survival_wave2c
								sq_survival_wave2d
								sq_survival_wave2e
				)
				(garbage_collect_now)
			(cinematic_set_chud_objective wave_complete)
				(ai_su_wave_spawner
								sq_survival_wave3a
								sq_survival_wave3b
								sq_survival_wave3c
								sq_survival_wave3d
								sq_survival_wave3e
				)
				(garbage_collect_now)
			(cinematic_set_chud_objective wave_complete)	
				(ai_su_wave_spawner
								sq_survival_wave4a
								sq_survival_wave4b
								sq_survival_wave4c
								sq_survival_wave4d
								sq_survival_wave4e
				)
				(garbage_collect_now)
			(cinematic_set_chud_objective wave_complete)	
				(ai_su_wave_spawner
								sq_survival_wave5a
								sq_survival_wave5b
								sq_survival_wave5c
								sq_survival_wave5d
								sq_survival_wave5e
				)
				(garbage_collect_now)
			(cinematic_set_chud_objective round_complete)
			
			(sleep 90)
			(if (< round_number 5)
				(BEGIN
					(set round_number (+ round_number 1))
					(cond
						((= round_number 1)
							(begin
								(skull_primary_enable skull_famine 1)
								(cinematic_set_chud_objective skull_famine)
							)
						)
						((= round_number 2)
							(begin
								(skull_primary_enable skull_tilt 1)
								(skull_primary_enable skull_famine 0)
								(cinematic_set_chud_objective skull_tilt)
							)
						)
						((= round_number 3)
							(begin
								(skull_primary_enable skull_thunderstorm 1)
								(skull_primary_enable skull_tilt 0)
								(cinematic_set_chud_objective skull_thunderstorm)
							)
						)
						((= round_number 4)
							(begin
								(skull_primary_enable skull_mythic 1)
								(skull_primary_enable skull_thunderstorm 0)
								(cinematic_set_chud_objective skull_mythic)
							)
						)
						((= round_number 5)
							(begin
								(skull_primary_enable skull_mythic 0)
							)
						)
					)
				)
			)
			(sleep 90)
			(if (= round_number 5)
				(begin					
					(cond
						((= g_skull 0)
							(begin
								(skull_primary_enable skull_black_eye 1)
								(cinematic_set_chud_objective skull_black_eye)
							)
						)
						((= g_skull 1)
							(begin
								(skull_primary_enable skull_catch 1)
								(skull_primary_enable skull_black_eye 0)
								(cinematic_set_chud_objective skull_catch)
							)
						)
						((= g_skull 2)
							(begin
								(skull_primary_enable skull_tough_luck 1)
								(skull_primary_enable skull_catch 0)
								(cinematic_set_chud_objective skull_tough)
							)
						)
						((= g_skull 3)
							(begin
								(skull_primary_enable skull_black_eye 1)
								(skull_primary_enable skull_catch 1)
								(skull_primary_enable skull_tough_luck 0)
								(cinematic_set_chud_objective skull_black_catch)
							)
						)
						((= g_skull 4)
							(begin
								(skull_primary_enable skull_black_eye 1)
								(skull_primary_enable skull_catch 1)
								(skull_primary_enable skull_tough_luck 1)
								(cinematic_set_chud_objective skull_black_catch_tough)
							)
						)
					)
					(set round_number 0)
					(set g_skull (+ g_skull 1))
				)
			)
			(sleep 120)
			(set g_survival_wave 0)
		FALSE)	
	1)
)


;script function for wave of survival mode
(script static void (ai_su_wave_spawner
								(ai squad_01)
								(ai squad_02)
								(ai squad_03)
								(ai squad_04)
								(ai squad_05)
				)

	(set g_survival_wave (+ g_survival_wave 1))

	(sleep_until 
		(begin
			(begin_random
				(if g_su_wave_spawn (ai_su_wave squad_01))
				(if g_su_wave_spawn (ai_su_wave squad_02))
				(if g_su_wave_spawn (ai_su_wave squad_03))
				(if g_su_wave_spawn (ai_su_wave squad_04))
				(if g_su_wave_spawn (ai_su_wave squad_05))
			)
		(= g_su_wave_spawn 0))
	)
	
	(sleep 1)
		
	(set g_su_wave_spawn TRUE)
	(set g_su_wave_count 0)
	
	(sleep 1)
	(sleep_until (<= (ai_living_count ai_survival) 0))
	(sleep g_wave_timer)
)




(script dormant survival_difficulty
	(cond
		((<= (game_difficulty_get) normal) (set g_su_wave_limit 3))
		((= (game_difficulty_get) heroic) (set g_su_wave_limit 4))
		((= (game_difficulty_get) legendary) (set g_su_wave_limit 5))
	)
)

(script dormant survival_timer
	(cond
		((<= (game_difficulty_get) normal) (set g_wave_timer (* 30 10)))
		((= (game_difficulty_get) heroic) (set g_wave_timer (* 30 5)))
		((= (game_difficulty_get) legendary) (set g_wave_timer 0))
	)
)

(script static void (ai_su_wave (ai spawned_squad))
	(ai_place spawned_squad)
	(sleep 1)
	(if (> (ai_living_count spawned_squad) 0)
		(begin
			(set g_su_wave_count (+ g_su_wave_count 1))
			(if (= g_su_wave_limit g_su_wave_count) (set g_su_wave_spawn FALSE))
		)
	)
)

)