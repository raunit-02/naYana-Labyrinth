extends Label

var default = load("res://resources/highlights/defaulth.tres")
var green = load("res://resources/highlights/greenbig.tres") 
var orange = load("res://resources/highlights/orange.tres")

var array_status = [default,green,orange]

func _ready():
	change_status(0)

func change_status(status):
	$AnimationPlayer.play("flip")
	yield(get_tree().create_timer(0.3),"timeout")
	$AnimationPlayer.play("flip_back")
	theme = array_status[status]

func pop_anim():
	$AnimationPlayer.play("pop")
