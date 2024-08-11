extends Area2D
class_name Bullet

var direction : Vector2
@export var speed := 300.0

@export var max_distance := 1500.0
var distance := 0.0:
	set(v):
		if distance >= max_distance:
			queue_free()
		else:
			distance = v
			

func _init() -> void:
	body_entered.connect(hit_player)

func _ready() -> void:
	set_as_top_level(true)

func _process(delta: float) -> void:
	move_forward(delta)
	
func move_forward(delta : float):
	direction = Vector2.RIGHT.rotated(rotation)
	position += direction * speed * delta
	distance += speed * delta
	
func aim_toward_a_point(point : Vector2):
	look_at(point)

func hit_player(body: Node2D) -> void:
	global.player_get_hit.emit()
	queue_free()
