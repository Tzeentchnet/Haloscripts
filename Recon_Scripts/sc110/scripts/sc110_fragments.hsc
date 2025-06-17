(script static boolean obj_ptasks_0_3
(>= g_pod_01_obj_control 3))

(script static boolean obj_ptasks_0_8
(>= g_pod_01_obj_control 1))

(script static boolean obj_ptasks_0_9
(volume_test_players tv_ghost_defence))

(script static boolean obj_ptasks_0_10
(>= g_pod_01_obj_control 2))

(script static boolean obj_ptasks_0_11
(< g_pod_01_obj_control 3))

(script static boolean obj_ptasks_0_12
(>= g_pod_01_obj_control 2))

(script static boolean obj_prtask_0_13
(>= g_pod_01_obj_control 1))

(script static boolean obj_ptasks_0_23
(< g_pod_01_obj_control 2))

(script static boolean obj_ptasks_0_26
(>= g_pod_01_obj_control 3))

(script static boolean obj_ptasks_0_29
(or (>= g_pod_01_obj_control 4) (<= (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 0)))

(script static boolean obj_ptasks_0_33
(<= (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 2))

(script static boolean obj_ptasks_0_36
(> (ai_task_count obj_pod_01_cov/gt_pod_01_wraith) 2))

(script static boolean obj_ptasks_1_7
(>= g_pod_01_obj_control 2))

(script static boolean obj_ptasks_1_12
(= g_pod_01_obj_control 0))

(script static boolean obj_ptasks_1_14
(= g_pod_01_obj_control 0))

(script static boolean obj_ptasks_2_2
(>= g_pod_02_obj_control 1))

(script static boolean obj_ptasks_2_4
(>= g_pod_02_obj_control 2))

(script static boolean obj_ptasks_2_10
(>= g_pod_02_obj_control 2))

(script static boolean obj_ptasks_2_12
(= g_pod_02_obj_control 3))

(script static boolean obj_prtask_2_19
(< g_pod_02_obj_control 2))

(script static boolean obj_ptasks_2_22
(>= g_pod_02_obj_control 4))

(script static boolean obj_ptasks_2_23
(>= g_pod_02_obj_control 2))

(script static boolean obj_ptasks_2_24
(or (>= g_pod_02_obj_control 4) (<= (ai_task_count obj_pod_02_cov/gt_pod_02_shade) 2)))

(script static boolean obj_ptasks_2_26
(= g_pod_02_ghost_escape 1))

(script static boolean obj_ptasks_2_31
(< g_pod_02_obj_control 2))

(script static boolean obj_prtask_4_6
(or (>= g_pod_03_obj_control 2) (= g_pod_02_ghost_escape 2)))

(script static boolean obj_pwtask_4_14
(< g_pod_03_obj_control 3))

(script static boolean obj_pdtask_4_15
(or (> (ai_task_count obj_pod_03_cov/gt_pod_03_ghost) 0) (= (ai_task_count obj_pod_03_cov/gt_pod_03_chopper) 3)))

(script static boolean obj_ptasks_4_29
(< g_pod_03_obj_control 1))

(script static boolean obj_ptasks_4_30
(>= g_pod_03_obj_control 3))

(script static boolean obj_ptasks_4_32
(< g_pod_03_obj_control 1))

(script static boolean obj_ptasks_5_6
(= (ai_task_count obj_pod_03_cov/gt_pod_03_shade) 4))

(script static boolean obj_ptasks_5_8
(<= g_pod_03_obj_control 1))

(script static boolean obj_ptasks_5_9
(> (ai_task_count obj_pod_03_cov/gt_pod_03_wraith) 0))

(script static boolean obj_ptasks_5_11
(<= g_pod_03_obj_control 1))

(script static boolean obj_ptasks_5_13
(< g_pod_03_obj_control 1))

(script static boolean obj_ptasks_5_14
(> (ai_task_count obj_pod_03_cov/gt_pod_03_shade) 2))

(script static boolean obj_ptasks_5_15
(<= g_pod_03_obj_control 1))

(script static boolean obj_ptasks_6_3
(>= g_pod_04_obj_control 1))

(script static boolean obj_ptasks_6_4
(>= g_pod_04_obj_control 1))

(script static boolean obj_ptasks_6_6
(>= g_pod_04_obj_control 3))

(script static boolean obj_ptasks_6_8
(>= g_pod_04_obj_control 3))

(script static boolean obj_ptasks_6_11
(>= g_pod_04_obj_control 3))

(script static boolean obj_pwwtas_6_18
(>= g_pod_04_obj_control 2))

(script static boolean obj_ptasks_6_19
(>= g_pod_04_obj_control 4))

(script static boolean obj_ptasks_7_1
(>= g_pod_04_obj_control 5))

(script static boolean obj_ptasks_7_2
(>= g_pod_04_obj_control 5))

(script static boolean obj_ptasks_8_3
(>= g_pod_04_obj_control 6))

(script static boolean obj_ptasks_8_4
(>= g_pod_04_obj_control 4))

(script static boolean obj_ptasks_8_7
(>= g_pod_04_obj_control 5))

(script static boolean obj_ptasks_8_8
(>= g_pod_04_obj_control 5))

(script static boolean obj_ptasks_8_11
(<= g_pod_04_obj_control 4))

(script static boolean obj_ptasks_8_12
(>= g_pod_04_obj_control 1))

(script static boolean obj_ptasks_8_14
(>= g_pod_04_obj_control 5))

(script static boolean obj_ptasks_8_17
(>= g_pod_04_obj_control 6))

(script static boolean obj_ptasks_9_10
(< g_pod_04_obj_control 7))

(script static boolean obj_ptasks_9_11
(< g_pod_04_obj_control 7))

(script static boolean obj_ptasks_9_15
(and (volume_test_players tv_pod_04_exit_south) (>= g_pod_04_obj_control 7)))

(script static boolean obj_ptasks_9_16
(and (volume_test_players tv_pod_04_exit_north) (>= g_pod_04_obj_control 7)))

