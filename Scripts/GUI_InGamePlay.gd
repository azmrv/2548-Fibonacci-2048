extends Control

signal exit_game_button


func _ready() -> void:
	setup()


func setup():
	$ExitGame.show()	
	#$GUI_InGamePlay/CentContMessage/Message.show()
	$CenterContainer/Label.show()
	

func update_score(text):
	$CenterContainer/Label.text = text


func _on_MessageTimer_timeout() -> void:
	$CentContMessage/Message.text = ""
	$CentContMessage/Message.hide()


func _on_ExitGame_pressed() -> void:
	emit_signal("exit_game_button")
	$ExitGame.hide()	
	$CentContMessage/Message.hide()
	$CenterContainer/Label.hide()	
	$TextureButton.hide()
	
