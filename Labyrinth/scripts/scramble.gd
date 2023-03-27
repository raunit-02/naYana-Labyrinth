extends ColorRect

var file
var file_dir = "res://resources/db/scrambledb.json"
var data

var rng = RandomNumberGenerator.new()

var og_word 

onready var line_edit = get_node("answer")
var answer

func _ready():
	get_data(file_dir)
	og_word = random_word()
	scramble(og_word)


func get_data(dir):
	file = File.new()
	file.open(dir,file.READ)
	data = parse_json(file.get_as_text())

func random_word():
	rng.randomize()
	var m=len(data)
	print(m)
	var random_id = rng.randi_range(0,m)
	print(random_id)
	var new_word = data[random_id]["word"].to_upper()
	print(new_word)
	return new_word

func scramble(word):
	rng.randomize()
	var l =[]
	for i in len(word):
		l.append(word[i])
	print(l)
	for i in range(0,len(word)-1):
		var p = rng.randi_range(i+1,len(word)-1)
		var temp = l[p]
		l[p] = l[i]
		l[i] = temp
	var res = ""
	for i in len(word):
		res = res + String(l[i])
	print(res)
	return res


func _on_Button_pressed():
	answer = (line_edit.text)
	print(answer)

func answer():
	if answer == og_word:
		$Label.change_status(1)
	else:
		$Label.change_status(2)

