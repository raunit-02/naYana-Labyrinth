extends ColorRect


var file
var file_dir = "res://resources/db/substringdb.json"
var validation = "res://resources/db/validationdb.json"
var data

var rng = RandomNumberGenerator.new()

var answer 

var c = 0

func _ready():
	get_data(file_dir)
	$Majorword.text = random_word()
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
	$linedit.text = answer
	validate(answer)

func validate(answer):
	if answer in data:
		print("kool")
	#c += 1
	#if c <= 10:
		#if answer in data:
			
	
