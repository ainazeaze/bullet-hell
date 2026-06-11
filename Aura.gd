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
