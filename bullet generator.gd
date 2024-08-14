class_name Bullet_Generator
extends Node2D

signal stop

@export var bullet : PackedScene

var now_dir = 0

var go_bigger = true
var to_cal := 0.0

func _init() -> void:
	stop.connect(immediatestop)

func _process(_delta: float) -> void:
	for i in range(5):
		now_dir = now_dir - to_cal + 2 * PI / 5
		generate(now_dir)
	funky_calculate(to_cal)
	wait(0.05)
		
func wait(time : float):
	set_process(false)
	await get_tree().create_timer(time).timeout
	set_process(true)
	
func generate(radian : float, pos : Vector2 = global_position):
	#since rotation is using radian, you need use PI and some math to get the angle you want.
	var b = bullet.instantiate()
	b.rotation = radian #If you want use degrees directly, change this line from "b.rotation = radian" to "b.rotation_degrees = radian"
	b.global_position = pos
	add_child(b)
	
func immediatestop():
	set_process(false)
	
func funky_calculate(value : float):
	var big_change = 0.001
	var small_change = 0.0005
	if go_bigger:
		value += big_change
			
		if value >= 0.03:
			go_bigger = false
	else:
		if value <= -0.0:
			value -= big_change * 2
		else:
			value -= small_change
			
		if value <= -0.1:
			go_bigger = true
	to_cal = value
