extends Node2D

var f = File.new()
var a

func _ready():
	yield(get_tree().create_timer(3),"timeout")
	loadGame()

func loadGame():
	if f.file_exists("res://user_data/playerName.txt"):
		if f.file_exists("res://user_data/level1.txt"):
			if f.file_exists("res://user_data/level2.txt"):
				if f.file_exists("res://user_data/level3.txt"):
					if f.file_exists("res://user_data/level4.txt"):
						if f.file_exists("res://user_data/level5.txt"):
							if f.file_exists("res://user_data/level6.txt"):
								if f.file_exists("res://user_data/level7.txt"):
									if f.file_exists("res://user_data/level8.txt"):
										if f.file_exists("res://user_data/level9.txt"):
											 a = get_tree().change_scene("res://scenes/game_post.tscn")
										else:
											a = get_tree().change_scene("res://scenes/major9.tscn")
									else:
										a = get_tree().change_scene("res://scenes/major8.tscn")
								else:
									a = get_tree().change_scene("res://scenes/major7.tscn")
							else:
								a = get_tree().change_scene("res://scenes/major6.tscn")
						else:
							a = get_tree().change_scene("res://scenes/major5.tscn")
					else:
						a = get_tree().change_scene("res://scenes/major4.tscn")
				else:
					a = get_tree().change_scene("res://scenes/major3.tscn")
			else:
				a = get_tree().change_scene("res://scenes/major2.tscn")
		else:
			a = get_tree().change_scene("res://scenes/major.tscn")
	else:
		a = get_tree().change_scene("res://scenes/playerIntro.tscn")
	return a
