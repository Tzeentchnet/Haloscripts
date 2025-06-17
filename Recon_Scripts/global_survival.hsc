;=============================================================================================================================
;================================================== GLOBALS ==================================================================
;=============================================================================================================================

; sets how many ai can be alive before the next wave will spawn 
(global short k_sur_ai_limit 0)

; controls the spawning of squads per wave 
(global short k_sur_squad_per_wave_limit 0)
(global short s_sur_squad_count 0)
(global boolean b_sur_squad_spawn TRUE)

; controls the number of waves per round 
(global short k_sur_wave_per_round_limit 0)
(global boolean b_sur_wave_phantom FALSE)

; controls the number of rounds per set 
(global short k_sur_round_per_set_limit 0)
(global boolean b_sur_round_spawn TRUE)

(global short k_sur_wave_timer 0)
(global short k_sur_wave_timeout 0)
(global short k_sur_round_timer 0)
(global short k_sur_set_timer 0)

; define the type of wave being spawned 
;	1 - initial 
;	2 - random 
;	3 - final 
(global short s_sur_wave_type 0)


; music definitions 
(global looping_sound m_survival_start "sound\music\amb\spooky\shiny\shiny")
(global looping_sound m_new_set "sound\music\cpaul\taiko_survival\taiko_survival")
(global looping_sound m_initial_wave "sound\music\cpaul\taiko_survival\taiko_survival")
(global looping_sound m_final_wave "sound\music\cpaul\drum3_2\drum3_2")
(global looping_sound m_pgcr "sound\music\amb\spooky\shiny\shiny")

;*

- possible music triggers 
	* beginning of the match 
	* start of a new set 
	* final wave of a set 
	* pgcr 

*;


; ===================================================================
; ===================================================================
; ==== squad variable definitions are at the bottom of this file ====
; ===================================================================
; ==== squad variable definitions are at the bottom of this file ====
; ===================================================================
; ==== squad variable definitions are at the bottom of this file ====
; ===================================================================
; ===================================================================



;=============================================================================================================================
;============================================ SURVIVAL CONSTANTS =============================================================
;=============================================================================================================================

; sets the number of squads per wave based on difficulty 
(script static void survival_squad_limit
	; number of squads per wave 
	(cond
		((<= (game_difficulty_get) normal)		(set k_sur_squad_per_wave_limit 4))
		((= (game_difficulty_get) heroic)		(set k_sur_squad_per_wave_limit 5))
		((= (game_difficulty_get) legendary)	(set k_sur_squad_per_wave_limit 6))
	)
	
	; number of phantoms per wave 
	(cond
		((<= (game_difficulty_get) normal)		(set k_phantom_spawn_limit 1))
		((= (game_difficulty_get) heroic)		(set k_phantom_spawn_limit 2))
		((= (game_difficulty_get) legendary)	(set k_phantom_spawn_limit 2))
	)
)

; setting the number of random waves per round based on difficulty 
(script static void survival_wave_limit
	(cond
		((<= (game_difficulty_get) normal)
										(begin
											(survival_mode_set_waves_per_round 3)
											(set k_sur_wave_per_round_limit 3)
										)
		)
		((= (game_difficulty_get) heroic)
										(begin
											(survival_mode_set_waves_per_round 4)
											(set k_sur_wave_per_round_limit 4)
										)
		)
		((= (game_difficulty_get) legendary)
										(begin
											(survival_mode_set_waves_per_round 5)
											(set k_sur_wave_per_round_limit 5)
										)
		)
	)
)

; setting the number of rounds per set based on difficulty 
(script static void survival_round_limit
	(cond
		((<= (game_difficulty_get) normal)
										(begin
											(survival_mode_set_rounds_per_set 3)
											(set k_sur_round_per_set_limit 3)
										)
		)
		((= (game_difficulty_get) heroic)
										(begin
											(survival_mode_set_rounds_per_set 4)
											(set k_sur_round_per_set_limit 4)
										)
		)
		((= (game_difficulty_get) legendary)
										(begin
											(survival_mode_set_rounds_per_set 5)
											(set k_sur_round_per_set_limit 5)
										)
		)
	)
)


; number of ai left before the next wave will spawn 
(script static void survival_ai_limit
	(cond
		((<= (game_difficulty_get) normal)		(set k_sur_ai_limit 1))
		((= (game_difficulty_get) heroic)		(set k_sur_ai_limit 2))
		((= (game_difficulty_get) legendary)	(set k_sur_ai_limit 3))
	)
)

; setting the timer between waves based on difficulty 
(script static void survival_wave_timeout
	(cond
		((<= (game_difficulty_get) normal)		(set k_sur_wave_timeout (* 30 30)))
		((= (game_difficulty_get) heroic)		(set k_sur_wave_timeout (* 30 30)))
		((= (game_difficulty_get) legendary)	(set k_sur_wave_timeout (* 30 30)))
	)
)

; setting the timer between waves based on difficulty 
(script static void survival_wave_timer
	(cond
		((<= (game_difficulty_get) normal)		(set k_sur_wave_timer (* 30 5)))
		((= (game_difficulty_get) heroic)		(set k_sur_wave_timer (* 30 5)))
		((= (game_difficulty_get) legendary)	(set k_sur_wave_timer (* 30 5)))
	)
)

; setting the timer between rounds based on difficulty 
(script static void survival_round_timer
	(cond
		((<= (game_difficulty_get) normal)		(set k_sur_round_timer (* 30 10)))
		((= (game_difficulty_get) heroic)		(set k_sur_round_timer (* 30 10)))
		((= (game_difficulty_get) legendary)	(set k_sur_round_timer (* 30 10)))
	)
)

; setting the timer between set based on difficulty 
(script static void survival_set_timer
	(cond
		((<= (game_difficulty_get) normal)		(set k_sur_set_timer (* 30 15)))
		((= (game_difficulty_get) heroic)		(set k_sur_set_timer (* 30 15)))
		((= (game_difficulty_get) legendary)	(set k_sur_set_timer (* 30 15)))
	)
)

; setting the number of lives based on difficulty 
(script static void survival_lives
	(cond
		((<= (game_difficulty_get) normal)		(survival_mode_lives_set 10))
		((= (game_difficulty_get) heroic)		(survival_mode_lives_set 10))
		((= (game_difficulty_get) legendary)	(survival_mode_lives_set 10))
	)
)

; adding additional lives as rounds are completed based on difficulty 
; do not add lives for the last round of a set 
(script static void survival_add_lives
	(if (< (survival_mode_round_get) k_sur_round_per_set_limit)
		(begin
			(cond
				((<= (game_difficulty_get) normal)		(survival_mode_lives_set (+ (survival_mode_lives_get) 5)))
				((= (game_difficulty_get) heroic)		(survival_mode_lives_set (+ (survival_mode_lives_get) 5)))
				((= (game_difficulty_get) legendary)	(survival_mode_lives_set (+ (survival_mode_lives_get) 5)))
			)
			
			; announce ---- ADD LIVES ---- 
			(survival_mode_event_new survival_awarded_lives)
		)
	)
)

(global long g_survival_previous_set_total 0)
(global long g_survival_total_points 0)

; add additional lives at the end of a set based on performance (points scored per set) 
; do not award bonus lives on the first set 
(script static void survival_bonus_lives
;	(if (> (survival_mode_set_get) 1)
;		(begin
			; set point total 
			(set g_survival_total_points	(+
										(campaign_metagame_get_player_score (player0))
										(campaign_metagame_get_player_score (player1))
										(campaign_metagame_get_player_score (player2))
										(campaign_metagame_get_player_score (player3))
									)
			)
			(sleep 1)
			
			; award lives based on points scored __THIS__ set 
			(cond
				((>= (- g_survival_total_points g_survival_previous_set_total) 150000) (survival_mode_lives_set (+ (survival_mode_lives_get) 25)))
				((>= (- g_survival_total_points g_survival_previous_set_total) 100000) (survival_mode_lives_set (+ (survival_mode_lives_get) 20)))
;				((>= (- g_survival_total_points g_survival_previous_set_total) 90000) (survival_mode_lives_set (+ (survival_mode_lives_get) 16)))
;				((>= (- g_survival_total_points g_survival_previous_set_total) 60000) (survival_mode_lives_set (+ (survival_mode_lives_get) 14)))
				((>= (- g_survival_total_points g_survival_previous_set_total) 50000) (survival_mode_lives_set (+ (survival_mode_lives_get) 15)))
				(TRUE													(survival_mode_lives_set (+ (survival_mode_lives_get) 10)))
			)
			(sleep 1)
			; announce ---- ADD LIVES ---- 
			(survival_mode_event_new survival_awarded_lives)
			(sleep 1)
			
			; set previous set total to current total 
			(set g_survival_previous_set_total g_survival_total_points)
;		)
;	)
)

; set based multiplier 
(script static void survival_set_multiplier
	(cond
		((>= (survival_mode_set_get) 9) (survival_mode_set_multiplier_set 5))
		((>= (survival_mode_set_get) 8) (survival_mode_set_multiplier_set 4.5))
		((>= (survival_mode_set_get) 7) (survival_mode_set_multiplier_set 4))
		((>= (survival_mode_set_get) 6) (survival_mode_set_multiplier_set 3.5))
		((>= (survival_mode_set_get) 5) (survival_mode_set_multiplier_set 3))
		((>= (survival_mode_set_get) 4) (survival_mode_set_multiplier_set 2.5))
		((>= (survival_mode_set_get) 3) (survival_mode_set_multiplier_set 2))
		((>= (survival_mode_set_get) 2) (survival_mode_set_multiplier_set 1.5))
		((>= (survival_mode_set_get) 1) (survival_mode_set_multiplier_set 1))
	)
)


;=============================================================================================================================
;============================================ SURVIVAL SCRIPTS ===============================================================
;=============================================================================================================================

; MAIN SURVIVAL MODE SCRIPT 
(script dormant survival_mode
	; snap to black 
		(if (> (player_count) 0) (cinematic_snap_to_black))
	; start survival music 
	(sound_looping_start m_survival_start NONE 1)

	; set initial WAVE / ROUND / SET values to 0 
		(survival_mode_wave_set 0)
		(survival_mode_round_set 0)
		(survival_mode_set_set 0)

	; set initial limits based on difficulty level 
		(survival_squad_limit)
		(survival_wave_limit)
		(survival_round_limit)
		(survival_ai_limit)
		(survival_wave_timer)
		(survival_round_timer)
		(survival_set_timer)
		(survival_wave_timeout)
		(survival_lives)
		
	; fade to gameplay  
		(sleep (* 30 3))
		(if (> (player_count) 0) (cinematic_fade_to_gameplay))

	; announce survival mode 
	(sleep (* 30 2))
	(survival_mode_event_new survival_welcome)
	(sleep (* 30 2))

	; wake secondary scripts 
		(wake survival_lives_announcement)
		(wake survival_end_game)
	
	; begin delay timer 
	(sleep (* 30 3))
	
	; count this set for post mission carnage report 
	(survival_mode_begin_new_set)
	
	; stop opening music 
	(sound_looping_stop m_survival_start)
	
	; ==================================================================
	; ======= TESTER PERFORMANCE DEBUGGING =============================
	; ==================================================================
	(if survival_performance_mode (survival_mode_set_set 5))

	; main survival mode thread 
	; this script loops indefinitely based on the above parameters 
	(sleep_until
		(begin			
			; announce new set 
			(survival_begin_announcer)
				(sleep 1)
			
			; increment set number 
			(if debug (print "incrementing set number..."))
			(survival_mode_set_set (+ (survival_mode_set_get) 1))
			(survival_mode_begin_new_set)

			; activate skulls 
			(survival_activate_set_skulls)
			
			; increment set multiplier 
			(survival_set_multiplier)
			
				; round controller 
				(sleep_until
					(begin
				
						; announce new set 
						(survival_begin_announcer)
							(sleep 1)
							
						; increment the round number 
						(print "increment round number...")
						(survival_mode_round_set (+ (survival_mode_round_get) 1))
						(survival_mode_begin_new_round)

						; set the active skulls 
						(survival_activate_round_skulls)
	
						; ---------------------> SPAWN ALL KINDS OF SHIT TO KICK YOUR ASS!!!!!!!!!!!!! <---------------
							(survival_round_spawner)
						; ---------------------> SPAWN ALL KINDS OF SHIT TO KICK YOUR ASS!!!!!!!!!!!!! <---------------
						
						; reset wave number 
						(if debug (print "resetting wave number..."))
						(survival_mode_wave_set 0)

						; allow announcer to vocalize new round 
						(set b_survival_new_round TRUE)

						; add additional lives 
						(survival_add_lives)
						
						; sleep set amount of time [unless this is the last round] 
						(if (< (survival_mode_round_get) k_sur_round_per_set_limit)	(sleep k_sur_round_timer))
						
					; exit conditions 
					(>= (survival_mode_round_get) k_sur_round_per_set_limit))
				1)
			
			; reset round number 
			(if debug (print "reseting round number..."))
			(survival_mode_round_set 0)
			
			; respawn weapon objects 
			(survival_respawn_weapons)
			
			; award bonus lives 
			(survival_bonus_lives)
				
			; allow announcer to vocalize new set 
			(set b_survival_new_set TRUE)

			; sleep for set amount of time 
			(sleep k_sur_set_timer)
	
		FALSE)	
	1)
)

;============================================ ROUND SPAWNER ===============================================================

(script static void survival_round_spawner
		
	; reset wave number 
	(if debug (print "resetting wave variables..."))
	(set b_sur_round_spawn TRUE)
	(set s_sur_wave_type 0)

	; initial wave  ======================================================================================================
	; this wave always spawns 
		(if b_wave_initial_present
			(begin
				(if debug (print "spawn wave..."))
				(set s_sur_wave_type 1)
		
				; test to see if this wave uses a phantom to introduce ai into the space 
				(if b_wave_initial_phantom (set b_sur_wave_phantom TRUE))

				(f_survival_wave_spawner
										ai_initial_squad_01
										ai_initial_squad_02
										ai_initial_squad_03
										ai_initial_squad_04
										ai_initial_squad_05
										ai_initial_squad_06
										ai_initial_squad_07
										ai_initial_squad_08
				)
			)
		)

	; begin spawning random waves  =======================================================================================
	; ====================================================================================================================

	; random round spawner  
	(sleep_until
		(begin
			(begin_random

			; first random wave  ================================================
				(if (and b_sur_round_spawn b_wave_01_present)
					(begin
						; spawn waves (number based on difficulty) 
						(if debug (print "spawn wave..."))
						(set s_sur_wave_type 2)
						
						; test to see if this wave uses a phantom to introduce ai into the space 
						(if b_wave_01_phantom (set b_sur_wave_phantom TRUE))

						(f_survival_wave_spawner
											ai_wave_01_squad_01
											ai_wave_01_squad_02
											ai_wave_01_squad_03
											ai_wave_01_squad_04
											ai_wave_01_squad_05
											ai_wave_01_squad_06
											ai_wave_01_squad_07
											ai_wave_01_squad_08
						)
					)
				)
					
			; second random wave  ================================================
				(if (and b_sur_round_spawn b_wave_02_present)
					(begin
						; spawn waves (number based on difficulty) 
						(if debug (print "spawn wave..."))
						(set s_sur_wave_type 2)

						; test to see if this wave uses a phantom to introduce ai into the space 
						(if b_wave_02_phantom (set b_sur_wave_phantom TRUE))

						(f_survival_wave_spawner
											ai_wave_02_squad_01
											ai_wave_02_squad_02
											ai_wave_02_squad_03	
											ai_wave_02_squad_04
											ai_wave_02_squad_05		
											ai_wave_02_squad_06		
											ai_wave_02_squad_07		
											ai_wave_02_squad_08
						)
					)
				)
				
			; third random wave  ================================================
				(if (and b_sur_round_spawn b_wave_03_present)
					(begin
						; spawn waves (number based on difficulty) 
						(if debug (print "spawn wave..."))
						(set s_sur_wave_type 2)

						; test to see if this wave uses a phantom to introduce ai into the space 
						(if b_wave_03_phantom (set b_sur_wave_phantom TRUE))

						(f_survival_wave_spawner
											ai_wave_03_squad_01		
											ai_wave_03_squad_02		
											ai_wave_03_squad_03		
											ai_wave_03_squad_04
											ai_wave_03_squad_05		
											ai_wave_03_squad_06		
											ai_wave_03_squad_07		
											ai_wave_03_squad_08
						)
					)
				)
				
			; fourth random wave  ================================================
				(if (and b_sur_round_spawn b_wave_04_present)
					(begin
						; spawn waves (number based on difficulty) 
						(if debug (print "spawn wave..."))
						(set s_sur_wave_type 2)

						; test to see if this wave uses a phantom to introduce ai into the space 
						(if b_wave_04_phantom (set b_sur_wave_phantom TRUE))

						(f_survival_wave_spawner
											ai_wave_04_squad_01		
											ai_wave_04_squad_02		
											ai_wave_04_squad_03		
											ai_wave_04_squad_04
											ai_wave_04_squad_05		
											ai_wave_04_squad_06		
											ai_wave_04_squad_07		
											ai_wave_04_squad_08
						)
					)
				)
				
			; fifth random wave  ================================================
				(if (and b_sur_round_spawn b_wave_05_present)
					(begin
						; spawn waves (number based on difficulty) 
						(if debug (print "spawn wave..."))
						(set s_sur_wave_type 2)

						; test to see if this wave uses a phantom to introduce ai into the space 
						(if b_wave_05_phantom (set b_sur_wave_phantom TRUE))

						(f_survival_wave_spawner
											ai_wave_05_squad_01		
											ai_wave_05_squad_02		
											ai_wave_05_squad_03		
											ai_wave_05_squad_04
											ai_wave_05_squad_05		
											ai_wave_05_squad_06		
											ai_wave_05_squad_07		
											ai_wave_05_squad_08
						)
					)
				)
			)
				
		; end conditions 
		(= b_sur_round_spawn FALSE))
	1)
			
		; final wave  ======================================================================================================
		; this wave always spawns 
			(if b_wave_final_present
				(begin
					(if debug (print "spawn wave..."))
					(set s_sur_wave_type 3)
					(sound_looping_start m_final_wave NONE 1)
		
					; test to see if this wave uses a phantom to introduce ai into the space 
					(if b_wave_final_phantom (set b_sur_wave_phantom TRUE))

					(f_survival_wave_spawner
											ai_final_squad_01		
											ai_final_squad_02		
											ai_final_squad_03		
											ai_final_squad_04
											ai_final_squad_05		
											ai_final_squad_06		
											ai_final_squad_07		
											ai_final_squad_08
					)
					(sound_looping_stop m_final_wave)
				)
			)
)

;script function for a wave in survival mode 
(script static void (f_survival_wave_spawner
								(ai squad_01)		
								(ai squad_02)		
								(ai squad_03)		
								(ai squad_04)
								(ai squad_05)		
								(ai squad_06)		
								(ai squad_07)		
								(ai squad_08)
				)
				
	; announce new set 
	(survival_begin_announcer)
		(sleep 1)
	
	; increment the wave number 
	(print "increment wave number...")
	(survival_mode_wave_set (+ (survival_mode_wave_get) 1))
	(survival_mode_begin_new_wave)
	
		; spawn phantoms if this is a phantom wave 
		(if b_sur_wave_phantom (survival_phantom_spawner))
		
		; spawn squads randomly =================================================
		(begin_random
			(if b_sur_squad_spawn (f_survival_squad_spawner squad_01))
			(if b_sur_squad_spawn (f_survival_squad_spawner squad_02))
			(if b_sur_squad_spawn (f_survival_squad_spawner squad_03))
			(if b_sur_squad_spawn (f_survival_squad_spawner squad_04))
			(if b_sur_squad_spawn (f_survival_squad_spawner squad_05))
			(if b_sur_squad_spawn (f_survival_squad_spawner squad_06))
			(if b_sur_squad_spawn (f_survival_squad_spawner squad_07))
			(if b_sur_squad_spawn (f_survival_squad_spawner squad_08))
		)
		
	(sleep 1)
	
	; reset squad spawn variables to initial conditions 
		(set b_sur_squad_spawn TRUE)
		(set s_sur_squad_count 0)
		(sleep 1)

		; allow the phantom to move 
		(set b_phantom_move_out TRUE)
		
	; sleep until phantoms have dropped off their ai 
	(sleep_until (<= (ai_living_count gr_survival_phantom) (* k_phantom_spawn_limit 4)) 1)

	; sleep until all the ai for this wave are dead 
	; check the proper squad groups based on the type of wave 
	(cond 
		((= s_sur_wave_type 1)
							(begin
								(sleep_until (<= (ai_living_count gr_survival_initial_wave) k_sur_ai_limit))
								(sleep_until (<= (ai_living_count gr_survival_initial_wave) 0) 30 k_sur_wave_timeout)
							)
		)
		((= s_sur_wave_type 2)
							(begin
								(sleep_until (<= (ai_living_count gr_survival_random_wave) k_sur_ai_limit))
								(sleep_until (<= (ai_living_count gr_survival_random_wave) 0) 30 k_sur_wave_timeout)
							)
		)
		((= s_sur_wave_type 3)
							(begin
								(sleep_until (<= (ai_living_count gr_survival_final_wave) 2))
								(sound_looping_set_alternate m_final_wave TRUE)
								(sleep_until (<= (ai_living_count gr_survival_final_wave) 0))
							)
		)
	)
	
	; check to see if we want to turn random wave spawning off 
	(if (>= (+ (survival_mode_wave_get) 1) k_sur_wave_per_round_limit) (set b_sur_round_spawn FALSE))

	; announce wave over 
	(survival_end_announcer)
	
		; allow announcer to vocalize new wave 
		(set b_survival_new_wave TRUE)
		
		; reset phantom spawn variable 
		(set b_sur_wave_phantom FALSE)
		
		; prevent the phantom from moving 
		(set b_phantom_move_out FALSE)
		
		; reset phantom load count to 1 
		(set s_phantom_load_count 1)
		
	; sleep set amount of time [unless this is the last wave] 
	(if (< (survival_mode_wave_get) k_sur_wave_per_round_limit)	(sleep k_sur_wave_timer))
)


; === individual squad spawner ================================================

(script static void (f_survival_squad_spawner (ai spawned_squad))
	(ai_place spawned_squad)
	(sleep 1)
	(ai_force_active spawned_squad TRUE)
	(if (> (ai_living_count spawned_squad) 0)
		(begin
			(if debug (print "spawn squad..."))
			(set s_sur_squad_count (+ s_sur_squad_count 1))
			(if (>= s_sur_squad_count k_sur_squad_per_wave_limit) (set b_sur_squad_spawn FALSE))
			(sleep 1)

			; if using phantoms then put ai in the phantom 
			(if b_sur_wave_phantom	(f_survival_phantom_load spawned_squad))
		)
	)
)

;================================== PHANTOM SPAWNING / LOADING ================================================================

(global boolean b_wave_initial_phantom FALSE)
(global boolean b_wave_01_phantom FALSE)
(global boolean b_wave_02_phantom FALSE)
(global boolean b_wave_03_phantom FALSE)
(global boolean b_wave_04_phantom FALSE)
(global boolean b_wave_05_phantom FALSE)
(global boolean b_wave_final_phantom FALSE)

; global vehicles 
(global vehicle v_sur_phantom_01 NONE)
(global vehicle v_sur_phantom_02 NONE)
(global vehicle v_sur_phantom_03 NONE)
(global vehicle v_sur_phantom_04 NONE)

; phantom squad definitions 
(global ai ai_sur_phantom_01 NONE)
(global ai ai_sur_phantom_02 NONE)
(global ai ai_sur_phantom_03 NONE)
(global ai ai_sur_phantom_04 NONE)

; define how the phantoms are loaded 
; 1 - left 
; 2 - right 
; 3 - dual 

(global short s_sur_drop_side_01 0)
(global short s_sur_drop_side_02 0)
(global short s_sur_drop_side_03 0)
(global short s_sur_drop_side_04 0)

; phantom spawn logic controls 
(global boolean b_phantom_spawn TRUE)
(global short b_phantom_spawn_count 0)
(global short k_phantom_spawn_limit 0)

; allow phantom to move out 
(global boolean b_phantom_move_out FALSE)




; =============== phantom spawn script =============================================

; randomly pick from the available phantoms 
(script static void survival_phantom_spawner

	; spawn all phantoms 
	(sleep_until
		(begin
			(begin_random
				(if b_phantom_spawn		(f_survival_phantom_spawner ai_sur_phantom_01))
				(if b_phantom_spawn		(f_survival_phantom_spawner ai_sur_phantom_02))
				(if b_phantom_spawn		(f_survival_phantom_spawner ai_sur_phantom_03))
				(if b_phantom_spawn		(f_survival_phantom_spawner ai_sur_phantom_04))
			)
		(= b_phantom_spawn FALSE))
	1)

	; reset phantom spawn variables to initial conditions 
		(set b_phantom_spawn TRUE)
		(set b_phantom_spawn_count 0)
		(sleep 1)
)




; =============== phantom spawn script =============================================

; spawn a single phantom 
(script static void (f_survival_phantom_spawner (ai spawned_phantom))
	(ai_place spawned_phantom)
	(sleep 1)
	(ai_force_active spawned_phantom TRUE)
	(if (> (object_get_health spawned_phantom) 0)
		(begin
			(if debug (print "spawn phantom..."))
			(set b_phantom_spawn_count (+ b_phantom_spawn_count 1))
			(if (>= b_phantom_spawn_count k_phantom_spawn_limit) (set b_phantom_spawn FALSE))
		)
	)
)


; =============== phantom load scripts =============================================

(global short s_phantom_load_count 1)		; tells me what phantom i'm loading  (1 - 4) 
(global boolean b_phantom_loaded FALSE)

; load up phantoms 
(script static void (f_survival_phantom_load
										(ai load_squad)
				)
	; pick what phantom to load 
	(if debug (print "attempt to load phantom..."))
	
	
	(sleep_until
		(begin
			; attempt to load phantom 01 
			(if (and (= b_phantom_loaded FALSE) (= s_phantom_load_count 1))
						(begin
							(if (> (object_get_health v_sur_phantom_01) 0) 	(f_load_phantom
																						v_sur_phantom_01
																						s_sur_drop_side_01
																						load_squad
																	)
							)
							(set s_phantom_load_count 2)
						)
			)
;			(sleep 1)
	
			; attempt to load phantom 02 
			(if (and (= b_phantom_loaded FALSE) (= s_phantom_load_count 2))
						(begin
							(if (> (object_get_health v_sur_phantom_02) 0) 	(f_load_phantom
																						v_sur_phantom_02
																						s_sur_drop_side_02
																						load_squad
																	)
							)
							(set s_phantom_load_count 3)
						)
			)
;			(sleep 1)
	
			; attempt to load phantom 03 
			(if (and (= b_phantom_loaded FALSE) (= s_phantom_load_count 3))
						(begin
							(if (> (object_get_health v_sur_phantom_03) 0) 	(f_load_phantom
																						v_sur_phantom_03
																						s_sur_drop_side_03
																						load_squad
																	)
							)
							(set s_phantom_load_count 4)
						)
			)
;			(sleep 1)
	
			; attempt to load phantom 04 
			(if (and (= b_phantom_loaded FALSE) (= s_phantom_load_count 4))
						(begin
							(if (> (object_get_health v_sur_phantom_04) 0) 	(f_load_phantom
																						v_sur_phantom_04
																						s_sur_drop_side_04
																						load_squad
																	)
							)
							(set s_phantom_load_count 1)
						)
			)
		b_phantom_loaded)
	1)

	; reset loaded variable 
	(set b_phantom_loaded FALSE)
)

(script static void	(f_load_phantom
								(vehicle phantom)
								(short load_side)
								(ai load_squad)
				)
				
	; left 
	(if (= load_side 1)
		(begin
			(if debug (print "load phantom left..."))
			(cond
				((= (vehicle_test_seat phantom "phantom_p_lb") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_lb"))
				((= (vehicle_test_seat phantom "phantom_p_lf") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_lf"))
				((= (vehicle_test_seat phantom "phantom_p_ml_f") FALSE)	(ai_vehicle_enter_immediate load_squad phantom "phantom_p_ml_f"))
				((= (vehicle_test_seat phantom "phantom_p_ml_b") FALSE)	(ai_vehicle_enter_immediate load_squad phantom "phantom_p_ml_b"))
			)
			; prevent further attempts to load phantoms 
			(set b_phantom_loaded TRUE)
		)
	)
;	(sleep 1)
	; right 
	(if (= load_side 2)
		(begin
			(if debug (print "load phantom right..."))
			(cond
				((= (vehicle_test_seat phantom "phantom_p_rb") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_rb"))
				((= (vehicle_test_seat phantom "phantom_p_rf") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_rf"))
				((= (vehicle_test_seat phantom "phantom_p_mr_f") FALSE)	(ai_vehicle_enter_immediate load_squad phantom "phantom_p_mr_f"))
				((= (vehicle_test_seat phantom "phantom_p_mr_b") FALSE)	(ai_vehicle_enter_immediate load_squad phantom "phantom_p_mr_b"))
			)
			
			; prevent further attempts to load phantoms 
			(set b_phantom_loaded TRUE)
		)
	)
;	(sleep 1)
	; dual 
	(if (= load_side 3)
		(begin
			(if debug (print "load phantom dual..."))
			(cond
				((= (vehicle_test_seat phantom "phantom_p_lf") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_lf"))
				((= (vehicle_test_seat phantom "phantom_p_rf") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_rf"))
				((= (vehicle_test_seat phantom "phantom_p_lb") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_lb"))
				((= (vehicle_test_seat phantom "phantom_p_rb") FALSE)		(ai_vehicle_enter_immediate load_squad phantom "phantom_p_rb"))
			)
			; prevent further attempts to load phantoms 
			(set b_phantom_loaded TRUE)
		)
	)
	
)


(script static void (f_survival_phantom_unload
										(vehicle phantom)
										(short drop_side)
				)
		
	; determine how to unload the phantom 
	(cond
		((= drop_side 1)	
						(begin
							(f_unload_phantom_left phantom)
							(sleep 45)
							(f_unload_phantom_mid_left phantom)
							(sleep 75)
						)
		)

		((= drop_side 2)	
						(begin
							(f_unload_phantom_right phantom)
							(sleep 45)
							(f_unload_phantom_mid_right phantom)
							(sleep 75)
						)
		)

		((= drop_side 3)
						(begin
							(f_unload_phantom_left phantom)
							(f_unload_phantom_right phantom)
							(sleep 75)
						)
		)
	)
	
)


(script static void (f_unload_phantom_left
										(vehicle phantom)
				)

	; randomly evacuate the two sides 
	(begin_random
		(begin
			(vehicle_unload phantom "phantom_p_lf")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload phantom "phantom_p_lb")
			(sleep (random_range 0 10))
		)
	)
)

(script static void (f_unload_phantom_right
										(vehicle phantom)
				)

	; randomly evacuate the two sides 
	(begin_random
		(begin
			(vehicle_unload phantom "phantom_p_rf")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload phantom "phantom_p_rb")
			(sleep (random_range 0 10))
		)
	)
)

(script static void (f_unload_phantom_mid_left
										(vehicle phantom)
				)

	; randomly evacuate the two sides 
	(begin_random
		(begin
			(vehicle_unload phantom "phantom_p_ml_f")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload phantom "phantom_p_ml_b")
			(sleep (random_range 0 10))
		)
	)
)

(script static void (f_unload_phantom_mid_right
										(vehicle phantom)
				)

	; randomly evacuate the two sides 
	(begin_random
		(begin
			(vehicle_unload phantom "phantom_p_mr_f")
			(sleep (random_range 0 10))
		)
		(begin
			(vehicle_unload phantom "phantom_p_mr_b")
			(sleep (random_range 0 10))
		)
	)
)





;===================================== BEGIN ANNOUNCER =======================================================================

; this script assumes that at the start of a SET the rounds and waves are set to -- 0 -- 
; also, at the start of a ROUND waves are set to -- 0 -- 

(global boolean b_survival_new_set TRUE)
(global boolean b_survival_new_round TRUE)
(global boolean b_survival_new_wave TRUE)

(script static void survival_begin_announcer
	(cond
		(b_survival_new_set				(begin
										(if debug (print "announce new set..."))
										(survival_countdown_timer)
										(survival_mode_event_new survival_new_set)
										(set b_survival_new_set FALSE)
										(set b_survival_new_round FALSE)
										(set b_survival_new_wave FALSE)
									)
		)
		(b_survival_new_round
									(begin
										(if debug (print "announce new round..."))
										(survival_countdown_timer)
										(survival_mode_event_new survival_new_round)
										(set b_survival_new_round FALSE)
										(set b_survival_new_wave FALSE)
									)
		)
		(b_survival_new_wave		
									(begin
										(if debug (print "announce new wave..."))
										(survival_countdown_timer)
										(survival_mode_event_new survival_new_wave)
									)
		)
	)
	(sleep 5)
)

;===================================== END ANNOUNCER =========================================================================

(script static void survival_end_announcer
	; delay before announcing 
	(sleep (* 30 5))
	
	(cond
		((< (survival_mode_wave_get) k_sur_wave_per_round_limit)				
										(begin
											(survival_mode_event_new survival_end_wave)
										)
		)
		((< (survival_mode_round_get) k_sur_round_per_set_limit)				
										(begin
											(survival_mode_event_new survival_end_round)
										)
		)
		(TRUE		
										(begin
											(survival_mode_event_new survival_end_set)
										)
		)
	)
	
	; delay before continuing 
	(sleep (* 30 3))
)

;===================================== COUNTDOWN TIMER =======================================================================

(script static void survival_countdown_timer
	(sound_impulse_start "sound\game_sfx\multiplayer\player_timer_beep"	NONE 1)
		(sleep 30)
	(sound_impulse_start "sound\game_sfx\multiplayer\player_timer_beep"	NONE 1)
		(sleep 30)
	(sound_impulse_start "sound\game_sfx\multiplayer\player_timer_beep"	NONE 1)
		(sleep 30)
	(sound_impulse_start "sound\game_sfx\multiplayer\countdown_timer"	NONE 1)
		(sleep 30)
)

;=============================================================================================================================
;============================================ ANNOUNCEMENT SCRIPTS ===========================================================
;=============================================================================================================================

(script dormant survival_lives_announcement
	(sleep_until
		(begin
			; sleep until lives are greater than ZERO 
			(sleep_until (> (survival_mode_lives_get) 0) 1)

			; sleep until lives below 5 
			(sleep_until (<= (survival_mode_lives_get) 5) 1)
			(if (= (survival_mode_lives_get) 5)	(begin
												(if debug (print "5 lives left..."))
												(survival_mode_event_new survival_5_lives_left)
											)
			)

			; sleep until lives below 1 or greater than 5 
			(sleep_until	(or
							(<= (survival_mode_lives_get) 1)
							(> (survival_mode_lives_get) 5)
						)
			1)
			(if (= (survival_mode_lives_get) 1)	(begin
												(if debug (print "1 life left..."))
												(survival_mode_event_new survival_1_life_left)
											)
			)

				
			; sleep until lives at 0 or greater than 1 
			(sleep_until	(or
							(<= (survival_mode_lives_get) 0)
							(> (survival_mode_lives_get) 1)
						)
			1)
			(if (<= (survival_mode_lives_get) 0)	(begin
												(if debug (print "0 lives left..."))
												(survival_mode_event_new survival_0_lives_left)
											)
			)
				
			; sleep until lives at 0 or greater than 1 
			(sleep_until	(or
							(<= (player_count) 1)
							(> (survival_mode_lives_get) 0)
						)
			1)
			(if	(and
					(<= (survival_mode_lives_get) 0)
					(= (player_count) 1)
				)
											(begin
												(if debug (print "last man standing..."))
												(survival_mode_event_new survival_last_man_standing)
											)
			)

		FALSE)
	)
)

;=============================================================================================================================
;============================================ SKULL SCRIPTS ==================================================================
;=============================================================================================================================

; setting round-based skulls on and off 
(script static void survival_activate_round_skulls
	; clear all skulls if set is 4 or less 
	(if 	(<= (survival_mode_set_get) 4)
			
			; increment through skulls for sets 1 - 4 
			(begin
				(skull_primary_enable skull_tough_luck 0)
				(skull_primary_enable skull_black_eye 0)
				(skull_primary_enable skull_catch 0)

				(cond		
					((= (survival_mode_round_get) 1)
												(begin
													(skull_primary_enable skull_tough_luck 1)
													(survival_mode_event_new survival_skull_tough_luck)
												)
					)
					((= (survival_mode_round_get) 2)
												(begin
													(skull_primary_enable skull_catch 1)
													(survival_mode_event_new survival_skull_catch)
												)
					)
					((= (survival_mode_round_get) 3)
												(begin
													(skull_primary_enable skull_black_eye 1)
													(survival_mode_event_new survival_skull_black_eye)
												)
					)
					((= (survival_mode_round_get) 4)
												(begin
													(skull_primary_enable skull_tough_luck 1)
													(survival_mode_event_new survival_skull_tough_luck)
			
													(skull_primary_enable skull_catch 1)
													(survival_mode_event_new survival_skull_catch)
												)
					)
					((= (survival_mode_round_get) 5)
												(begin
													(skull_primary_enable skull_tough_luck 1)
													(survival_mode_event_new survival_skull_tough_luck)
			
													(skull_primary_enable skull_catch 1)
													(survival_mode_event_new survival_skull_catch)
													
													(skull_primary_enable skull_black_eye 1)
													(survival_mode_event_new survival_skull_black_eye)
												)
					)
				)
			)
			
			; turn on all skulls after set 5 
			(begin
				(skull_primary_enable skull_tough_luck 1)
				(skull_primary_enable skull_catch 1)
				(skull_primary_enable skull_black_eye 1)
			)

	)
)


; setting set-based skulls on and off
(script static void survival_activate_set_skulls
	(cond
		((= (survival_mode_set_get) 2)
									(begin
										(skull_primary_enable skull_tilt 1)
										(survival_mode_event_new survival_skull_tilt)
									)
		)
		((= (survival_mode_set_get) 3)
									(begin
										(skull_primary_enable skull_famine 1)
										(survival_mode_event_new survival_skull_famine)
									)
		)
		((= (survival_mode_set_get) 4)
									(begin
										(skull_primary_enable skull_mythic 1)
										(survival_mode_event_new survival_skull_mythic)
									)
		)
		((>= (survival_mode_set_get) 5)
									(begin
										(skull_primary_enable skull_tilt 1)
										(skull_primary_enable skull_famine 1)
										(skull_primary_enable skull_mythic 1)
										
										; put announcement for all skulls here 
									)
		)
	)
)


;=============================================================================================================================
;============================================ WEAPON CRATE SCRIPTS ===========================================================
;=============================================================================================================================

; respawning weapon crates after round ends
(script static void survival_respawn_weapons
	(if debug (print "creating weapon crates..."))
	(survival_mode_event_new survival_awarded_weapon)
	
	; create all objects 
	(object_create_folder_anew sc_survival)
	(object_create_folder_anew cr_survival)
	(object_create_folder_anew v_survival)
)


;=============================================================================================================================
;============================================ END GAME SCRIPTS ===============================================================
;=============================================================================================================================
(global short s_survival_end_delay (* 30 5))

(script dormant survival_end_game
	(sleep_until
		(and
			(<= (survival_mode_lives_get) 0)
			
			(and
				(<= (object_get_health (player0)) 0)
				(<= (object_get_health (player1)) 0)
				(<= (object_get_health (player2)) 0)
				(<= (object_get_health (player3)) 0)
			)
		)
	1)

	; turn off all music 
	(sound_looping_stop m_final_wave)
		(sleep 30)
	(sound_looping_start m_pgcr NONE 1)
	
	; remind all players that they suck 
	(survival_mode_event_new survival_game_over)
	
	(sleep s_survival_end_delay)

		; fade out 
		(fade_out 0 0 0 15)
	
	(sleep s_survival_end_delay)
	
	; end game 
	(game_won)
)


;=============================================================================================================================
;============================================ SQUAD DEFINITIONS ==============================================================
;=============================================================================================================================

; DEFINE WHICH WAVES ARE PRESENT 
(global boolean b_wave_initial_present FALSE)
(global boolean b_wave_01_present FALSE)
(global boolean b_wave_02_present FALSE)
(global boolean b_wave_03_present FALSE)
(global boolean b_wave_04_present FALSE)
(global boolean b_wave_05_present FALSE)
(global boolean b_wave_final_present FALSE)


; INITIAL WAVE  
(global ai ai_initial_squad_01 NONE)
(global ai ai_initial_squad_02 NONE)
(global ai ai_initial_squad_03 NONE)
(global ai ai_initial_squad_04 NONE)
(global ai ai_initial_squad_05 NONE)
(global ai ai_initial_squad_06 NONE)
(global ai ai_initial_squad_07 NONE)
(global ai ai_initial_squad_08 NONE)

; WAVE 1 
(global ai ai_wave_01_squad_01 NONE)
(global ai ai_wave_01_squad_02 NONE)
(global ai ai_wave_01_squad_03 NONE)
(global ai ai_wave_01_squad_04 NONE)
(global ai ai_wave_01_squad_05 NONE)
(global ai ai_wave_01_squad_06 NONE)
(global ai ai_wave_01_squad_07 NONE)
(global ai ai_wave_01_squad_08 NONE)

; WAVE 2 
(global ai ai_wave_02_squad_01 NONE)
(global ai ai_wave_02_squad_02 NONE)
(global ai ai_wave_02_squad_03 NONE)
(global ai ai_wave_02_squad_04 NONE)
(global ai ai_wave_02_squad_05 NONE)
(global ai ai_wave_02_squad_06 NONE)
(global ai ai_wave_02_squad_07 NONE)
(global ai ai_wave_02_squad_08 NONE)

; WAVE 3 
(global ai ai_wave_03_squad_01 NONE)
(global ai ai_wave_03_squad_02 NONE)
(global ai ai_wave_03_squad_03 NONE)
(global ai ai_wave_03_squad_04 NONE)
(global ai ai_wave_03_squad_05 NONE)
(global ai ai_wave_03_squad_06 NONE)
(global ai ai_wave_03_squad_07 NONE)
(global ai ai_wave_03_squad_08 NONE)

; WAVE 4 
(global ai ai_wave_04_squad_01 NONE)
(global ai ai_wave_04_squad_02 NONE)
(global ai ai_wave_04_squad_03 NONE)
(global ai ai_wave_04_squad_04 NONE)
(global ai ai_wave_04_squad_05 NONE)
(global ai ai_wave_04_squad_06 NONE)
(global ai ai_wave_04_squad_07 NONE)
(global ai ai_wave_04_squad_08 NONE)

; WAVE 5 
(global ai ai_wave_05_squad_01 NONE)
(global ai ai_wave_05_squad_02 NONE)
(global ai ai_wave_05_squad_03 NONE)
(global ai ai_wave_05_squad_04 NONE)
(global ai ai_wave_05_squad_05 NONE)
(global ai ai_wave_05_squad_06 NONE)
(global ai ai_wave_05_squad_07 NONE)
(global ai ai_wave_05_squad_08 NONE)

; FINAL WAVE  
(global ai ai_final_squad_01 NONE)
(global ai ai_final_squad_02 NONE)
(global ai ai_final_squad_03 NONE)
(global ai ai_final_squad_04 NONE)
(global ai ai_final_squad_05 NONE)
(global ai ai_final_squad_06 NONE)
(global ai ai_final_squad_07 NONE)
(global ai ai_final_squad_08 NONE)


;=============================================================================================================================
;============================================ TEST SCRIPTS ===================================================================
;=============================================================================================================================

(script dormant test_ai_erase_fast
	(sleep_until
		(begin
			(sleep_until (>= (ai_living_count gr_survival_all) 1) 1)
			(sleep 5)
			(ai_erase_all)
		FALSE)
	1)
)
(script dormant test_ai_erase
	(sleep_until
		(begin
			(sleep_until (>= (ai_living_count gr_survival_all) 1) 1)
			(sleep 30)
			(ai_erase_all)
		FALSE)
	1)
)
(script dormant test_ai_erase_slow
	(sleep_until
		(begin
			(sleep_until (>= (ai_living_count gr_survival_all) 1) 1)
			(sleep 150)
			(ai_erase_all)
		FALSE)
	1)
)

(script static void test_award_500
	(campaign_metagame_award_points (player0) 500)
)
(script static void test_award_1000
	(campaign_metagame_award_points (player0) 1000)
)
(script static void test_award_5000
	(campaign_metagame_award_points (player0) 5000)
)
(script static void test_award_10000
	(campaign_metagame_award_points (player0) 10000)
)
(script static void test_award_20000
	(campaign_metagame_award_points (player0) 20000)
)
(script static void test_award_30000
	(campaign_metagame_award_points (player0) 30000)
)
