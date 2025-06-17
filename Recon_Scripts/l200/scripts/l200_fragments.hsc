(script static boolean labyrla_br_1_2
(<= (ai_living_count la_brute_01_forward) 1))

(script static boolean labyrlc_br_3_4
(= (ai_living_count lc_bugger_01) 1))

(script static boolean labyrlc_br_3_7
(<= (ai_living_count lc_brute_01) 2))

(script static boolean labyrlc_br_3_16
(<= (ai_living_count lc_brute_03) 2))

(script static boolean labyrlc_br_3_19
(<= (ai_living_count lc_brute_07) 1))

(script static boolean labyrlc_br_3_22
(<= (ai_living_count lc_brute_04) 1))

(script static boolean labyrlc_br_3_25
(<= (ai_living_count lc_brute_06) 1))

(script static boolean labyrld_br_4_4
(<= (ai_living_count ld_brute_01) 1))

(script static boolean labyrld_br_4_8
(<= (ai_living_count ld_brute_02) 1))

(script static boolean data_dr_br_6_4
(<= (ai_living_count dr_brute_01) 1))

(script static boolean dr_frdr_fo_8_1
(>= g_dr_obj_control 7))

(script static boolean dr_frdr_fo_8_2
(>= g_dr_obj_control 9))

(script static boolean dr_frdr_fo_9_1
(>= g_dr_obj_control 14))

(script static boolean dr_frdr_pl_9_2
(>= g_dr_obj_control 15))

(script static boolean data_dr_br_10_4
(<= (ai_living_count dr_brute_04) 2))

(script static boolean pipe_pr_lo_12_6
(<= (ai_task_count pipe_room_02/pr_lower_left_forward) 2))

(script static boolean pipe_pr_lo_12_9
(<= (ai_task_count pipe_room_02/pr_lower_right_forward) 2))

(script static boolean pipe_pr_da_12_13
(>= g_pr_obj_control 5))

(script static boolean pipe_pr_da_12_14
(>= g_pr_obj_control 6))

(script static boolean pipe_pr_da_12_15
(volume_test_players tv_pr_elevator_right))

(script static boolean pipe_pr_da_12_16
(volume_test_players tv_pr_elevator_left))

(script static boolean pipe_pr_ch_12_19
(<= (ai_task_count pipe_room_02/gate_pr_lower_area) 3))

(script static boolean pipe_pr_da_13_1
(>= g_pr_obj_control 9))

(script static boolean pipe_pr_da_13_2
(>= g_pr_obj_control 10))

(script static boolean pipe_pr_da_13_3
(>= g_pr_obj_control 12))

(script static boolean pipe_pr_da_13_4
(>= g_pr_obj_control 13))

(script static boolean data_dc_da_15_2
(>= g_dc_obj_control 4))

(script static boolean data_dc_da_15_3
(>= g_dc_obj_control 5))

(script static boolean data_dc_ch_15_11
(>= g_dc_obj_control 5))

(script static boolean data_dc_br_15_15
(>= g_dc_obj_control 5))

(script static boolean data_dc_da_16_2
(>= g_dc_obj_control 8))

(script static boolean data_dc_da_16_3
(>= g_dc_obj_control 9))

(script static boolean data_dc_da_17_2
(>= g_dc_obj_control 11))

(script static boolean data_dc_da_17_3
(>= g_dc_obj_control 12))

(script static boolean data_dc_en_17_9
(>= g_dc_obj_control 11))

(script static boolean data_dc_en_17_10
(>= g_dc_obj_control 12))

(script static boolean data_dc_bu_17_13
(>= g_dc_obj_control 12))

