extends CanvasLayer

func _ready() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	$VBoxContainer/Button.pressed.connect(_on_restart)
	
func show_death() ->  void:
	show()
	get_tree().paused = true 

func _on_restart() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
