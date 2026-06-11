extends Node2D

@onready var upgrade_screen = $UpgradeScreen

func _ready() -> void:
	XPSystem.leveled_up.connect(_on_leveled_up)

func _on_leveled_up() -> void:
	upgrade_screen.show_upgrades()
