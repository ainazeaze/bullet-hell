extends Area2D

const SPEED = 400.0
var direction = Vector2.ZERO

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	global_position += direction * SPEED * delta

func enable(pos: Vector2, dir: Vector2) -> void:
	global_position = pos
	direction = dir
	visible = true
	monitoring = true

func disable() -> void:
	visible = false
	monitoring = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(15)
		disable()
