extends Area

var f = File.new()

func _on_Area_body_entered(body):
	if body is KinematicBody:
		var a = get_tree().change_scene("res://scenes/game_post.tscn")
		return a
