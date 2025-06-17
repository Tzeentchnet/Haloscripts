(script static boolean trainfirst_0_0
(< g_train01_obj_control 2))

(script static boolean traindespe_0_7
(> g_train01_obj_control 0))

(script static boolean trainreinf_1_1
(or (= (ai_living_count Training02_Squad01) 0) (>= g_train02_obj_control 2)))

(script static boolean trainfirst_1_3
(and (>= (ai_living_count Training02_Squad01) 2) (< g_train02_obj_control 2)))

(script static boolean trainfirst_1_5
(< g_train02_obj_control 3))

(script static boolean trainflank_1_8
(< g_train02_obj_control 5))

(script static boolean trainturre_1_9
(= (ai_living_count Training02_Squad04) 1))

(script static boolean trainsleep_1_13
(or (< (ai_task_status training02_objective/b_attack01) 1) (< g_train02_obj_control 1)))

(script static boolean trainbrute_1_14
(or (> g_train02_obj_control 0) (< (ai_living_count Training02_Squad01) 5)))

(script static boolean trainfirst_2_0
(< g_train03_obj_control 2))

(script static boolean trainfirst_2_1
(< g_train03_obj_control 2))

(script static boolean trainsecon_2_2
(< g_train03_obj_control 3))

(script static boolean trainsecon_2_3
(< g_train03_obj_control 3))

(script static boolean traingrunt_3_3
(>= g_train04_obj_control 2))

(script static boolean traingrunt_3_8
(>= g_train04_obj_control 2))

(script static boolean traingrunt_3_17
(and (< g_train04_obj_control 2) (> (ai_living_count Training04_Marines01) 0)))

(script static boolean trainbrute_3_18
(volume_test_players enc_training04_side_left))

(script static boolean trainbrute_3_19
(volume_test_players enc_training04_side_right))

(script static boolean trainhunte_3_24
(volume_test_players hunter_follow_vol))

(script static boolean traingloba_3_26
(>= g_train04_obj_control 3))

