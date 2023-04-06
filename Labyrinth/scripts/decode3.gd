extends ColorRect

var file
var file_dir = "res://resources/db/scrambledb.json"
var data

var rng = RandomNumberGenerator.new()

var og_word

onready var line_edit = get_node("answer")
var answer

var fwd

func _ready():
	get_data(file_dir)
	og_word = random_word()
	$Word.text = og_word


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
	var new_word = data[random_id]["word"].to_lower()
	print(new_word)
	return new_word

func _on_Button_pressed():
	answer = (line_edit.text)
	print(answer)
	if answer == og_word:
		$Word.change_status(1)
		fwd = 0
		print("win")
		game_over(fwd)
	else:
		$Word.change_status(2)
		fwd = 1
		print("loss")
		game_over(fwd)

func game_over(binary):
	if binary == 0:
		yield(get_tree().create_timer(3),"timeout")
		get_tree().change_scene("res://scenes/decode_post.tscn")
	elif binary == 1:
		yield(get_tree().create_timer(2),"timeout")
		get_tree().reload_current_scene()
