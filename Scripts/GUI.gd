extends Control

signal start_new_game
signal exit_to_menu

func _ready() -> void:
	setup()
	


func setup():

	pass

func show_ingame_menu(state: bool):
	$GUI_InGamePlay.visible = state
#	$GUI_InGamePlay/ExitGame.show()	
#	$GUI_InGamePlay/CentContMessage/Message.show()
#	$GUI_InGamePlay/CenterContainer/Label.show()

func show_main_menu(state: bool):
	$GUI_MainMenu.visible = state
#	$GUI_MainMenu/CentContButtons/VBoxButtons/Credits.show()
#	$GUI_MainMenu/CentContButtons/VBoxButtons/ExitGame.show()
#	$GUI_MainMenu/CentContButtons/VBoxButtons/Options.show()
#	$GUI_MainMenu/CentContButtons/VBoxButtons/StartGame.show()
#	$GUI_MainMenu/CentContLabel/BestScore.show()
#	$GUI_MainMenu/CentContLabel2/GameName.show()

func show_message(text):
	$GUI_InGamePlay/CentContMessage/Message.text = text
	$GUI_InGamePlay/CentContMessage/Message.show()
	$GUI_InGamePlay/MessageTimer.start()
	
	
func show_game_over():
#	show_message("Game Over")
#	# Wait until the MessageTimer has counted down.
#	yield($GUI_InGamePlay/MessageTimer, "timeout")
#
#	show_message("Try Again!")
#	# Wait until the MessageTimer has counted down.
#	yield($GUI_InGamePlay/MessageTimer, "timeout")
#
#	$GUI_InGamePlay/Message.text = "Fibonacci!"
#	$GUI_InGamePlay/Message.show()
#	# Make a one-shot timer and wait for it to finish.
#	yield(get_tree().create_timer(1), "timeout")
#
#	$GUI_MainMenu/CenterContainer2/VBoxContainer/ExitGame.show()
#	$GUI_MainMenu/CenterContainer2/VBoxContainer/StartGame.show()
	pass
	
	
func update_score(score):
	$GUI_InGamePlay/CenterContainer/Score.text = str(score)
	




func _on_GUI_MainMenu_start_new_game() -> void:	
	emit_signal("start_new_game")


func _on_GUI_InGamePlay_exit_to_menu_button() -> void:
	emit_signal("exit_to_menu")
