extends Area

var f = File.new()

func _on_Area_body_entered(body):
	if body is KinematicBody:
		if f.file_exists("res://user_data/level7.txt"):
			pass
		else:
			f.open("res://user_data/level7.txt", File.WRITE)
			f.store_string('clear')
			f.close()
			var a = get_tree().change_scene("res://scenes/scramble_pre2.tscn")
			return a
