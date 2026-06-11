extends CanvasLayer

func _ready() -> void:
	hide()
	$VBoxContainer/Upgrade1.pressed.connect(_on_upgrade1)
	$VBoxContainer/Upgrade2.pressed.connect(_on_upgrade2)
	$VBoxContainer/Upgrade3.pressed.connect(_on_upgrade3)
	process_mode = Node.PROCESS_MODE_ALWAYS

func show_upgrades() -> void:
	show()
	get_tree().paused = true

func _on_upgrade1() -> void:
	# increase player speed
	var player = get_tree().get_first_node_in_group("player")
	player.SPEED += 50.0
	_close()

func _on_upgrade2() -> void:
	# increase player bullet damage
	var player = get_tree().get_first_node_in_group("player")
	player.bullet_damage += 15
	for bullet in player.bullet_pool.get_children():
		bullet.damage = player.bullet_damage
	_close()

func _on_upgrade3() -> void:
	# increase player fire rate
	var player = get_tree().get_first_node_in_group("player")
	player.get_node("Timer").wait_time = max(0.2, player.get_node("Timer").wait_time - 0.15)
	print(player.get_node("Timer").wait_time)
	_close()

func _close() -> void:
	get_tree().paused = false
	hide()
