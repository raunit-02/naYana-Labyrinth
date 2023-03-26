extends Control


export var mainGameScene : PackedScene

func _on_NewGameButton_button_up():
	get_tree().change_scene(mainGameScene.resource_path)
