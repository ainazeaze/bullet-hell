extends Node2D

const ENEMY = preload("res://Enemy.tscn")
const SPAWN_RADIUS = 500.0
const MIN_WAIT = 0.3

var player: Node2D = null
var elapsed = 0.0

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")

func _process(delta: float) -> void:
	elapsed += delta
	var new_wait = max(MIN_WAIT, 2.0 - elapsed * 0.05)
	$Timer.wait_time = new_wait

func _on_timer_timeout() -> void:
	if player == null:
		return
	var angle = randf() * TAU
	var offset = Vector2(cos(angle), sin(angle)) * SPAWN_RADIUS
	var enemy = ENEMY.instantiate()
	get_tree().current_scene.add_child(enemy)
	enemy.global_position = player.global_position + offset
