extends TextureRect

export var dialogPath = ""
export(float) var textSpeed = 0.05

var dialog

var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog,"Dilog not Found")
	nextPhrase()

func _process(delta):
	$Indicator.visible = finished
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$Text.visible_characters = len($Text.text)

func getDialog() -> Array:
	var f =  File.new()
	assert(f.file_exists(dialogPath), "File does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []

func loadpn():
	var file = File.new()
	file.open("res://user_data/playerName.txt", File.READ)
	var playerName = file.get_as_text()
	return playerName

func nextPhrase() -> void:
	var playerName = loadpn()
	if phraseNum >= len(dialog):
		queue_free()
		var a = get_tree().change_scene("res://scenes/light.tscn")
		return a
	
	finished = false
	
	if dialog[phraseNum]["Name"] == "Player":
		$Name.bbcode_text = playerName
	else:
		$Name.bbcode_text = dialog[phraseNum]["Name"]
	
	if dialog[phraseNum]["Binary"] == 1:
		$Text.bbcode_text = playerName + dialog[phraseNum]["Text"]
	else:
		$Text.bbcode_text = dialog[phraseNum]["Text"]
	
	$Text.visible_characters = 0
	
	var f=File.new()
	var img = "res://resources/dialogs/home_scene/" + dialog[phraseNum]["Name"] + dialog[phraseNum]["Emotion"] + ".png"
	if f.file_exists(img):
		$Potrait.texture = load(img)
	else:
		$Potrait.texture = null
	
	while $Text.visible_characters < len($Text.text):
		$Text.visible_characters += 1
		
		$Timer.start()
		yield($Timer,"timeout")
	
	finished = true
	phraseNum += 1
	return


