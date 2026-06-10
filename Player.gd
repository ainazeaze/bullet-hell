extends CharacterBody2D

const BULLET = preload("res://Bullet.tscn")
const SPEED = 300.0
const POOL_SIZE = 20

var hp = 100
var xp = 0
var invincible = false

@onready var bullet_pool = $BulletPool

func _ready() -> void:
	for i in POOL_SIZE:
		var b = BULLET.instantiate()
		b.disable()
		bullet_pool.add_child(b)

func get_nearest_enemy() -> Node2D:
	var enemies = get_tree().get_nodes_in_group("enemy")
	var nearest = null
	var nearest_dist = INF
	for enemy in enemies:
		var dist = global_position.distance_to(enemy.global_position)
		if dist < nearest_dist:
			nearest_dist = dist
			nearest = enemy
	return nearest

func _on_timer_timeout() -> void:
	var target = get_nearest_enemy()
	if target == null:
		return
	for b in bullet_pool.get_children():
		if not b.visible:
			b.enable(global_position, (target.global_position - global_position).normalized())
			return

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()

func take_damage(amount: int) -> void:
	if invincible:
		return
	hp -= amount
	print("Player HP: ", hp)
	if hp <= 0:
		queue_free()
		return
	invincible = true
	await get_tree().create_timer(1.0).timeout
	invincible = false
