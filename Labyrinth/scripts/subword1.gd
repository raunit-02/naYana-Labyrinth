extends Label

func _ready():
	change_status()

func change_status():
	$AnimationPlayer.play("fade_in")
