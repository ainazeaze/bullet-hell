extends Area2D

const DAMAGE = 5
const TICK_RATE = 0.5

var timer = 0.0

func _physics_process(delta: float) -> void:
	timer += delta
	if timer >= TICK_RATE:
		timer = 0.0
		for body in get_overlapping_bodies():
			if body.is_in_group("enemy"):
				body.take_damage(DAMAGE)

func _ready() -> void:
	var polygon = $Polygon2D
	var points = PackedVector2Array()
	var radius = 120.0
	var steps = 32
	for i in steps:
		var angle = (TAU / steps) * i
		points.append(Vector2(cos(angle), sin(angle)) * radius)
	polygon.polygon = points
	polygon.color = Color(0.3, 0.6, 1.0, 0.25)
