extends Control

signal gui_start_new_game
signal gui_exit_to_menu
signal gui_help
signal gui_options


var screenSize = Vector2(0,0)




func _ready() -> void:
	setup()
	


func setup():
	print("GUI setup()")
#	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
#	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
	self.rect_min_size = screenSize
	print("set screen size = %s" %  screenSize)
	


func show_gameover_menu(state: bool):
	$GUI_GameOver.visible = state	
	

func show_options_menu(state: bool):
	$GUI_Options.visible = state
	

func show_help_menu(state: bool):
	$GUI_Help.visible = state


func show_ingame_menu(state: bool):
	$GUI_InGamePlay.visible = state


func show_main_menu(state: bool):
	$GUI_MainMenu.visible = state


func show_message(text):
	$GUI_InGamePlay/VBoxContainer/CentContMessage/Message.text = text
	$GUI_InGamePlay/VBoxContainer/CentContMessage/Message.show()
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
	$GUI_InGamePlay/VBoxContainer/VBoxContainer/Score.text = "Score: %s" % str(score)  
	





func _on_GUI_gui_start_new_game() -> void:
	pass # Replace with function body.
