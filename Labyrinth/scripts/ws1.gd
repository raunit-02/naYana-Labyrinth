extends ColorRect

var file
var file_dir = "res://resources/db/wsdb.json"
var data

var rng = RandomNumberGenerator.new()
var word_list

var size = 8


func _ready():
	get_data(file_dir)
	word_list = random_words()
	display_list(word_list)
	display_grid(word_list)

func get_data(dir):
	file = File.new()
	file.open(dir,file.READ)
	data = parse_json(file.get_as_text())

func random_words():
	var wl = []
	rng.randomize()
	var m=len(data)
	var i=0
	while i < 8 :
		i+=1
		var random_id = rng.randi_range(0,m)
		var new_word = data[random_id]["word"].to_lower()
		if len(new_word) < 8:
			wl.append(new_word)
		else:
			i=i-1
	print(wl)
	return wl

func display_list(list):
	len(list)
	$Header/VBoxContainer/word1.text = list[0]
	$Header/VBoxContainer/word2.text = list[1]
	$Header/VBoxContainer/word3.text = list[2]
	$Header/VBoxContainer/word4.text = list[3]
	$Header/VBoxContainer/word5.text = list[4]
	$Header/VBoxContainer/word6.text = list[5]
	$Header/VBoxContainer/word7.text = list[6]
	$Header/VBoxContainer/word8.text = list[7]

func display_grid(list):
	var grid = []
	for i in range(size):
		var row = []
		for j in range(size):
			row.append(" ")
		grid.append(row)
	var directions = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [-1, -1], [1, -1], [-1, 1]]
	var word_locations = {}

	# Place words horizontally, vertically, and diagonally
	for word in list:
		var word_placed = false
		while not word_placed:
			var direction = directions[randi() % directions.size()]
			if not direction in word_locations:
				word_locations[direction] = []

			var row = randi() % size
			var col = randi() % size
			var word_length = word.length()
			var end_row = row + direction[0] * (word_length - 1)
			var end_col = col + direction[1] * (word_length - 1)

			# Check if word can be placed in the grid without overlapping with other words
			if end_row >= 0 and end_row < size and end_col >= 0 and end_col < size:
				var overlapping_word = false
				for i in range(word_length):
					if grid[row + direction[0]*i][col + direction[1]*i] != " " and grid[row + direction[0]*i][col + direction[1]*i] != word[i]:
						overlapping_word = true
						break
				if not overlapping_word:
					word_placed = true

	# Fill in the rest of the grid with random letters
	var letters = "abcdefghijklmnopqrstuvwxyz"
	for row in range(size):
		for col in range(size):
			if grid[row][col] == " ":
				grid[row][col] = letters[randi() % letters.length()]

	# Print the grid
	 #print(grid)

	

	$line_container/wsline1/wsletter1.text = grid[0][0]
	$line_container/wsline1/wsletter2.text = grid[0][1]
	$line_container/wsline1/wsletter3.text = grid[0][2]
	$line_container/wsline1/wsletter4.text = grid[0][3]
	$line_container/wsline1/wsletter5.text = grid[0][4]
	$line_container/wsline1/wsletter6.text = grid[0][5]
	$line_container/wsline1/wsletter7.text = grid[0][6]
	$line_container/wsline1/wsletter8.text = grid[0][7]
	$line_container/wsline2/wsletter1.text = grid[1][0]
	$line_container/wsline2/wsletter2.text = grid[1][1]
	$line_container/wsline2/wsletter4.text = grid[1][2]
	$line_container/wsline2/wsletter5.text = grid[1][3]
	$line_container/wsline2/wsletter6.text = grid[1][4]
	$line_container/wsline2/wsletter7.text = grid[1][5]
	$line_container/wsline2/wsletter8.text = grid[1][6]
	$line_container/wsline3/wsletter1.text = grid[1][7]
	$line_container/wsline3/wsletter2.text = grid[2][0]
	$line_container/wsline3/wsletter3.text = grid[2][1]
	$line_container/wsline3/wsletter4.text = grid[2][3]
	$line_container/wsline3/wsletter5.text = grid[2][4]
	$line_container/wsline3/wsletter6.text = grid[2][5]
	$line_container/wsline3/wsletter7.text = grid[2][6]
	$line_container/wsline3/wsletter8.text = grid[2][7]
	$line_container/wsline4/wsletter1.text = grid[3][0]
	$line_container/wsline4/wsletter2.text = grid[3][1]
	$line_container/wsline4/wsletter3.text = grid[3][2]
	$line_container/wsline4/wsletter4.text = grid[3][3]
	$line_container/wsline4/wsletter5.text = grid[3][4]
	$line_container/wsline4/wsletter6.text = grid[3][5]
	$line_container/wsline4/wsletter7.text = grid[3][6]
	$line_container/wsline4/wsletter8.text = grid[3][7]
	$line_container/wsline5/wsletter1.text = grid[4][0]
	$line_container/wsline5/wsletter2.text = grid[4][1]
	$line_container/wsline5/wsletter3.text = grid[4][2]
	$line_container/wsline5/wsletter4.text = grid[4][3]
	$line_container/wsline5/wsletter5.text = grid[4][4]
	$line_container/wsline5/wsletter6.text = grid[4][5]
	$line_container/wsline5/wsletter7.text = grid[4][6]
	$line_container/wsline5/wsletter8.text = grid[4][7]
	$line_container/wsline6/wsletter1.text = grid[5][0]
	$line_container/wsline6/wsletter2.text = grid[5][1]
	$line_container/wsline6/wsletter3.text = grid[5][2]
	$line_container/wsline6/wsletter4.text = grid[5][3]
	$line_container/wsline6/wsletter5.text = grid[5][4]
	$line_container/wsline6/wsletter6.text = grid[5][5]
	$line_container/wsline6/wsletter7.text = grid[5][6]
	$line_container/wsline6/wsletter8.text = grid[5][7]
	$line_container/wsline7/wsletter1.text = grid[6][0]
	$line_container/wsline7/wsletter2.text = grid[6][1]
	$line_container/wsline7/wsletter3.text = grid[6][2]
	$line_container/wsline7/wsletter4.text = grid[6][3]
	$line_container/wsline7/wsletter5.text = grid[6][4]
	$line_container/wsline7/wsletter6.text = grid[6][5]
	$line_container/wsline7/wsletter7.text = grid[6][6]
	$line_container/wsline7/wsletter8.text = grid[6][7]
	$line_container/wsline8/wsletter1.text = grid[7][0]
	$line_container/wsline8/wsletter2.text = grid[7][1]
	$line_container/wsline8/wsletter3.text = grid[7][2]
	$line_container/wsline8/wsletter4.text = grid[7][3]
	$line_container/wsline8/wsletter5.text = grid[7][4]
	$line_container/wsline8/wsletter6.text = grid[7][5]
	$line_container/wsline8/wsletter7.text = grid[7][6]
	$line_container/wsline8/wsletter8.text = grid[7][7]


