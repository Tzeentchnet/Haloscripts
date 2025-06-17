(script static boolean cell_exit_0_4
(>= g_1a_obj_control 3))

(script static boolean banshbansh_1_3
(and (= banshee_rand_wave 0) (= wave_left TRUE)))

(script static boolean banshbackg_1_4
(and (= banshee_rand_wave 1) (= wave_center TRUE)))

(script static boolean banshbackg_1_5
(and (= banshee_rand_wave 2) (= wave_right TRUE)))

(script static boolean cell_jetpa_3_10
(< g_2a_obj_control 2))

(script static boolean marininiti_5_0
(= g_intro_obj_control 0))

(script static boolean marin01_5_1
(= g_intro_obj_control 1))

(script static boolean marin02_5_2
(= g_intro_obj_control 2))

(script static boolean marin03_5_3
(= g_intro_obj_control 3))

(script static boolean marininiti_5_4
(> g_intro_obj_control 0))

(script static boolean marincell__5_5
(> g_1a_obj_control 0))

(script static boolean marina01_5_6
(= g_1a_obj_control 1))

(script static boolean marina02_5_7
(= g_1a_obj_control 2))

(script static boolean marina03_5_8
(= g_1a_obj_control 3))

(script static boolean marina04_5_9
(= g_1a_obj_control 4))

(script static boolean marina01_l_5_10
(or (volume_test_players cell1a_right_area01) (volume_test_players cell1a_right_area02)))

(script static boolean marina01_r_5_11
(or (volume_test_players cell1a_left_area01) (volume_test_players cell1a_left_area02)))

(script static boolean marina02_l_5_12
(or (volume_test_players cell1a_right_area01) (volume_test_players cell1a_right_area02)))

(script static boolean marina02_r_5_13
(or (volume_test_players cell1a_left_area01) (volume_test_players cell1a_left_area02)))

(script static boolean marina03_l_5_14
(or (volume_test_players cell1a_right_area01) (volume_test_players cell1a_right_area02)))

(script static boolean marina03_r_5_15
(or (volume_test_players cell1a_left_area01) (volume_test_players cell1a_left_area02)))

(script static boolean marina01_c_5_16
(<= (ai_combat_status cell1a_group) 3))

(script static boolean marina02_c_5_17
(<= (ai_combat_status cell1a_group) 3))

(script static boolean marinb03_7_1
(or (= g_2b_obj_control 3) (= (ai_living_count cell2b_group) 0)))

(script static boolean marinb04_7_2
(= g_2b_obj_control 4))

(script static boolean marinb05_7_3
(= g_2b_obj_control 5))

(script static boolean marinb06_7_4
(= g_2b_obj_control 6))

(script static boolean marinb02_8_1
(= g_1b_obj_control 2))

(script static boolean marinb03_8_2
(= g_1b_obj_control 3))

(script static boolean marinb01_8_3
(= g_1b_obj_control 1))

(script static boolean marina01_9_0
(= g_2a_obj_control 1))

(script static boolean marina02_9_1
(>= g_2a_obj_control 2))

(script static boolean marina04_9_2
(= g_2a_obj_control 4))

(script static boolean marina0_9_3
(= g_2a_obj_control 0))

(script static boolean marincomba_9_4
(<= (ai_combat_status cell2a_group) 3))

(script static boolean survijet01_11_5
(= b_wave_04_present true))

(script static boolean survijet02_11_6
(= b_wave_04_present true))

(script static boolean survijet01_12_5
(= b_wave_04_present true))

(script static boolean survijet02_12_6
(= b_wave_04_present true))

