extends CharacterBody2D

const SPEED = 100.0

var player : Node2D = null

@onready var area : Area2D = $Area2D

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	print("Player found" , player)


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
