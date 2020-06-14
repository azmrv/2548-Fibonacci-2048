extends Control

signal start_game
signal start_new_game

func _ready() -> void:
	pass # Replace with function body.


func show_message(text):
	$GUI_InGamePlay/Message.text = text
	$GUI_InGamePlay/Message.show()
	$GUI_InGamePlay/MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($GUI_InGamePlay/MessageTimer, "timeout")
	
	show_message("Try Again!")
	# Wait until the MessageTimer has counted down.
	yield($GUI_InGamePlay/MessageTimer, "timeout")

	$GUI_InGamePlay/Message.text = "Fibonacci!"
	$GUI_InGamePlay/Message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	
	$GUI_MainMenu/CenterContainer2/VBoxContainer/ExitGame.show()
	$GUI_MainMenu/CenterContainer2/VBoxContainer/StartGame.show()
	
func update_score(score):
	$GUI_MainMenu/CenterContainer3/BestScore.text = str(score)


func _on_StartButton_pressed():
	$GUI_MainMenu/CenterContainer2/VBoxContainer/StartGame.hide()
	$GUI_MainMenu/CenterContainer2/VBoxContainer/ExitGame.hide()
	emit_signal("start_game")

func _on_ExitButton_pressed() -> void:
	get_tree().quit()


func _on_MessageTimer_timeout():
	$GUI_InGamePlay/Message.hide()

func _on_ExitGameButton_pressed() -> void:
	pass # Replace with function body.
