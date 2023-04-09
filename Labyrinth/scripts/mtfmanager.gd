extends Node

onready var mtf = get_node("/root/mtf/")

var deck = Array()


var cardBack = preload("res://resources/2D_models/cards/cardBack_red2.png")

var card1
var card2

var match_timer = Timer.new()
var flip_timer = Timer.new()

var score = 0
var goal = 34

func _ready():
	fill_deck()
	deal_deck() 
	setup_timers()

func setup_timers():
	flip_timer.connect("timeout",self,"turnoverCards")
	flip_timer.set_one_shot(true)
	add_child(flip_timer)
	
	match_timer.connect("timeout",self,"matchCards")
	match_timer.set_one_shot(true)
	add_child(match_timer)

func fill_deck():
	var sl = [1,2]
	var l = '1234567890qwertuiopasdfghjklzxvbnm'
	for i in sl:
		for j in len(l):
			deck.append(Card.new(i,l[j]))

func deal_deck():
	#deck.shuffle()
	var c = 0
	while c < 68:
		mtf.get_node('grid').add_child((deck[c]))
		c = c + 1

func choose_card(var c):
	if card1 == null:
		card1 = c
		card1.flip()
	elif card2 == null:
		card2 = c
		card2.flip()
		check_cards()

func check_cards():
	if card1.value == card2.value:
		if card1.suit ==card2.suit:
			flip_timer.start(1)
		else:
			match_timer.start(1)
	else:
		flip_timer.start(1)

func turnoverCards():
	card1.flip()
	card2.flip()
	card1 = null
	card2 = null

func matchCards():
	score = score + 1
	card1.set_modulate(Color(0.6,0.6,0.6,0.5))
	card2.set_modulate(Color(0.6,0.6,0.6,0.5))
	card1 = null
	card2 = null
	print(score)
	if score == goal:
		get_tree().change_scene("res://scenes/mtf_post.tscn")
	return score
