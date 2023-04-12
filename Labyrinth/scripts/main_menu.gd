extends Control

var d = Directory.new()
var m = 'major'
var a 
export var mainGameScene : PackedScene

var fl = ["playerName.txt",'level1.txt','level2.txt','level2.txt',
		'level3.txt','level4.txt','level5.txt','level6.txt',
		'level7.txt','level8.txt','level9.txt']

var dir = "res://user_data/"

func _on_NewGameButton_button_up():
	for i in len(fl):
		var fd = dir + fl[i]
		if d.file_exists(fd):
			d.remove(fd)
		else :
			continue
	a = get_tree().change_scene(mainGameScene.resource_path)
	return a
func _on_LoadGameButton_pressed():
	a = get_tree().change_scene("res://scenes/loadgame.tscn")
	return a

func _on_OptionsButton_pressed():
	a = get_tree().change_scene("res://scenes/options.tscn")
	return a
