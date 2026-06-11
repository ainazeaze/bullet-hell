extends Camera2D

var shake_amount = 0.0
var shake_duration = 0.0

func shake(amount: float, duration: float) -> void:
	shake_amount = amount	
	shake_duration = duration

func _process(delta: float) -> void:
	if shake_duration > 0:
		shake_duration -= delta
		offset = Vector2(
			randf_range(-shake_amount, shake_amount),
			randf_range(-shake_amount, shake_amount)
		)
	else:
		offset = Vector2.ZERO
