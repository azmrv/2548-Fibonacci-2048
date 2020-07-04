extends Control

signal gui_start_new_game
signal gui_exit_to_menu
signal gui_help
signal gui_options
signal gui_psyontech


var screenSize = Vector2(0,0)
var showMenuLag = null

func _ready() -> void:
	setup()
	setup_signals()
	setup_nodes()
	
	

func setup_nodes():
	showMenuLag = Timer.new()
	showMenuLag.wait_time = 1.2
	showMenuLag.one_shot = true
	self.add_child(showMenuLag)
	
	
#Description
#Dialog for confirmation of actions. This dialog inherits from AcceptDialog, but has by default an OK and Cancel button (in host OS order).
#
#To get cancel action, you can use:
#
#get_cancel().connect("pressed", self, "cancelled").


func setup():
	print("GUI setup()")
#	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
#	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
	self.rect_min_size = screenSize
	$VBoxC.rect_min_size = screenSize
	print("set screen size = %s" %  screenSize)




func show_message(text):
	print("show_message()")
#	$GUI_InGamePlay/VBoxContainer/CentContMessage/Message.text = text
#	$GUI_InGamePlay/VBoxContainer/CentContMessage/Message.show()
#	$GUI_InGamePlay/MessageTimer.start()
	
	
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
	print("update_score(score)")
	$VBoxC/Menu/VBox/Score/Score.text = "Score: %s" % str(score)  


func setup_signals():
	print("setup_signals()")




func _on_Psyontech_pressed() -> void:
	emit_signal("gui_psyontech")
	OS.shell_open("http://games.psyon.tech/")
