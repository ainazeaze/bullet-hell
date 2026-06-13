extends Node2D

@onready var upgrade_screen = $UpgradeScreen
@onready var death_screen = $DeathScreen



func _ready() -> void:
	XPSystem.leveled_up.connect(_on_leveled_up)
	$Player.died.connect(_on_player_died)
	
func _on_player_died() -> void:
	death_screen.show_death()

func _on_leveled_up() -> void:
	upgrade_screen.show_upgrades()
