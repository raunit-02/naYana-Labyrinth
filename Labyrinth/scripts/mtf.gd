extends Control



func _ready():
	Mtfmanager.fill_deck()
	Mtfmanager.deal_deck()
	Mtfmanager.setup_timers()




