extends Node

signal leveled_up

var xp = 0
var level = 1
var xp_to_next = 20

func add_xp(amount: int) -> void:
	xp += amount
	print("XP: ", xp, " / ", xp_to_next)
	if xp >= xp_to_next:
		xp -= xp_to_next
		level += 1
		xp_to_next = int(xp_to_next * 1.2)
		emit_signal("leveled_up")
