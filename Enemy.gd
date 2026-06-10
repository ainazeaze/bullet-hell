extends CharacterBody2D

const SPEED = 100.0
const XP_GEM = preload("res://XPGem.tscn")
var hp = 30
var player : Node2D = null

@onready var area : Area2D = $Area2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	print("Player found" , player)

func take_damage(amount : int) -> void:
	hp -= amount 
	if hp <= 0:
		var gem = XP_GEM.instantiate()
		get_tree().current_scene.add_child(gem)
		gem.global_position = global_position
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


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		take_damage(30)
		
		
