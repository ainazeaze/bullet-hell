extends CharacterBody2D

const SPEED = 100.0
const XP_GEM = preload("res://XPGem.tscn")
const FLASH_SHADER = preload("res://flash.gdshader")
var hp = 30
var player : Node2D = null
var dying = false

@onready var area : Area2D = $Area2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	var material = ShaderMaterial.new()
	material.shader = FLASH_SHADER
	$Sprite2D.material = material

func take_damage(amount : int) -> void:
	if dying:
		return

	hp -= amount
	if hp <= 0:
		dying = true

	$Sprite2D.material.set_shader_parameter("flash", true)
	await get_tree().create_timer(0.15).timeout
	$Sprite2D.material.set_shader_parameter("flash", false)

	if dying:
		var gem = XP_GEM.instantiate()
		get_tree().current_scene.add_child(gem)
		gem.global_position = global_position
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

		
		
