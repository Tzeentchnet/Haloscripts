(global ai v_olifaunt NONE)


(script dormant l300_insertion_stub
	(if debug (print "l300 insertion stub"))
)

;=========================================================================================
;================================ GLOBAL VARIABLES =======================================
;=========================================================================================
(global short g_set_all 1)

(script static void ins_level_start
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set h_100_010)
			(sleep 1)
		)
	)
	(sleep 1)
	; set insertion point index 
	(set g_insertion_index 1)
)
;=========================================================================================
;================================== LEVEL START =========================================
;=========================================================================================
(script static void ins_cell_1

	(object_teleport (player0) cell1_player0_flag)
	(object_teleport (player1) cell1_player1_flag)
	(object_teleport (player2) cell1_player2_flag)
	(object_teleport (player3) cell1_player3_flag)
	
	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)

	; set insertion point index 
	(set g_insertion_index 2)
	
)

;=========================================================================================
;================================== CELL 2 ==========================================
;=========================================================================================
(script static void ins_cell_2
	
	; set insertion point index 
	(set g_insertion_index 3)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)

	
	; teleporting players... to the proper location 
	(if debug (print "teleporting players to highway..."))
	(object_teleport (player0) cell2_player0_flag)
	(object_teleport (player1) cell2_player1_flag)
	(object_teleport (player2) cell2_player2_flag)
	(object_teleport (player3) cell2_player3_flag)
	
	(sleep 1)
	
	; placing allies...	
	(ai_place olifaunt/cell02)
	(set v_olifaunt olifaunt/cell02)
	(set obj_olifaunt (ai_get_object olifaunt/cell02))


	(sleep 1)
)

;=========================================================================================
;================================== CELL 3 ==========================================
;=========================================================================================
(script static void ins_cell_3
	
	; set insertion point index 
	(set g_insertion_index 4)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)

	
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell3_player0_flag)
	(object_teleport (player1) cell3_player1_flag)
	(object_teleport (player2) cell3_player2_flag)
	(object_teleport (player3) cell3_player3_flag)

	; placing allies... 
	(ai_place olifaunt/cell03)
	(set v_olifaunt olifaunt/cell03)
	(set obj_olifaunt (ai_get_object olifaunt/cell03))

	(sleep 1)
)

;=========================================================================================
;================================== CELL 4 ==========================================
;=========================================================================================
(script static void ins_cell_4
	
	; set insertion point index 
	(set g_insertion_index 5)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)

	
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell4_player0_flag)
	(object_teleport (player1) cell4_player1_flag)
	(object_teleport (player2) cell4_player2_flag)
	(object_teleport (player3) cell4_player3_flag)

	; placing allies... 
	(ai_place olifaunt/cell04)
	(set v_olifaunt olifaunt/cell04)
	(set obj_olifaunt (ai_get_object olifaunt/cell04))

	(sleep 1)
)

;=========================================================================================
;=================================== CELL 5 ==========================================
;=========================================================================================
(script static void ins_cell_5
	
	; set insertion point index 
	(set g_insertion_index 6)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)

	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell5_player0_flag)
	(object_teleport (player1) cell5_player1_flag)
	(object_teleport (player2) cell5_player2_flag)
	(object_teleport (player3) cell5_player3_flag)
	
	; placing allies...
	(ai_place olifaunt/cell05)
	(set v_olifaunt olifaunt/cell05)
	(set obj_olifaunt (ai_get_object olifaunt/cell05))
	
	(sleep 1)
)

;=========================================================================================
;=================================== CELL 6 ========================================
;=========================================================================================
(script static void ins_cell_6
	(set g_insertion_index 7)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)
	(object_teleport (player0) cell6_player0_flag)
	(object_teleport (player1) cell6_player1_flag)
	(object_teleport (player2) cell6_player2_flag)
	(object_teleport (player3) cell6_player3_flag)

	; placing allies...
	(ai_place olifaunt/cell06)
	(set v_olifaunt olifaunt/cell06)
	(set obj_olifaunt (ai_get_object olifaunt/cell06))
	
	(sleep 1)

)

;=========================================================================================
;=================================== CELL 7 =========================================
;=========================================================================================
(script static void ins_cell_7

	; set insertion point index 
	(set g_insertion_index 8)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)

		
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell7_player0_flag)
	(object_teleport (player1) cell7_player1_flag)
	(object_teleport (player2) cell7_player2_flag)
	(object_teleport (player3) cell7_player3_flag)

	; placing allies...
	(ai_place olifaunt/cell07)	
	(set v_olifaunt olifaunt/cell07)
	(set obj_olifaunt (ai_get_object olifaunt/cell07))
	
	(sleep 1)		
)

;=========================================================================================
;=================================== CELL 8 =========================================
;=========================================================================================
(script static void ins_cell_8

	; set insertion point index 
	(set g_insertion_index 9)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)

		
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell8_player0_flag)
	(object_teleport (player1) cell8_player1_flag)
	(object_teleport (player2) cell8_player2_flag)
	(object_teleport (player3) cell8_player3_flag)

	; placing allies...
	(ai_place olifaunt/cell08)	
	(set v_olifaunt olifaunt/cell08)
	(set obj_olifaunt (ai_get_object olifaunt/cell08))
	
	(sleep 1)		
)

;=========================================================================================
;=================================== CELL 9 =========================================
;=========================================================================================
(script static void ins_cell_9

	; set insertion point index 
	(set g_insertion_index 10)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)

		
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell9_player0_flag)
	(object_teleport (player1) cell9_player1_flag)
	(object_teleport (player2) cell9_player2_flag)
	(object_teleport (player3) cell9_player3_flag)

	; placing allies...
	(ai_place olifaunt/cell09)		
	(set v_olifaunt olifaunt/cell09)
	(set obj_olifaunt (ai_get_object olifaunt/cell09))
	
	(sleep 1)		
)

;=========================================================================================
;=================================== CELL 10 =========================================
;=========================================================================================
(script static void ins_cell_10

	; set insertion point index 
	(set g_insertion_index 11)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)

		
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell10_player0_flag)
	(object_teleport (player1) cell10_player1_flag)
	(object_teleport (player2) cell10_player2_flag)
	(object_teleport (player3) cell10_player3_flag)

	; placing allies...
	(ai_place olifaunt/cell10)		
	(set v_olifaunt olifaunt/cell10)
	(set obj_olifaunt (ai_get_object olifaunt/cell10))
	
	(sleep 1)		
)

;=========================================================================================
;=================================== CELL 11 =========================================
;=========================================================================================
(script static void ins_cell_11

	; set insertion point index 
	(set g_insertion_index 12)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)

		
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell11_player0_flag)
	(object_teleport (player1) cell11_player1_flag)
	(object_teleport (player2) cell11_player2_flag)
	(object_teleport (player3) cell11_player3_flag)

	; placing allies...
	(ai_place olifaunt/cell11)		
	(set v_olifaunt olifaunt/cell11)
	(set obj_olifaunt (ai_get_object olifaunt/cell11))
	
	(sleep 1)		
)
;=========================================================================================
;=================================== CELL 12 =========================================
;=========================================================================================
(script static void ins_cell_12

	; set insertion point index 
	(set g_insertion_index 13)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)

		
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell12_player0_flag)
	(object_teleport (player1) cell12_player1_flag)
	(object_teleport (player2) cell12_player2_flag)
	(object_teleport (player3) cell12_player3_flag)

	; placing allies...
	(ai_place olifaunt/cell12)		
	(set v_olifaunt olifaunt/cell12)
	(set obj_olifaunt (ai_get_object olifaunt/cell12))
	
	(sleep 1)		
)
;=========================================================================================
;=================================== CELL 13 =========================================
;=========================================================================================
(script static void ins_cell_13

	; set insertion point index 
	(set g_insertion_index 14)

	; switch to correct zone set unless "set_all" is loaded 
	(if (!= (current_zone_set) g_set_all)
		(begin
			(if debug (print "switching zone sets..."))
			(switch_zone_set 010)
			(sleep 1)
		)
	)

		
	; teleporting players... to the proper location 
	(if debug (print "teleporting players..."))
	(object_teleport (player0) cell13_player0_flag)
	(object_teleport (player1) cell13_player1_flag)
	(object_teleport (player2) cell13_player2_flag)
	(object_teleport (player3) cell13_player3_flag)

	; placing allies...
	(ai_place olifaunt/cell13)		
	(set v_olifaunt olifaunt/cell13)
	(set obj_olifaunt (ai_get_object olifaunt/cell13))
	
	(sleep 1)	
)
