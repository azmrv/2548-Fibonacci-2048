extends Control


signal gui_go_exit_to_menu_button
signal gui_go_new_game

var screenSize = Vector2(0,0)



func _ready() -> void:
	setup()


func setup():
	print("GUI_GameOver setup()")
#	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
#	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
	self.rect_min_size = screenSize
	print("set screen size = %s" %  screenSize)


func update_score(score):
	print("update_score(score)")
	$VBoxLabels/VBoxLabels/Score.text = "Score: %s" % str(score)  


func _on_NewGame_pressed() -> void:
	$WaitForADs.start()



func _on_WaitForADs_timeout() -> void:
	Main.show_ads(true)
