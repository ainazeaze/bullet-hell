extends CharacterBody2D

const BULLET = preload("res://Bullet.tscn")
var SPEED = 300.0
var bullet_damage = 15 
const POOL_SIZE = 200

var hp = 100
var invincible = false

@onready var bullet_pool = $BulletPool
@onready var anim = $AnimatedSprite2D

signal died

func _ready() -> void:
	anim.play("idle_south")
	
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

	var target_anim = "idle_south"
	if direction == Vector2.ZERO:
		var current = anim.animation
		if current.begins_with("run_"):
			target_anim = current.replace("run_", "idle_")
		else:
			target_anim = current
	else:
		if direction.x > 0:
			target_anim = "run_right"
		elif direction.x < 0:
			target_anim = "run_left"
		elif direction.y > 0:
			target_anim = "run_south"
		elif direction.y < 0:
			target_anim = "run_north"

	if anim.animation != target_anim:
		anim.play(target_anim)

func take_damage(amount: int) -> void:
	if invincible:
		return
	hp -= amount
	$Camera2D.shake(8.0, 0.2)
	print("Player HP: ", hp)
	if hp <= 0:
		died.emit()
		queue_free()
		return
	invincible = true
	await get_tree().create_timer(1.0).timeout
	invincible = false
