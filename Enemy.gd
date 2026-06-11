extends CharacterBody2D

const SPEED = 100.0
const XP_GEM = preload("res://XPGem.tscn")
var hp = 30
var player : Node2D = null

@onready var area : Area2D = $Area2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")


func take_damage(amount : int) -> void:
	hp -= amount 
	modulate = Color(10, 10, 10, 1)
	await get_tree().create_timer(0.05).timeout
	modulate = Color(1, 1, 1, 1)
	if hp <= 0:
		var gem = XP_GEM.instantiate()
		get_tree().current_scene.add_child(gem)
		gem.global_position = global_position
		
		# emit particles before actually destroying the enemy scene
		var particles = $GPUParticles2D
		remove_child(particles)
		get_tree().current_scene.add_child(particles)
		particles.global_position = global_position
		particles.emitting = true
		
		queue_free()

func _physics_process(delta: float) -> void:
	if player == null:
		return 
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()
	hit_player()
	
func hit_player() -> void:
	for body in area.get_overlapping_bodies():
		if body.is_in_group("player"):
			body.take_damage(10)

		
		
