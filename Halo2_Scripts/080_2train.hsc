(global boolean Verbose 1)

(script dormant train_run

; METHOD:
; 1 Determine the % of the track that the car has to drive to to meet up with the other car.
; 2 Take that %, subtract it from the previous % and multiply it by the total in seconds
; the total track time is 600 seconds. The First train is 8.76% of the way through the course.
(ai_place train02_AI)
(Start)
(sleep 1530)
(Train02Connected)
(ai_place train04_AI)
(sleep 4500)
(Train04Connected)
(sleep 1728)
(Train05Connected)
(sleep 3321)
(Train06Connected)
(sleep 1758)
(Train03Connected)

)
(script static void Start
(sleep 10)
(device_set_position_track t01 anim 0)
(device_animate_position t01 0.0885 51.00 0 0 false)
(device_set_position_track t02 anim 0)
(device_animate_position t02 0.0435 51.00 0 0 false)
)


(script static void Train02Connected

(device_animate_position t01 0.363 164.64 0 0 false)
(device_animate_position t02 0.33175 164.64 0 0 false)

)

(script static void Train04Connected

(device_set_position_track t04 anim 0)
(device_animate_position t04 0.0593 14.64 0 0 false)

(sleep 439)

(device_animate_position t01 0.4585 57.6 0 0 false)
(device_animate_position t02 0.432 57.6 0 0 false)
(device_animate_position t04 0.20029 57.6 0 0 false)
(device_set_position_track t05 anim 0)
(device_animate_position t05 0.11202 57.6 0 0 false)
)
(script static void Train05Connected

(device_animate_position t01 0.6430 110.7 0 0 false)
(device_animate_position t02 0.62575 110.7 0 0 false)
(device_animate_position t04 0.47266 110.7 0 0 false)
(device_animate_position t05 0.41481 110.7 0 0 false)
(device_set_position_track t06 anim 0)
(device_animate_position t06 0.2135 110.7 0 0 false)
)

(script static void Train06Connected
(device_animate_position t01 0.7408 58.6 0 0 false)
(device_animate_position t02 0.72844 58.6 0 0 false)
(device_animate_position t04 0.61707 58.6 0 0 false)
(device_animate_position t05 0.5753 58.6 0 0 false)
(device_animate_position t06 0.42948 58.6 0 0 false)
(device_set_position_track t03 anim 0)
(device_animate_position t03 0.21077 58.6 0 0 false)
)

(script static void Train03Connected
(device_animate_position t01 0.99 149.52 0 10 false)
(device_animate_position t02 0.99014 149.52 0 10 false)
(device_animate_position t04 0.98497 149.52 0 10 false)
(device_animate_position t05 0.98429 149.52 0 10 false)
(device_animate_position t06 0.98008 149.52 0 10 false)
(device_animate_position t03 0.9722 149.52 0 10 false)
)