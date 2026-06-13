extends Area2D

const SPEED = 500.0
const MAX_LIFETIME = 3.0
var direction = Vector2.ZERO
var damage = 10
var lifetime = 0.0

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	if not visible:
		return
	lifetime += delta
	if lifetime >= MAX_LIFETIME:
		disable()
		return
	global_position += direction * SPEED * delta

func enable(pos: Vector2, dir: Vector2) -> void:
	global_position = pos
	direction = dir
	lifetime = 0.0
	visible = true
	monitoring = true

func disable() -> void:
	visible = false
	monitoring = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.take_damage(damage)
		disable.call_deferred()
