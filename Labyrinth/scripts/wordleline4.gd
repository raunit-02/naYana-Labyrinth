extends VBoxContainer

var file
var file_dir = "res://resources/db/substringdb.json"
var data

var rng = RandomNumberGenerator.new()

var today_word

var line_active = 0

signal game_over

func _ready():
	get_data(file_dir)
	today_word = random_word()
	
	get_child(line_active).line_status = true
	connect_to_line()


func get_data(dir):
	file = File.new()
	file.open(dir,file.READ)
	data = parse_json(file.get_as_text())

func random_word():
	rng.randomize()
	var random_id = rng.randi_range(0,3929)
	print(random_id)
	var new_word = data[random_id]["word"].to_upper()
	print(new_word)
	return new_word

func connect_to_line():
	for i in range(get_child_count()):
		get_child(i).connect("word_to_container",self,"check_word")

func check_word(word):
	print("checkword", word)
	if word == today_word:
		check_letter(word)
		emit_signal("game_over", today_word)
		print("win")
	else:
		for i in range(data.size()):
			if word == data[i]["word"].to_upper():
				print("valid")
				check_letter(word)

func check_letter(word):
	var temp_word:String = today_word
	
	for i in range(today_word.length()):
		if word[i] == today_word[i]:
			get_child(line_active).get_child(i).change_status(2)
		elif word[i] in today_word:
			get_child(line_active).get_child(i).change_status(3)
		else:
			get_child(line_active).get_child(i).change_status(1)
		
		temp_word = temp_word.replace(word[i],"")
		yield(get_tree().create_timer(0.1),"timeout")
		
	change_line()

func change_line():
	if line_active < get_child_count() -1:
		get_child(line_active).line_status = false 
		line_active += 1
		get_child(line_active).line_status = true
	else:
		print("game_over")
		yield(get_tree().create_timer(2),"timeout")
		get_tree().reload_current_scene()
		emit_signal("game over", today_word)
		













