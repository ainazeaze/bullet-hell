extends Area2D

var xp_value = 10

func _ready() -> void:
	body_entered.connect(_on_body_entered) # connecting signal using code

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		XPSystem.add_xp(xp_value)
		print("XP: ", XPSystem.xp)
		queue_free()
