extends Node2D

signal gui_start_new_game
signal gui_exit_to_menu
signal gui_help
signal gui_options
signal gui_psyontech
signal gui_undo

var background_scenes = preload("res://Scenes/Background.tscn")
var number_scene = preload("res://Scenes/Number.tscn")
var screenSize = Vector2(0,0)
var showMenuLag = null

func _ready() -> void:
	setup()
	setup_signals()
	setup_nodes()
	add_menu_items()
	

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
#	self.rect_min_size = screenSize
#	var background_node = background_scenes.instance()
#	self.add_child(background_node)
#	background_node.set_visible(true)
	$VBoxC.rect_min_size = screenSize
#	create_numbers_on_game_field()
	print("set screen size = %s" %  screenSize)

func add_menu_items():
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("New Game",1)#	
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("5 x 5",5))
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("8 x 8",8)
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("Share",10)
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("Toggle Click Mode",2)
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("Change Theme",3)
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("Toggle AI",13)
#	$VBoxC/Menu/VBox/Buttons/Menu.add_item("Options",9)
	pass

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
	
	
func update_score():
	print("update_score(score)")
	$VBoxC/Menu/VBox/Score/Score.text = "Score: %s" % str(Main.current_score)  


func setup_signals():
	print("setup_signals()")

func create_numbers_on_game_field():
	print("create_numbers_on_game_field()")
	for colx in range(Main.game_field_size):
		for rowy in range(Main.game_field_size):
			var curr_number = number_scene.instance()
			#$GUI/VBoxC/GFContainer/GameField/VBoxContainer/ColorRect
			$VBoxC/GFContainer/GameField.add_child(curr_number)
			if Main.game_field[rowy][colx] == null:
				curr_number.set_xy(rowy, colx)
				curr_number.setup_number_rect(Main.number_rect_size)
				curr_number.set_number_text("")
				curr_number.position.x = Main.number_size * colx + Main.game_field_margin * (colx + 1)
				curr_number.position.y = Main.number_size * rowy + Main.game_field_margin * (rowy + 1)
			else:
				print("draw_field() %s " % Main.game_field[rowy][colx] as String)
				curr_number.set_xy(rowy, colx)
				curr_number.setup_number_rect(Main.number_rect_size)
				curr_number.set_number_to_label(Main.game_field[rowy][colx])
				curr_number.position.x = Main.number_size * colx + Main.game_field_margin * (colx + 1)
				curr_number.position.y = Main.number_size * rowy + Main.game_field_margin * (rowy + 1)

func reasign_numbers_to_field():
	print("reasign_numbers_to_field()")
	for colx in range(Main.game_field_size):
		for rowy in range(Main.game_field_size):
			#curr_number.window_size = $GameField.get_viewport().get_visible_rect().size
			var children_mas_number_scene =  $VBoxC/GFContainer/GameField.get_children()
			for i in range(len(children_mas_number_scene)):
				if children_mas_number_scene[i].curry_row == rowy and children_mas_number_scene[i].currx_col == colx:
					if Main.game_field[rowy][colx] == null: 
						children_mas_number_scene[i].set_number_text("")
					else:
						children_mas_number_scene[i].set_number_to_label(Main.game_field[rowy][colx])	
	update_score()


func _on_Psyontech_pressed() -> void:
	emit_signal("gui_psyontech")
	OS.shell_open("http://games.psyon.tech/")

func _on_Undo_pressed() -> void:
	emit_signal("gui_undo")

func _on_MenuB_pressed() -> void:
	$Menu.show()


func _on_Restart_pressed() -> void:
	Main.new_game()
	$Menu.hide()


func _on_8x8_pressed() -> void:
	$Menu.hide()


func _on_5x5_pressed() -> void:
	$Menu.hide()


func _on_ToggleTheme_pressed() -> void:
	$Menu.hide()


func _on_ClickMode_pressed() -> void:
	print("Change click mode")
	if Main.clickInput == true:
		Main.clickInput = false
		print("Mode %s" % Main.clickInput)
	elif Main.clickInput == false:
		Main.clickInput = true
		print("Mode %s" % Main.clickInput)
	$Menu.hide()


func _on_Options_pressed() -> void:
	$Menu.hide()


func _on_AI_pressed() -> void:
	$Menu.hide()


func _on_Share_pressed() -> void:
	$Menu.hide()


func _on_Close_pressed() -> void:
	$Menu.hide()
