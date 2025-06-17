;=============================== Bridge Detonation 

(script static void bridge_explode

	(sleep_until
		(begin

			(object_damage_damage_section bridge "base" .75)
			(sleep 30)
			(object_damage_damage_section bridge "base" .50)
			(sleep 30)
			(object_damage_damage_section bridge "base" .25)
			(sleep 30)
			(object_damage_damage_section bridge "base" 0)
			
			
			(sleep 150)
			(object_destroy bridge)
			
			(object_create bridge)

		false)
	)
)
