extends ColorRect


var file
var file_dir = "res://resources/db/substringdb.json"
var validation = "res://resources/db/validationdb.json"
var data
var word

var rng = RandomNumberGenerator.new()

var answer 
onready var line_edit = get_node("answer")

var c = -1
var n = 10
var validity 
var wl1 = []
var wl2 = []
var checker = []
var rc = []

func _ready():
	get_data(file_dir)
	word = random_word()
	$Majorword.text = word
	get_data(validation)
	


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
	rc.append(answer)
	line_edit.clear()
	check_validity(answer)
	organize(word,answer)
	check_anagram(wl1,wl2)
	display()

func check_validity(answer):
	if answer in data:
		if answer in rc:
			validity = false
		else:
			validity = true
	else:
		validity = false
	return validity

func organize(w1,w2):
	wl1.clear()
	wl2.clear()
	for i in w1:
		wl1.append(i)
	for i in wl1:
		if wl1.count(i)>1:
			wl1.erase(i)
	wl1.sort()
	print(wl1)
	
	for i in w2:
		wl2.append(i)
	for i in wl2:
		if wl2.count(i)>1:
			wl2.erase(i)
	wl2.sort()
	print(wl2)
	
func check_anagram(l1,l2):
	var anagram
	for i in l2:
		if i in l1:
			anagram = true
			checker.append(anagram)
		else:
			anagram = false
			checker.append(anagram)
	if false in checker:
		validity = false
	else:
		 validity = true
	return validity
func display():
	var line = get_node("VBoxContainer/line")
	var line2 = get_node("VBoxContainer/line2")
	c = c + 1
	n = n - 1
	if c <= 10:
		if validity == true:
			rc.append(answer)
			if c<=4:
				line.get_child(c).text = answer
			elif (4<c and c<10):
				line2.get_child(n).text = answer
		else:
			c = c-1
			n=n+1
			$Error/AnimationPlayer.play("show")
			yield(get_tree().create_timer(3),"timeout")
			$Error/AnimationPlayer.play("hide")
	if c==9:
		yield(get_tree().create_timer(3),"timeout")
		get_tree().change_scene("res://scenes/substring_post2.tscn")
	

