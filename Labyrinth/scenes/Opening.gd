extends Node2D

func _ready():
	$AnimationPlayer.play("showimg")
	yield(get_tree().create_timer(5),"timeout")
	get_tree().change_scene("res://scenes/main menu.tscn")
