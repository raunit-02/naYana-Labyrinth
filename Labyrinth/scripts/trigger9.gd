extends Area

var f = File.new()

func _on_Area_body_entered(body):
	if body is KinematicBody:
		if f.file_exists("res://user_data/level9.txt"):
			pass
		else:
			f.open("res://user_data/level9.txt", File.WRITE)
			f.store_string('clear')
			f.close()
			var a = get_tree().change_scene("res://scenes/substring_pre2.tscn")
			return a