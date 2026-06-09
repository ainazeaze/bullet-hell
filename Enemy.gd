extends CharacterBody2D

const SPEED = 100.0

var player : Node2D = null

func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	print("Player found" , player)


func _physics_process(delta: float) -> void:
	if player == null:
		return 
	var direction = (player.global_position - global_position).normalized()
	velocity = direction * SPEED
	move_and_slide()
