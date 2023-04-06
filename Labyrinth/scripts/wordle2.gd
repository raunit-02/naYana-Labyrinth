extends Control

func _ready():
	$line_container.connect("game_over",self, "game_over")


func game_over(word):
	$Label.text = word.to_lower()
	$AnimationPlayer.play("fade_in")
	yield(get_tree().create_timer(5),"timeout")
	get_tree().change_scene("res://scenes/wordle3.tscn")