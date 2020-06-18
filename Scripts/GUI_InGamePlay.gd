extends Control

signal exit_to_menu_button


func _ready() -> void:
	setup()


func setup():
#	$ExitGame.show()	
	#$GUI_InGamePlay/CentContMessage/Message.show()
#	$CenterContainer/Label.show()
	pass
	

func update_score(text):
	$CenterContainer/Label.text = text


func _on_MessageTimer_timeout() -> void:
	#$CentContMessage/Message.text = ""
	$CentContMessage/Message.hide()


func _on_ExitToMainMenu_pressed() -> void:
	emit_signal("exit_to_menu_button")
