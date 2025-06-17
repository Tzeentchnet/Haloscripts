;========== Cheat Scripts ==========
(script static void cheat_cliff
	(switch_bsp 1)
	(object_teleport (player0) cheat_cliff_flag_1)
	(wake mission_cliff)
	)

(script static void cheat_rubble
	(switch_bsp 1)
	(object_teleport (player0) cheat_rubble_flag_1)
	(wake mission_cliff)
	)

(script static void cheat_river
	(switch_bsp 1)
	(object_teleport (player0) cheat_river_flag_1)
	(wake mission_cliff)
	)

(script static void test
	(switch_bsp 1)
	(object_teleport (player0) cheat_cliff_flag_1)
	(object_destroy foehammer_cliff)
	(object_create foehammer_cliff)
	(unit_set_enterable_by_player foehammer_cliff 0)
	(object_teleport foehammer_cliff foehammer_cliff_flag)
	(recording_play_and_hover foehammer_cliff foehammer_cliff_in)
	)
