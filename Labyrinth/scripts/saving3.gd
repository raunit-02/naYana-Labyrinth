extends Node2D
var a

func _ready():
	yield(get_tree().create_timer(3),"timeout")
	switch_scene()

func switch_scene():
	a = get_tree().change_scene("res://scenes/major3.tscn")
	return a 
