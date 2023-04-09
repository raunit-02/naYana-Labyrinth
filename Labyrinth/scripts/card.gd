extends TextureButton

class_name Card

var value
var suit
var face
var back
 
func _ready():
	pass 

func _init(var s, var v):
	value = v
	suit = s 
	face = load("res://resources/2D_models/cards/card-"+str(suit)+"-"+str(value)+".png")
	back = Mtfmanager.cardBack
	set_normal_texture(back)

func _pressed():
	Mtfmanager.choose_card(self)

func flip():
	if get_normal_texture() == back:
		set_normal_texture(face)
	else:
		set_normal_texture(back)
