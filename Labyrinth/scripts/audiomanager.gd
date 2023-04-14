extends Node

func play_music(track):
	MusicPlayer.get_node('track1').stop()
	if track == 1:
		MusicPlayer.get_node('track3').stop()
		MusicPlayer.get_node('track2').play()
	elif track == 2:
		MusicPlayer.get_node('track2').stop()
		MusicPlayer.get_node('track3').play()
	else:
		pass
func set_volume(value):
	AudioServer.set_bus_volume_db(0,value)
