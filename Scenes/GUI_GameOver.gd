extends Control


signal exit_to_menu_button
signal new_game

var screenSize = Vector2(0,0)



func _ready() -> void:
	setup()


func setup():
	print("GUI_GameOver script setup()")
#	screenSize.x = get_viewport().get_visible_rect().size.x # Get Width
#	screenSize.y = get_viewport().get_visible_rect().size.y # Get Height
	screenSize = get_viewport().get_visible_rect().size
	self.rect_min_size = screenSize
	print("set screen size = %s" %  screenSize)

	

func update_score(text):
	
	pass



func _on_NewGame_pressed() -> void:
	emit_signal("new_game")


func _on_MainMen_pressed() -> void:
	emit_signal("exit_to_menu_button")
