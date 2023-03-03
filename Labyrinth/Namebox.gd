extends Control

onready var line_edit = get_node("PlayerName")
var playerName=" "
func _ready():
	line_edit.grab_focus()
		
func _on_Button_pressed():
	playerName = (line_edit.text)
	queue_free()
	savepn(playerName)
	get_tree().change_scene("res://intro2.tscn")

func savepn(datatosave):
	var file = File.new()
	file.open("res://user_data/playerName.txt", File.WRITE)
	file.store_string(playerName)
	file.close()
