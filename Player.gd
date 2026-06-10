extends CharacterBody2D

const SPEED = 300.0
var hp = 100
var xp = 0
var invincible = false


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()

func take_damage(amount : int) -> void:
	if invincible:
		return
	hp -= amount
	invincible = true
	print("Player HP: ", hp)
	if hp <= 0:
		queue_free()
		return
	await get_tree().create_timer(1.0).timeout
	invincible = false

func _on_invicibility_timer() -> void :
	invincible = false
	
